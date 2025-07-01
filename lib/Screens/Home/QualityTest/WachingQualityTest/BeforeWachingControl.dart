import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:itex_soft_qualityapp/Enum/QualityItemType.dart';
import 'package:itex_soft_qualityapp/Models/Size_Measurement_Allowance.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Models/Quality_NotesBLL.dart';
import 'package:itex_soft_qualityapp/Widgets/NoteButton.dart';

class BeforeWachingControl extends StatefulWidget {
  const BeforeWachingControl({super.key});

  @override
  State<BeforeWachingControl> createState() => _BeforeWachingControlState();
}

class _BeforeWachingControlState extends State<BeforeWachingControl> {
  int IntiteStatus = 0;
  List<Size_Measurement_AllowanceBLL>? MeasurementItemList;
  int? selectedGroupId;

  Future<List<Size_Measurement_AllowanceBLL>?> LoadingMeasurement(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
  ) async {
    if (MeasurementItemList == null) {
      MeasurementItemList =
          await Size_Measurement_AllowanceBLL.Get_Size_Measurement_Allowance(
            ModelOrderSize_Id: CaseProvider.ModelOrderMatrix!.Size_Id,
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
            QualityDept_ModelOrder_Tracking_Id:
                CaseProvider.QualityTracking!.Id,
            QualityTestPartId: CaseProvider.QualityTestPart!.Id,
          );
    }

    if (MeasurementItemList != null) {
      IntiteStatus = MeasurementItemList!.isNotEmpty ? 1 : -2;
      return MeasurementItemList;
    } else {
      IntiteStatus = -1;
      return null;
    }
  }

  List<MapEntry<int?, String?>> getGroupList(
    List<Size_Measurement_AllowanceBLL> data,
  ) {
    final map = <int?, String?>{};
    for (var item in data) {
      map[item.Groups_id] = item.Group_Name;
    }
    return map.entries.toList();
  }

  Widget GroupFilterButtons(
    List<Size_Measurement_AllowanceBLL> data,
    void Function(int?) onSelect,
  ) {
    final groups = getGroupList(data);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          FilterButton(
            label: "Hepsi",
            selected: selectedGroupId == null,
            onTap: () => onSelect(null),
          ),
          ...groups.map(
            (entry) => FilterButton(
              label: entry.value ?? "No Group",
              selected: selectedGroupId == entry.key,
              onTap: () => onSelect(entry.key),
            ),
          ),
        ],
      ),
    );
  }

  Widget FilterButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? ArgonColors.primary : Colors.grey[100],
          foregroundColor: selected ? Colors.white : Colors.black,
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }

  Widget MeasuermentItem(
    PersonalCase,
    CaseProvider,
    Size_Measurement_AllowanceBLL item,
    Function()? OnTap,
  ) {
    final (
      measureLabel,
      realMeasureLabel,
      _,
      statusLabel,
    ) = GetLabelsByQualityType(CaseProvider.QualityPartType, PersonalCase);

    return InkWell(
      onTap: OnTap,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LableTitle(
              item.Measurement ?? '',
              color: ArgonColors.text,
              FontSize: ArgonSize.Header5,
              IsCenter: false,
            ),
            Row(
              children: [
                RowItem(measureLabel, (item.StandardMeasure ?? '').toString()),
                RowItem(realMeasureLabel, (item.CikanMeasure ?? '').toString()),
                RowWidget(statusLabel, item.CheckStatus, PersonalCase),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget RowItem(String label, String value, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          LableTitle(label, FontSize: ArgonSize.Header7),
          LableTitle(value, color: ArgonColors.myBlue),
        ],
      ),
    );
  }

  Widget RowWidget(
    String label,
    int? CheckStatus,
    PersonalCase, {
    int flex = 1,
  }) {
    ResourceKey key = ResourceKey.NOTCHECK;
    if (CheckStatus == 1)
      key = ResourceKey.PASS;
    else if (CheckStatus == -1)
      key = ResourceKey.FAIL;
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          LableTitle(label, FontSize: ArgonSize.Header7),
          LableTitle(
            PersonalCase.GetLable(key),
            color: ArgonColors.myBlue,
            FontSize: ArgonSize.Header6,
          ),
        ],
      ),
    );
  }

  Widget MeasuerControl(
    personalCase,
    caseProvider,
    List<Size_Measurement_AllowanceBLL>? data,
  ) {
    final filtered =
        selectedGroupId == null
            ? data!
            : data!.where((e) => e.Groups_id == selectedGroupId).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GroupFilterButtons(data!, (id) => setState(() => selectedGroupId = id)),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              shadowColor: ArgonColors.black,
              child: Container(
                padding: EdgeInsets.all(10),
                child: MeasuermentItem(
                  personalCase,
                  caseProvider,
                  filtered[index],
                  () async {
                    await MeasurementPopUp(
                      context,
                      personalCase,
                      caseProvider,
                      Index: data.indexOf(filtered[index]),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  (String, String, String, String) GetLabelsByQualityType(
    int? type,
    PersonalCase,
  ) {
    switch (type) {
      case QualityPartType.Measurement:
        return (
          PersonalCase.GetLable(ResourceKey.Measure),
          PersonalCase.GetLable(ResourceKey.Real_Measure),
          PersonalCase.GetLable(ResourceKey.Measure_Fark),
          PersonalCase.GetLable(ResourceKey.Status),
        );
      case QualityPartType.BeforeWachingMeasurement:
        return (
          PersonalCase.GetLable(ResourceKey.BeforeWash_Measure),
          PersonalCase.GetLable(ResourceKey.BeforeWash_Real_Measure),
          PersonalCase.GetLable(ResourceKey.BeforeWash_Measure_Fark),
          PersonalCase.GetLable(ResourceKey.BeforeWash_Status),
        );
      case QualityPartType.AfterWachingMeasurement:
        return (
          PersonalCase.GetLable(ResourceKey.AfterWash_Measure),
          PersonalCase.GetLable(ResourceKey.AfterWash_Real_Measure),
          PersonalCase.GetLable(ResourceKey.AfterWash_Measure_Fark),
          PersonalCase.GetLable(ResourceKey.AfterWash_Status),
        );
      default:
        return ("", "", "", "");
    }
  }

  Widget MainInformationBox(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
    context,
  ) {
    return InformationBox(
      MainPage: Column(
        children: [
          CardRow(
            PersonalCase.GetLable(ResourceKey.Customer_Name),
            PersonalCase.GetLable(ResourceKey.Model_Name),
            PersonalCase.SelectedOrder!.Customer_Name ?? '',
            PersonalCase.SelectedOrder!.Model_Name ?? '',
            LabelFex: 4,
          ),
          CardRow(
            PersonalCase.GetLable(ResourceKey.ColorName),
            PersonalCase.GetLable(ResourceKey.SizeName),
            CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? '',
            CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? '',
          ),
          CardRow(
            PersonalCase.GetLable(ResourceKey.WachingCount),
            PersonalCase.GetLable(ResourceKey.ControlResult),
            CaseProvider.QualityTracking!.SampleNo.toString(),
            CaseProvider.QualityTracking!.ControlResult ?? '',
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: NoteButton(
                    width: 40.0,
                    height: 40.0,
                    onNoteSaved: (noteText) async {
                      var note = Quality_NotesBLL(
                        PersonalCase.GetCurrentUser().Id,
                        noteText,
                        QualityDepartment_ModelOrder_Id:
                            PersonalCase.SelectedOrder?.Id,
                        DepartmentModelOrder_QualityTest_Id:
                            PersonalCase.SelectedTest?.Id,
                        QualityDept_ModelOrder_Tracking_Id:
                        CaseProvider.QualityTracking?.Id,
                        QualityTestPartId: CaseProvider.QualityTestPart?.Id,
                      );
                      await note.SaveEntity();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      function: () => setState(() {}),
    );
  }

  Widget MainControl(PersonalCase, CaseProvider) {
    return FutureBuilder<List<Size_Measurement_AllowanceBLL>?>(
      future: LoadingMeasurement(PersonalCase, CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MeasuerControl(PersonalCase, CaseProvider, snapshot.data);
        } else if (IntiteStatus == 0) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ErrorPage(
            ActionName: PersonalCase.GetLable(ResourceKey.Loading),
            MessageError: PersonalCase.GetLable(
              ResourceKey.ErrorWhileLoadingData,
            ),
            DetailError: PersonalCase.GetLable(
              ResourceKey.InvalidNetWorkConnection,
            ),
          );
        }
      },
    );
  }

  Future<void> MeasurementPopUp(
    BuildContext context,
    PersonalProvider personalCase,
    SubCaseProvider caseProvider, {
    int Index = 0,
    bool IsList = false,
  }) async {
    bool isChanged = false;

    ValueChanged<String?> onMeasureChangeSpain = (value) {
      MeasurementItemList![Index].StandardMeasure = value;
    };

    ValueChanged<String?> onRealMeasureChangeSpain = (value) {
      MeasurementItemList![Index].CikanMeasure = value;
    };

    ValueChanged<String> onNotChangeSpain = (value) {
      MeasurementItemList![Index].Reject_Note = value;
    };

    final (
      measureLabel,
      realMeasureLabel,
      measureFarkLabel,
      statusLabel,
    ) = GetLabelsByQualityType(caseProvider.QualityPartType, personalCase);

    TextEditingController noteController = TextEditingController(
      text: MeasurementItemList![Index].Reject_Note ?? '',
    );

    TextEditingController standardMeasureController = TextEditingController(
      text: MeasurementItemList![Index].StandardMeasure ?? '',
    );

    TextEditingController cikanMeasureController = TextEditingController(
      text: MeasurementItemList![Index].CikanMeasure ?? '',
    );

    return await showDialog(
      context: context,
      builder:
          (BuildContext context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  margin: EdgeInsets.all(ArgonSize.normal),
                  width: getScreenWidth() * 0.9,
                  height: getScreenHeight() * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LableTitle(
                          MeasurementItemList![Index].Measurement ?? '',
                          color: ArgonColors.text,
                          FontSize: ArgonSize.Header3,
                          IsCenter: false,
                        ),
                        LableTitle(
                          measureLabel,
                          color: ArgonColors.text,
                          FontSize: ArgonSize.Header4,
                          IsCenter: false,
                        ),
                        TextField(
                          controller: standardMeasureController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged:
                              (val) => setState(() {
                                MeasurementItemList![Index].StandardMeasure =
                                    val;
                              }),
                        ),

                        LableTitle(
                          realMeasureLabel,
                          color: ArgonColors.text,
                          FontSize: ArgonSize.Header4,
                          IsCenter: false,
                        ),
                        TextField(
                          controller: cikanMeasureController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged:
                              (val) => setState(() {
                                MeasurementItemList![Index].CikanMeasure = val;
                              }),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LableTitle(
                              statusLabel,
                              color: ArgonColors.text,
                              FontSize: ArgonSize.Header4,
                              IsCenter: false,
                            ),
                            // Wrap the CheckboxListTiles in a ConstrainedBox or SizedBox to give them width
                            SizedBox(
                              width: double.infinity,
                              // makes sure they stretch within allowed space
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    title: Text(
                                      personalCase.GetLable(ResourceKey.PASS),
                                    ),
                                    value:
                                        MeasurementItemList![Index]
                                            .CheckStatus ==
                                        1,
                                    onChanged: (val) {
                                      if (val == true) {
                                        setState(() {
                                          MeasurementItemList![Index]
                                              .CheckStatus = 1;
                                        });
                                      }
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      personalCase.GetLable(ResourceKey.FAIL),
                                    ),
                                    value:
                                        MeasurementItemList![Index]
                                            .CheckStatus ==
                                        -1,
                                    onChanged: (val) {
                                      if (val == true) {
                                        setState(() {
                                          MeasurementItemList![Index]
                                              .CheckStatus = -1;
                                        });
                                      }
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      personalCase.GetLable(
                                        ResourceKey.NOTCHECK,
                                      ),
                                    ),
                                    value:
                                        MeasurementItemList![Index]
                                            .CheckStatus ==
                                        0,
                                    onChanged: (val) {
                                      if (val == true) {
                                        setState(() {
                                          MeasurementItemList![Index]
                                              .CheckStatus = 0;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        LableTitle(
                          personalCase.GetLable(ResourceKey.Note) ?? 'Note',
                          color: ArgonColors.text,
                          FontSize: ArgonSize.Header4,
                          IsCenter: false,
                        ),
                        TextField(
                          controller: noteController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add a note…',
                          ),
                          onChanged:
                              (val) => setState(() {
                                MeasurementItemList![Index].Reject_Note = val;
                              }),
                        ),
                      ],
                    ),
                  ),
                ),

                actions: <Widget>[
                  CustomButton(
                    width: getScreenWidth() / 2.5,
                    height: ArgonSize.HeightSmall1,
                    textSize: ArgonSize.Header3,
                    value: personalCase.GetLable(ResourceKey.Okay),
                    backGroundColor: ArgonColors.success,
                    function: () async {
                      if (!isChanged) {
                        onMeasureChangeSpain(
                          MeasurementItemList![Index].StandardMeasure,
                        );
                        onRealMeasureChangeSpain(
                          MeasurementItemList![Index].CikanMeasure,
                        );
                        onNotChangeSpain(
                          MeasurementItemList![Index].Reject_Note ?? "",
                        );
                      }

                      var check = await InsertMeasurement(
                        MeasurementItemList![Index],
                        caseProvider,
                      );

                      if (IsList && (Index + 1) < MeasurementItemList!.length) {
                        setState(() {
                          Index = Index + 1;
                          isChanged = false;
                        });
                      } else {
                        Navigator.of(context).pop();
                        caseProvider.ReloadAction();
                      }
                    },
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<bool> InsertMeasurement(
    Size_Measurement_AllowanceBLL item,
    SubCaseProvider CaseProvider,
  ) async {
    var User = User_QualityTracking_DetailBLL();
    User.QualityDept_ModelOrder_Tracking_Id = CaseProvider.QualityTracking!.Id;
    User.Size_Measurement_Allowance_Id = item.Id;
    User.CheckStatus = item.CheckStatus ?? 0;
    User.Reject_Note = item.Reject_Note;
    User.StandardMeasure = item.StandardMeasure;
    User.CikanMeasure = item.CikanMeasure;
    return await User.Set_SizePartMeasurement_Allowance();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return Scaffold(
      appBar: DetailBar(
        Title: PersonalCase.SelectedTest!.Test_Name ?? '',
        PersonalCase: PersonalCase,
        OnTap: () => Navigator.pop(context),
        context: context,
      ),
      body: ListView(
        children: [
          MainInformationBox(PersonalCase, CaseProvider, context),
          MainControl(PersonalCase, CaseProvider),
        ],
      ),
    );
  }
}
