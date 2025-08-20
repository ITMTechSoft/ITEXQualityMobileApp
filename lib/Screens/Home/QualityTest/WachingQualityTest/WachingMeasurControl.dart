import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Enum/QualityItemType.dart';
import 'package:itex_soft_qualityapp/Models/Size_Measurement_Allowance.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import '../../../../Models/Quality_NotesBLL.dart';
import '../../../../Widgets/NoteButton.dart';

class WachingMeasurControl extends StatefulWidget {
  const WachingMeasurControl({super.key});

  @override
  State<WachingMeasurControl> createState() => _WachingMeasurControlState();
}

class _WachingMeasurControlState extends State<WachingMeasurControl> {
  int IntiteStatus = 0;
  List<Size_Measurement_AllowanceBLL>? MeasurementItemList;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return Scaffold(
      appBar: DetailBar(
        Title: PersonalCase.SelectedTest!.Test_Name ?? '',
        PersonalCase: PersonalCase,
        OnTap: () {
          Navigator.pop(context);
        },
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

  Future<List<Size_Measurement_AllowanceBLL>?> LoadingMeasurement(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
  ) async {
    if (MeasurementItemList == null)
      MeasurementItemList =
          await Size_Measurement_AllowanceBLL.Get_Size_Measurement_Allowance(
            ModelOrderSize_Id: CaseProvider.ModelOrderMatrix!.Size_Id,
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
            QualityDept_ModelOrder_Tracking_Id:
                CaseProvider.QualityTracking!.Id,
            QualityTestPartId: CaseProvider.QualityTestPart!.Id,
          );

    if (MeasurementItemList != null) {
      IntiteStatus = MeasurementItemList!.isNotEmpty ? 1 : -2;
      return MeasurementItemList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget MainControl(PersonalCase, CaseProvider) {
    return FutureBuilder<List<Size_Measurement_AllowanceBLL>?>(
      future: LoadingMeasurement(PersonalCase, CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MeasuerControl(PersonalCase, CaseProvider, snapshot!.data);
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

  Widget MeasuerControl(
    personalCase,
    caseProvider,
    List<Size_Measurement_AllowanceBLL>? data,
  ) {
    final grouped = groupMeasurementItems(data ?? []);
    final groupKeys = grouped.keys.toList();
    int? selectedGroupId; // null means show all

    return StatefulBuilder(
      builder: (context, setState) {
        final items =
            selectedGroupId == null
                ? data ?? []
                : grouped[selectedGroupId] ?? [];

        return Column(
          children: [
            // Group Buttons + "All" Button
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () => setState(() => selectedGroupId = null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedGroupId == null
                                ? Colors.blue[100]
                                : Colors.grey[100],
                      ),
                      child: Text("Hepsi"),
                    ),
                  ),
                  ...groupKeys.map((groupId) {
                    final groupName =
                        grouped[groupId]!.first.Group_Name ?? "Group $groupId";
                    final isSelected = selectedGroupId == groupId;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 8,
                      ),
                      child: ElevatedButton(
                        onPressed:
                            () => setState(() => selectedGroupId = groupId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSelected ? Colors.blue[100] : Colors.grey[100],
                        ),
                        child: Text(groupName),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Filtered Items
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shadowColor: ArgonColors.black,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: MeasuermentItem(
                      personalCase,
                      caseProvider,
                      items[index],
                      () async {
                        await MeasurementPopUp(
                          context,
                          personalCase,
                          caseProvider,
                          Index: data!.indexOf(items[index]),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Map<int?, List<Size_Measurement_AllowanceBLL>> groupMeasurementItems(
    List<Size_Measurement_AllowanceBLL> items,
  ) {
    final Map<int?, List<Size_Measurement_AllowanceBLL>> grouped = {};
    for (var item in items) {
      final groupId = item.Groups_id;
      if (!grouped.containsKey(groupId)) {
        grouped[groupId] = [];
      }
      grouped[groupId]!.add(item);
    }
    return grouped;
  }

  Widget MainInformationBox(
    PersonalProvider PersonalCase,
    CaseProvider,
    context,
  ) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    width: 40,
                    height: 40,
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
      function: () {
        setState(() {});
      },
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
    if (CheckStatus == 1) key = ResourceKey.PASS;
    if (CheckStatus == -1) key = ResourceKey.FAIL;

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

  Widget MeasuermentItem(
    PersonalCase,
    CaseProvider,
    Size_Measurement_AllowanceBLL Item,
    Function()? OnTap,
  ) {
    final (
      measureLabel,
      realMeasureLabel,
      measureFarkLabel,
      statusLabel,
    ) = GetLabelsByQualityType(CaseProvider.QualityPartType, PersonalCase);

    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LableTitle(
              Item.Measurement ?? '',
              color: ArgonColors.text,
              FontSize: ArgonSize.Header5,
            ),
            Row(
              children: [
                RowItem(measureLabel, (Item.Measure ?? 0).toString(), flex: 2),
                RowItem(
                  realMeasureLabel,
                  (Item.Real_Measure ?? 0).toString(),
                  flex: 2,
                ),
                RowItem(measureFarkLabel, (Item.Pastal_Fark ?? 0).toStringAsFixed(2)),
                RowItem(PersonalCase.GetLable( ResourceKey.Percetage)
                    , Item.getPercentage(), flex: 2),
                RowWidget(statusLabel, Item.CheckStatus, PersonalCase, flex: 2),
              ],
            ),
          ],
        ),
      ),
      onTap: OnTap,
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

    ValueChanged<double> onMeasureChange = (value) {
      MeasurementItemList![Index].Measure = value;
    };
    ValueChanged<double> onRealMeasureChange = (value) {
      MeasurementItemList![Index].Real_Measure = value;
    };
    ValueChanged<String> onNoteChange = (value) {
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

    await showDialog(
      context: context,
      builder:
          (BuildContext context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LableTitle(
                        MeasurementItemList![Index].Measurement ?? '',
                        FontSize: ArgonSize.Header3,
                      ),
                      LableTitle(measureLabel),
                      SpinBox(
                        value: MeasurementItemList![Index].Measure ?? 0,
                        max: 999999,
                        decimals: 2,
                        onChanged: (val) {
                          isChanged = true;
                          setState(() => onMeasureChange(val));
                        },
                      ),
                      LableTitle(realMeasureLabel),
                      SpinBox(
                        value: MeasurementItemList![Index].Real_Measure ?? 0,
                        max: 999999,
                        decimals: 2,
                        onChanged: (val) {
                          isChanged = true;
                          setState(() => onRealMeasureChange(val));
                        },
                      ),
                      LableTitle(statusLabel),
                      ...[1, -1, 0].map((val) {
                        return CheckboxListTile(
                          title: Text(
                            personalCase.GetLable(
                              val == 1
                                  ? ResourceKey.PASS
                                  : val == -1
                                  ? ResourceKey.FAIL
                                  : ResourceKey.NOTCHECK,
                            ),
                          ),
                          value: MeasurementItemList![Index].CheckStatus == val,
                          onChanged: (v) {
                            if (v == true) {
                              setState(() {
                                MeasurementItemList![Index].CheckStatus = val;
                              });
                            }
                          },
                        );
                      }).toList(),
                      LableTitle(personalCase.GetLable(ResourceKey.Note)),
                      TextField(
                        controller: noteController,
                        onChanged: (val) => setState(() => onNoteChange(val)),
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add a note…',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  CustomButton(
                    width: getScreenWidth() / 2.5,
                    height: ArgonSize.HeightSmall1,
                    textSize: ArgonSize.Header3,
                    value: personalCase.GetLable(ResourceKey.Okay),
                    backGroundColor: ArgonColors.success,
                    function: () async {
                      if (!isChanged) {
                        onMeasureChange(
                          MeasurementItemList![Index].Measure ?? 0,
                        );
                        onRealMeasureChange(
                          MeasurementItemList![Index].Real_Measure ?? 0,
                        );
                        onNoteChange(
                          MeasurementItemList![Index].Reject_Note ?? "",
                        );
                      }

                      MeasurementItemList![Index].Pastal_Fark =
                          (MeasurementItemList![Index].Real_Measure ?? 0) -
                          (MeasurementItemList![Index].Measure ?? 0);

                      await InsertMeasurement(
                        MeasurementItemList![Index],
                        caseProvider,
                      );

                      if (IsList && (Index + 1) < MeasurementItemList!.length) {
                        setState(() {
                          Index++;
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
    var User =
        User_QualityTracking_DetailBLL()
          ..QualityDept_ModelOrder_Tracking_Id =
              CaseProvider.QualityTracking!.Id
          ..Size_Measurement_Allowance_Id = item.Id
          ..Real_Measure = item.Real_Measure
          ..Measure = item.Measure
          ..Pastal_Fark = item.Pastal_Fark
          ..CheckStatus = item.CheckStatus ?? 0
          ..Reject_Note = item.Reject_Note;
    return await User.Set_SizePartMeasurement_Allowance();
  }
}
