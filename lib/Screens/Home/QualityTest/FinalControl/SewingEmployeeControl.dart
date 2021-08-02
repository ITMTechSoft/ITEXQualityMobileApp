import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/Dikim_InlineProcess.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/EmployeeList.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/OperationList.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/OrderSizeColorMatrix.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/EmployeeOperationList.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../../../SystemImports.dart';
import 'FinalControl.dart';

class SewingEmployeeControl extends StatefulWidget {
  Function ParentReCalc;
  Quality_ItemsBLL QualityItem;
  String HeaderName;

  SewingEmployeeControl({this.ParentReCalc, this.QualityItem, this.HeaderName});

  @override
  State<SewingEmployeeControl> createState() => _SewingEmployeeControlState();
}

class _SewingEmployeeControlState extends State<SewingEmployeeControl> {
  bool _KeepPage = false;
  bool _IsDeletedVal = false;
  List<EmployeesBLL> OperatorList;
  List<OperationBLL> OperationList;
  int IntiteStatus = 0;
  EmployeesBLL SelectedEmployee;
  OperationBLL SelectedOperation;
  bool _switchValue = false;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    OperationList =
    await OperationBLL.Get_Operation(PersonalCase.SelectedTest.Id);
    OperatorList = await EmployeesBLL.Get_Employees();
    if (OperationList != null && OperatorList != null) {
      IntiteStatus = 1;
      return true;
    } else {
      IntiteStatus = -1;
    }

    return false;
  }

  Future<List<User_QualityTracking_DetailBLL>> GetSelectedOperationOperator(
      SubCaseProvider CaseProvider) async {
    List<User_QualityTracking_DetailBLL> Critiera =
    await User_QualityTracking_DetailBLL.Get_User_QualityTracking_Detail(
        CaseProvider.QualityTracking.Id,
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
      textSize: 20,
      function: () async {
        var UserQuality = new User_QualityTracking_DetailBLL();
        UserQuality.Quality_Items_Id = widget.QualityItem.Id;
        UserQuality.QualityDept_ModelOrder_Tracking_Id =
            CaseProvider.QualityTracking.Id;
        if (SelectedEmployee != null && SelectedOperation != null) {
          UserQuality.Inline_Employee_Id = SelectedEmployee.Id;
          UserQuality.Operation_Id = SelectedOperation.Operation_Id;
          UserQuality.Create_Date = DateTime.now();
          UserQuality.Amount = 1;

          UserQuality.Set_User_QualityTracking_Dikim();

          if (_KeepPage != true)
            Navigator.pop(context);
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
                    child: Operation_List(
                      PersonalCase: PersonalCase,
                      Items: OperationList,
                      OnClickItems: (OperationBLL SelectedItem) {
                        SelectedOperation = SelectedItem;
                      },
                    ),
                  ),
                  Expanded(
                    child: Employee_List(
                      PersonalCase: PersonalCase,
                      Items: OperatorList,
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
        : FutureBuilder(
      future: GetSelectedOperationOperator(CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return EmployeeOperationList(
            PersonalCase: PersonalCase,
            Items: snapshot.data,
            OnClickItems: (int Index) async {
              var UserQuality = snapshot.data[Index];
              bool Result = await UserQuality.Delete_User_QualityTracking_Detail();

              if (Result)
                if (!_KeepPage)
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RadioSwitch(
            Lable: PersonalCase.GetLable(ResourceKey.KeepPageOpen),
            SwitchValue: _KeepPage,
            OnTap: (value) {
              _KeepPage = value;
              //IntiteStatus = 0;
            },
          ),
          GenerateRecordBtn,
          RadioSwitch(
            Lable: PersonalCase.GetLable(ResourceKey.Delete),
            SwitchValue: _IsDeletedVal,
            OnTap: (value) {
              setState(() {
                _IsDeletedVal = value;
                IntiteStatus = 0;
              });
            },
          )
        ],
      ),
    );
    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        Navigator.pop(context);
      },
          context
      ),
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
            paddingHorizontal: 0,
            paddingVertical:  0 ,
            Childrens: [HeaderAction, SizedBox(height: 15), MainPageTitle],
          ),
        ],
      ),
    );
  }
}
