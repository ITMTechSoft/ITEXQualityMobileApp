import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/Dikim_InlineControl/Dikim_InlineEmployeeOperationControl.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/EmployeeList.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/OperationList.dart';

class Dikim_EmployeeOperationMerge extends StatefulWidget {
  QualityDept_ModelOrder_TrackingBLL RoundItem;

  Dikim_EmployeeOperationMerge({required this.RoundItem});

  @override
  _Dikim_EmployeeOperationMergeState createState() =>
      _Dikim_EmployeeOperationMergeState();
}

class _Dikim_EmployeeOperationMergeState
    extends State<Dikim_EmployeeOperationMerge> {
  int IntiteStatus = 0;
  List<EmployeesBLL>? OperatorList;
  List<OperationBLL>? OperationList;
  EmployeesBLL? SelectedEmployee;
  OperationBLL? SelectedOperation;

  Exception? MainExciption;

  Future<List<OperationBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    try {
      OperationList =
      await OperationBLL.Get_Operation(PersonalCase.SelectedTest!.Id);
      OperatorList = await EmployeesBLL.Get_Employees();

      if (OperationList != null && OperatorList != null) {
        IntiteStatus = 1;
        return OperationList;
      } else {
        if (OperationList == null)
          IntiteStatus = -2;
        else if (OperatorList == null)
          IntiteStatus = -3;
        else
          IntiteStatus = -1;
      }
      return OperationList;
    } catch (MainExciption) {
      IntiteStatus = -1;
    }
    return null;
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
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle:
              Text(PersonalCase.SelectedDepartment!.Start_Date.toString()),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Employee_List(
                        PersonalCase: PersonalCase,
                        Items: OperatorList!,
                        OnClickItems: (EmployeesBLL SelectedItem) {
                          SelectedEmployee = SelectedItem;
                        },
                      )),
                      Expanded(
                          child: Operation_List(
                        PersonalCase: PersonalCase,
                        Items: OperationList!,
                        OnClickItems: (OperationBLL SelectedItem) {
                          SelectedOperation = SelectedItem;
                        },
                      )),
                    ],
                  ),
                  StandardButton(
                      Lable: PersonalCase.GetLable(ResourceKey.ControlValid),
                      ForColor: ArgonColors.white,
                      BakColor: ArgonColors.primary,
                      OnTap: () async {
                        if (SelectedEmployee != null &&
                            SelectedOperation != null) {
                          User_QualityTracking_DetailBLL? UserQuality =
                              new User_QualityTracking_DetailBLL();
                          UserQuality.QualityDept_ModelOrder_Tracking_Id =
                              widget.RoundItem.Id;
                          UserQuality.Create_Date = DateTime.now();
                          UserQuality.Operation_Id =
                              SelectedOperation!.Operation_Id;
                          UserQuality.Inline_Employee_Id = SelectedEmployee!.Id;
                          UserQuality.CheckStatus =
                              InlineOperatorStatus.Pending;

                          UserQuality = await UserQuality
                              .GenerateInlineEmployeeOperation();

                          CaseProvider.EmployeeOperation = UserQuality;
                          if (UserQuality!.Id > 0) {
                            CaseProvider.ReloadAction();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Dikim_InlineEmployeeOperationControl(
                                          IsDirect: false,
                                        )));
                          }
                        }
                      }),
                ],
              );
            } else if (IntiteStatus == 0)
              return Center(child: CircularProgressIndicator());
            else {
              if (IntiteStatus == -2)
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.OrderDataMissing),
                    MessageError: PersonalCase.GetLable(ResourceKey.OperationInformationMissed),
                    );
              else if (IntiteStatus == -3)
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.OrderDataMissing),
                    MessageError: PersonalCase.GetLable(
                        ResourceKey.EmployeeInformationMissed));
              else
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                    MessageError: PersonalCase.GetLable(
                        ResourceKey.ErrorWhileLoadingData),
                    DetailError: PersonalCase.GetLable(
                        ResourceKey.InvalidNetWorkConnection));
            }
          },
        )
      ]),
    );
  }
}
