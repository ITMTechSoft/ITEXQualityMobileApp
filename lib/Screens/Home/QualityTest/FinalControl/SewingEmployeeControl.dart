import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/EmployeeList.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/OperationList.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/EmployeeOperationList.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../../../SystemImports.dart';

class SewingEmployeeControl extends StatefulWidget {
  Function ParentReCalc;
  Quality_ItemsBLL QualityItem;
  String HeaderName;

  SewingEmployeeControl(
      {required this.ParentReCalc,
      required this.QualityItem,
      required this.HeaderName});

  @override
  State<SewingEmployeeControl> createState() => _SewingEmployeeControlState();
}

class _SewingEmployeeControlState extends State<SewingEmployeeControl> {
  bool _KeepPage = false;
  bool _IsDeletedVal = false;
  List<EmployeesBLL>? OperatorList;
  List<OperationBLL>? OperationList;
  int IntiteStatus = 0;
  EmployeesBLL? SelectedEmployee;
  OperationBLL? SelectedOperation;
  bool _switchValue = false;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    OperationList =
        await OperationBLL.Get_Operation(PersonalCase.SelectedTest!.Id);
    OperatorList = await EmployeesBLL.Get_Employees();
    if (OperationList != null && OperatorList != null) {
      IntiteStatus = 1;
      return true;
    } else {
      IntiteStatus = -1;
    }

    return false;
  }

  Future<List<User_QualityTracking_DetailBLL>?> GetSelectedOperationOperator(
      SubCaseProvider CaseProvider) async {
    List<User_QualityTracking_DetailBLL>? Critiera =
        await User_QualityTracking_DetailBLL.Get_User_QualityTracking_Detail(
            CaseProvider.QualityTracking!.Id,
            Quality_Items_Id: widget.QualityItem.Id);
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

    var GenerateRecordBtn = _IsDeletedVal == false
        ? CustomButton(
            value: PersonalCase.GetLable(ResourceKey.Add),
            textColor: Colors.white,
            width: getScreenWidth() / 2,
            height: 60,
            backGroundColor: ArgonColors.myGreen,
            textSize: ArgonSize.Header3,
            function: () async {
              var UserQuality = new User_QualityTracking_DetailBLL();
              UserQuality.Quality_Items_Id = widget.QualityItem.Id;
              UserQuality.QualityDept_ModelOrder_Tracking_Id =
                  CaseProvider.QualityTracking!.Id;
              if (SelectedEmployee != null && SelectedOperation != null) {
                UserQuality.Inline_Employee_Id = SelectedEmployee!.Id;
                UserQuality.Operation_Id = SelectedOperation!.Operation_Id;
                UserQuality.Create_Date = DateTime.now();
                UserQuality.Amount = 1;

                UserQuality.Set_User_QualityTracking_Dikim();

                if (_KeepPage != true) Navigator.pop(context);
              } else {
                AlertPopupDialog(
                    context,
                    PersonalCase.GetLable(ResourceKey.MandatoryFields),
                    PersonalCase.GetLable(ResourceKey.PleaseChooseValue),
                    ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
              }
            },
          )
        : Container();

    var MainPageTitle = _IsDeletedVal == false
        ? FutureBuilder(
            future: LoadingOpenPage(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Operation_List(
                            PersonalCase: PersonalCase,
                            Items: OperationList!,
                            OnClickItems: (OperationBLL SelectedItem) {
                              SelectedOperation = SelectedItem;
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Employee_List(
                            PersonalCase: PersonalCase,
                            Items: OperatorList!,
                            OnClickItems: (EmployeesBLL SelectedItem) {
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
                  ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                  MessageError:
                      PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                  DetailError: PersonalCase.GetLable(
                      ResourceKey.InvalidNetWorkConnection),
                );
            },
          )
        : FutureBuilder<List<User_QualityTracking_DetailBLL>?>(
            future: GetSelectedOperationOperator(CaseProvider),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return EmployeeOperationList(
                  PersonalCase: PersonalCase,
                  Items: snapshot.data,
                  OnClickItems: (int Index) async {
                    var UserQuality = snapshot.data![Index];
                    bool Result =
                        await UserQuality.Delete_User_QualityTracking_Detail();

                    if (Result) if (!_KeepPage)
                      Navigator.pop(context);
                    else
                      setState(() {});
                    else
                      AlertPopupDialog(
                          context,
                          PersonalCase.GetLable(ResourceKey.Invalid),
                          PersonalCase.GetLable(ResourceKey.InvalidAction),
                          ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
                  },
                );
              } else if (IntiteStatus == 0)
                return Center(child: CircularProgressIndicator());
              else
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                    MessageError: PersonalCase.GetLable(
                        ResourceKey.ErrorWhileLoadingData),
                    DetailError: PersonalCase.GetLable(
                        ResourceKey.InvalidNetWorkConnection));
            },
          );

    var HeaderAction = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: RadioSwitch(
                    Lable: PersonalCase.GetLable(ResourceKey.KeepPageOpen),
                    SwitchValue: _KeepPage,
                    OnTap: (value) {
                      _KeepPage = value;
                      //IntiteStatus = 0;
                    },
                  ),
                ),
                getScreenWidth() >= 500
                    ? Expanded(flex: 1, child: GenerateRecordBtn)
                    : Container(),
                Expanded(
                  flex: 1,
                  child: RadioSwitch(
                    Lable: PersonalCase.GetLable(ResourceKey.Delete),
                    SwitchValue: _IsDeletedVal,
                    OnTap: (value) {
                      setState(() {
                        _IsDeletedVal = value;
                        IntiteStatus = 0;
                      });
                    },
                  ),
                )
              ],
            ),
            getScreenWidth() < 500
                ? Padding(
                    padding: EdgeInsets.only(top: ArgonSize.Padding3),
                    child: GenerateRecordBtn,
                  )
                : Container(),
          ],
        ));
    return Scaffold(
        appBar: DetailBar(
            Title: PersonalCase.SelectedTest!.Test_Name ?? '',
            PersonalCase: PersonalCase,
            OnTap: () {
              Navigator.pop(context);
            },
            context: context),
        body: Container(
          height: getScreenHeight(),
          child: ListView(children: [
            ListTile(
              title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
                  color: ArgonColors.header, FontSize: ArgonSize.Header2),
              subtitle:
                  Text(PersonalCase.SelectedDepartment!.Start_Date.toString()),
              dense: true,
              selected: true,
            ),
            BoxMaterialCard(
              paddingHorizontal: 0,
              paddingVertical: 0,
              Childrens: [HeaderAction, SizedBox(height: 15), MainPageTitle],
            ),

            //  Expanded(flex:1,child: HeaderAction),
            //  //SizedBox(height: 15),
            // Expanded(flex:3,child: MainPageTitle)
          ]),
        ));
  }
}
