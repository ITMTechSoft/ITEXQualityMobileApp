import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/ProviderCase/Dikim_InlineProcess.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/EmployeeList.dart';
import 'package:itex_soft_qualityapp/assets/SystemDropDownList/OperationList.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../../../SystemImports.dart';
import 'FinalControl.dart';

class DikimControl extends StatefulWidget {
  @override
  State<DikimControl> createState() => _DikimControlState();
  bool _switchValue = false;
}

class _DikimControlState extends State<DikimControl> {
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

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: MyAppBar(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomText(
                  text: "Dikim Kontrolo",
                  size: 30,
                  textDecoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(
                    'Hatalar Tekrar Ekle',
                    style: TextStyle(
                        color: ArgonColors.myBlue, fontWeight: FontWeight.bold),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: widget._switchValue,
                      onChanged: (value) {
                        setState(() {
                          widget._switchValue = value;
                          print("Status ${widget._switchValue}");
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 1, color: ArgonColors.myGreen),
                      ),
                      child: IconInsideCircle(
                          icon: FontAwesomeIcons.plus,
                          color: Colors.white,
                          backGroundColor: ArgonColors.myLightBlue),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 1, color: ArgonColors.myGreen),
                      ),
                      child: IconInsideCircle(
                          icon: FontAwesomeIcons.minus,
                          color: Colors.white,
                          backGroundColor: ArgonColors.myRed),
                    ),
                  ]),
            ),
          ),
          SizedBox(height: 15),
          FutureBuilder(
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
                          ),),
                        Expanded(
                            child: Employee_List(
                          PersonalCase: PersonalCase,
                          Items: OperatorList,
                          OnClickItems: (EmployeesBLL SelectedItem) {
                            SelectedEmployee = SelectedItem;
                          },
                        ),),

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
          ),
        ],
      ),
    );
  }
}
