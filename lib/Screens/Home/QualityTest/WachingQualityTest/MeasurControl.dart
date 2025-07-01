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

class MeasurControl extends StatefulWidget {
  const MeasurControl({super.key});

  @override
  State<MeasurControl> createState() => _MeasurControlState();
}

class _MeasurControlState extends State<MeasurControl> {
  int IntiteStatus = 0;

  List<Size_Measurement_AllowanceBLL>? MeasurementItemList;

  Widget MainInformationBox(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
    context,
  ) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
            (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? ''),
            (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? ''),
          ),

          CardRow(
            PersonalCase.GetLable(ResourceKey.RafNo),
            PersonalCase.GetLable(ResourceKey.ControlResult),
            (CaseProvider.QualityTracking!.SampleTicket ?? ''),
            (CaseProvider.QualityTracking!.ControlResult ?? ''),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0), // Or any padding you prefer
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
                      print('Note saved: $noteText');
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
      if (MeasurementItemList!.length > 0)
        IntiteStatus = 1;
      else
        IntiteStatus = -2;
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
        } else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
            ActionName: PersonalCase.GetLable(ResourceKey.Loading),
            MessageError: PersonalCase.GetLable(
              ResourceKey.ErrorWhileLoadingData,
            ),
            DetailError: PersonalCase.GetLable(
              ResourceKey.InvalidNetWorkConnection,
            ),
          );
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

  Widget RowItem(String label, String value, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          LableTitle(label),
          LableTitle(value, color: ArgonColors.myBlue),
        ],
      ),
    );
  }

  Widget RowWidget(String label, int? CheckStatus, {int flex = 1}) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          LableTitle(label),
          (CheckStatus ?? 0) == 0
              ? ClipOval(
                child: Icon(
                  Icons.cancel_outlined,
                  color: ArgonColors.myRed,
                  size: ArgonSize.IconSizeMedium,
                ),
              )
              : ClipOval(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: ArgonColors.success,
                  size: ArgonSize.IconSizeMedium,
                ),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LableTitle(
              Item!.Measurement ?? '',
              color: ArgonColors.text,
              FontSize: ArgonSize.Header5,
              IsCenter: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                RowItem(measureLabel, (Item.Measure ?? 0).toString()),
                RowItem(
                  realMeasureLabel,
                  (Item.Real_Measure ?? 0).toString(),
                  flex: 2,
                ),
                RowItem(measureFarkLabel, (Item.Pastal_Fark ?? 0).toString()),
                RowWidget(statusLabel, Item.CheckStatus),
              ],
            ),
          ],
        ),
      ),
      onTap: OnTap,
    );
  }

  Widget MeasuerControl(
    personalCase,
    caseProvider,
    List<Size_Measurement_AllowanceBLL>? data,
  ) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: data!.length,
      itemBuilder: (context, int index) {
        return Card(
          elevation: 10,
          shadowColor: ArgonColors.black,
          child: Container(
            padding: EdgeInsets.all(10),
            child: MeasuermentItem(
              personalCase,
              caseProvider,
              data[index],
              () async {
                await MeasurementPopUp(
                  context,
                  personalCase,
                  caseProvider,
                  Index: index,
                );
              },
            ),
          ),
        );
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

    ValueChanged<double> onMeasureChangeSpain = (value) {
      MeasurementItemList![Index].Measure = value;
    };

    ValueChanged<double> onRealMeasureChangeSpain = (value) {
      MeasurementItemList![Index].Real_Measure = value;
    };

    final (
      measureLabel,
      realMeasureLabel,
      measureFarkLabel,
      statusLabel,
    ) = GetLabelsByQualityType(caseProvider.QualityPartType, personalCase);

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
                        SpinBox(
                          max: 999999,
                          decimals: 2,
                          textStyle: TextStyle(fontSize: ArgonSize.Header4),
                          value: MeasurementItemList![Index].Measure ?? 0,
                          onChanged: (value) {
                            isChanged = true;
                            setState(() {
                              onMeasureChangeSpain(value);
                            });
                          },
                        ),
                        LableTitle(
                          realMeasureLabel,
                          color: ArgonColors.text,
                          FontSize: ArgonSize.Header4,
                          IsCenter: false,
                        ),
                        SpinBox(
                          max: 999999,
                          decimals: 2,
                          textStyle: TextStyle(fontSize: ArgonSize.Header4),
                          value: MeasurementItemList![Index].Real_Measure ?? 0,
                          onChanged: (value) {
                            isChanged = true;
                            setState(() {
                              onRealMeasureChangeSpain(value);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LableTitle(
                              statusLabel,
                              color: ArgonColors.text,
                              FontSize: ArgonSize.Header4,
                              IsCenter: false,
                            ),
                            Switch(
                              value:
                                  (MeasurementItemList![Index].CheckStatus ==
                                      1),
                              onChanged:
                                  (val) => setState(() {
                                    MeasurementItemList![Index].CheckStatus =
                                        val ? 1 : 0;
                                  }),
                              activeColor: ArgonColors.success,
                              inactiveThumbColor: ArgonColors.myRed,
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
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add a note…',
                          ),
                          onChanged:
                              (val) => setState(() {
                                MeasurementItemList![Index].Note = val;
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
                          MeasurementItemList![Index].Measure ?? 0,
                        );
                        onRealMeasureChangeSpain(
                          MeasurementItemList![Index].Real_Measure ?? 0,
                        );
                      }

                      MeasurementItemList![Index].Pastal_Fark =
                          (MeasurementItemList![Index].Measure ?? 0) -
                          (MeasurementItemList![Index].Real_Measure ?? 0);

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
    var User = new User_QualityTracking_DetailBLL();
    User.QualityDept_ModelOrder_Tracking_Id = CaseProvider.QualityTracking!.Id;
    User.Size_Measurement_Allowance_Id = item.Id;
    User.Real_Measure = item.Real_Measure;
    User.Measure = item.Measure;
    User.Pastal_Fark = item.Pastal_Fark;
    User.CheckStatus = item.CheckStatus ?? 0;
    User.Reject_Note = item.Note;
    bool checks = await User.Set_SizePartMeasurement_Allowance();

    return checks;
  }
}
