import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/Dikim_InlineProcess.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/EmployeeList.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/OperationList.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/OrderSizeColorMatrix.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/table.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../../../SystemImports.dart';
import 'FinalControl.dart';

class SewingEmployeeControl extends StatefulWidget {
  Function ParentReCalc;
  String GroupType;
  String HeaderName;

  SewingEmployeeControl({this.ParentReCalc, this.GroupType, this.HeaderName});

  @override
  State<SewingEmployeeControl> createState() => _SewingEmployeeControlState();
  bool _switchValue = false;
}

class _SewingEmployeeControlState extends State<SewingEmployeeControl> {
  bool _KeepPage = false;
  bool _IsDeletedVal = false;
  List<EmployeesBLL> OperatorList;
  List<OperationBLL> OperationList;
  int IntiteStatus = 0;
  EmployeesBLL SelectedEmployee;
  OperationBLL SelectedOperation;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    OperationList = await OperationBLL.Get_Operation(1);
    OperatorList = await EmployeesBLL.Get_Employees();

    if (OperationList != null && OperatorList != null) {
      IntiteStatus = 1;
      return true;
    } else {
      IntiteStatus = -1;
    }
    return false;
  }

  Future<List<OrderSizeColorDetailsBLL>> LoadingOpenPage1(
      PersonalProvider PersonalCase) async {
    List<OrderSizeColorDetailsBLL> Critiera =
        await OrderSizeColorDetailsBLL.Get_OrderSizeColorDetails(
            PersonalCase.SelectedOrder.Order_Id);

    if (Critiera != null) {
      IntiteStatus = 1;
      return Critiera;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(PersonalCase.SelectedOrder.Order_Number,
                color: ArgonColors.header, FontSize: ArgonSize.Header2),
            subtitle:
                Text(PersonalCase.SelectedDepartment.Start_Date.toString()),
            dense: true,
            selected: true,
          ),
          BoxMaterialCard(
            paddingValue: 0,
            Childrens: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      CustomText(
                        text: PersonalCase.GetLable(ResourceKey.KeepPageOpen),
                        color: ArgonColors.myBlue,
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: _KeepPage,
                          onChanged: (value) {
                            setState(() {
                              _KeepPage = value;
                            });
                          },
                        ),
                      ),
                    ]),
                    Column(children: [
                      CustomText(
                        text: PersonalCase.GetLable(ResourceKey.Delete),
                        color: ArgonColors.myBlue,
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: _IsDeletedVal,
                          onChanged: (value) {
                            setState(() {
                              _IsDeletedVal = value;
                              IntiteStatus = 0 ;
                            });
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              _IsDeletedVal == false
                  ?
              GestureDetector(
                      onTap: () {
                        if (_KeepPage == true) {
                          print('Keep page ');
                          setState(() {
                            SelectedEmployee = null ;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: ButtonWithNumber(
                        text: PersonalCase.GetLable(ResourceKey.Add),
                        textColor: Colors.white,
                        buttonWidth: getScreenWidth() / 2,
                        buttonHegiht: 60,
                        btnBgColor: ArgonColors.myGreen,
                        textSize: 20,


                      ),
                    )
                  : Container(),
              SizedBox(height: 15),
              _IsDeletedVal == false
                  ? FutureBuilder(
                      future: LoadingOpenPage(PersonalCase),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Operation_List(
                                      PersonalCase: PersonalCase,
                                      Items: OperationList,
                                      OnClickItems:
                                          (OperationBLL SelectedItem) {
                                        SelectedOperation = SelectedItem;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Employee_List(
                                      PersonalCase: PersonalCase,
                                      Items: OperatorList,
                                      OnClickItems:
                                          (EmployeesBLL SelectedItem) {
                                        SelectedEmployee = SelectedItem;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (IntiteStatus == 0)
                          return Center(child: CircularProgressIndicator());
                        else
                          return ErrorPage(
                            ActionName:
                                PersonalCase.GetLable(ResourceKey.Loading),
                            MessageError: PersonalCase.GetLable(
                                ResourceKey.ErrorWhileLoadingData),
                            DetailError: PersonalCase.GetLable(
                                ResourceKey.InvalidNetWorkConnection),
                          );
                      },
                    )
                  : FutureBuilder(
                      future: LoadingOpenPage1(PersonalCase),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return table(
                            PersonalCase: PersonalCase,
                            Items: list,
                            OnClickItems: (int Index) async {
                              CaseProvider.ModelOrderMatrix =
                                  snapshot.data[Index];
                              CaseProvider.QualityTracking =
                                  await QualityDept_ModelOrder_TrackingBLL
                                      .GetOrCreate_QualityDept_ModelOrder_Tracking(
                                          PersonalCase.GetCurrentUser().Id,
                                          PersonalCase.SelectedTest.Id,
                                          OrderSizeColorDetail_Id:
                                              CaseProvider.ModelOrderMatrix.Id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FinalControl()));
                            },
                          );
                        } else if (IntiteStatus == 0)
                          return Center(child: CircularProgressIndicator());
                        else
                          return ErrorPage(
                              ActionName:
                                  PersonalCase.GetLable(ResourceKey.Loading),
                              MessageError: PersonalCase.GetLable(
                                  ResourceKey.ErrorWhileLoadingData),
                              DetailError: PersonalCase.GetLable(
                                  ResourceKey.InvalidNetWorkConnection));
                      },
                    )
            ],
          ),
        ],
      ),
    );
  }
}

class test {
  test(this.operation, this.operator, this.date);

  String operation;

  String operator;

  String date;
}

final List<test> list = [
  test('operation1', 'operator1', '1-2-2021'),
  test('operation2', 'operator2', '1-2-2021'),
  test('operation3', 'operator3', '1-2-2021'),
  test('operation4', 'operator4', '1-2-2021'),
  test('operation5', 'operator5', '1-2-2021'),
  test('operation22', 'operator16', '1-2-2021'),
  test('operation1', 'operator1', '1-2-2021'),
  test('operation2', 'operator2', '1-2-2021'),
  test('operation3', 'operator3', '1-2-2021'),
  test('operation4', 'operator4', '1-2-2021'),
  test('operation5', 'operator5', '1-2-2021'),
  test('operation6', 'operator16', '1-2-2021'),
  test('operation1', 'operator1', '1-2-2021'),
  test('operation2', 'operator2', '1-2-2021'),
  test('operation3', 'operator3', '1-2-2021'),
  test('operation4', 'operator4', '1-2-2021'),
  test('operation5', 'operator5', '1-2-2021'),
  test('operation6', 'operator16', '1-2-2021'),
  test('operation1', 'operator1', '1-2-2021'),
  test('operation2', 'operator2', '1-2-2021'),
  test('operation3', 'operator3', '1-2-2021'),
  test('operation4', 'operator4', '1-2-2021'),
  test('operation5', 'operator5', '1-2-2021'),
  test('operation6', 'operator16', '1-2-2021'),
];
