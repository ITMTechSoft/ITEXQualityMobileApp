import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Models/Accessory_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Accessory_Control extends StatefulWidget {
  @override
  _Accessory_ControlState createState() => _Accessory_ControlState();
}

class _Accessory_ControlState extends State<Accessory_Control> {
  int IntiteStatus = 0;
  int CorrectAmount = 0;
  int ErrorAmount = 0;
  bool _IsDeletedVal = false;

  Future<List<Accessory_ModelOrderBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<Accessory_ModelOrderBLL>? Criteria =
        await Accessory_ModelOrderBLL.Get_Accessory_ModelOrder(
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id);

    if (Criteria != null) {
      if (Criteria.length > 0)
        IntiteStatus = 1;
      else
        IntiteStatus = -2;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  RegisterAccessoryData(
      PersonalCase, Accessory_ModelOrderBLL Item, int Employee_Id) async {}

  final TextEditingController AccessoryAmountController =
      new TextEditingController();

  String ActionMessage = "";

  double GetMaxAmount(Accessory_ModelOrderBLL? item,
      {bool IsDelete = false, bool IsError = false}) {
    if (item != null) {
      if (IsDelete) if (IsError)
        return (item.Error_Amount ?? 0).toDouble();
      else
        return (item.Correct_Amount ?? 0).toDouble();
      else
        return 9999999;
    }
    return 0.toDouble();
  }

  showAlertDailog(
      PersonalProvider PersonalCase, Accessory_ModelOrderBLL? item,Function Refesh) {
    final TextEditingController NoteController = new TextEditingController();

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  PersonalCase.GetLable(ResourceKey.RegisterTasnifAmount),
                  style: TextStyle(fontSize: ArgonSize.Header3),
                ),
                content: Container(
                  width: getScreenWidth() * 0.7,
                  padding: EdgeInsets.all(ArgonSize.Padding1),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RadioSwitch(
                        Lable: PersonalCase.GetLable(ResourceKey.Delete),
                        SwitchValue: _IsDeletedVal,
                        OnTap: (value) {
                          setState(() {
                            _IsDeletedVal = value;
                          });
                        },
                      ),
                      Column(
                        children: [
                          LableTitle(PersonalCase.GetLable(
                              ResourceKey.Correct_Amount)),
                          SpinBox(
                            max: GetMaxAmount(item, IsDelete: _IsDeletedVal),
                            textStyle: TextStyle(fontSize: ArgonSize.Header2),
                            value: 0,
                            onChanged: (value) {
                              CorrectAmount = value.toInt();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          LableTitle(
                              PersonalCase.GetLable(ResourceKey.Error_Amount)),
                          SpinBox(
                            max: GetMaxAmount(item,
                                IsDelete: _IsDeletedVal, IsError: true),
                            textStyle: TextStyle(fontSize: ArgonSize.Header2),
                            value: 0,
                            onChanged: (value) {
                              ErrorAmount = value.toInt();
                            },
                          ),
                        ],
                      ),
                      Container(
                        width: getScreenWidth() * 0.7,
                        height: getScreenHeight() * 0.3,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
                        child:
                        TextFormField(
                          controller: NoteController,
                          keyboardType: TextInputType.multiline,
                          decoration: new InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
                              child: Icon(Icons.event_note),
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          minLines: 1,
                          maxLines: 10,
                        ),
                      ),
                      ActionMessage.isNotEmpty
                          ? Text(ActionMessage)
                          : SizedBox(
                              height: 1,
                            ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(PersonalCase.GetLable(ResourceKey.Cancel),
                        style: TextStyle(fontSize: ArgonSize.Header4)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(PersonalCase.GetLable(ResourceKey.Save),
                        style: TextStyle(fontSize: ArgonSize.Header4)),
                    onPressed: () async {
                      // var Item = item;
                      int Employee_Id = PersonalCase.GetCurrentUser().Id;
                      var Tracking = new QualityDept_ModelOrder_TrackingBLL();
                      // Tracking.Sample_Amount = int.tryParse(
                      //     AccessoryAmountController.text);

                      CorrectAmount = CorrectAmount * (_IsDeletedVal ? -1 : 1);
                      ErrorAmount = ErrorAmount * (_IsDeletedVal ? -1 : 1);

                      Tracking.Sample_Amount = CorrectAmount + ErrorAmount;
                      Tracking.Correct_Amount = CorrectAmount;
                      Tracking.Error_Amount = ErrorAmount;
                      Tracking.Employee_Id = Employee_Id;
                      Tracking.Accessory_ModelOrder_Id = item!.Id;
                      Tracking.DeptModelOrder_QualityTest_Id =
                          item.DeptModelOrder_QualityTest_Id;
                      Tracking.ApprovalDate = DateTime.now();
                      Tracking.Tracking_Note = NoteController.text;
                      bool Status = await Tracking.RegisterAccessoryAmount();
                      if (!Status)
                        ActionMessage =
                            PersonalCase.GetLable(ResourceKey.InvalidAction);
                      else {
                        //  AccessoryAmountController.text = "";
                        ErrorAmount = CorrectAmount = 0;
                        //Item.Checks_Quantity += Tracking.Sample_Amount;
                        Navigator.of(context).pop();
                        Refesh();
                      }
                    },
                  ),
                ],
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    RefeshCurrent() {
      setState(() {});
      _IsDeletedVal = false;
    }

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
          subtitle: Text(
            PersonalCase.SelectedDepartment!.Start_Date.toString(),
            style: TextStyle(fontSize: ArgonSize.Header6),
          ),
          dense: true,
          selected: true,
        ),
        FutureBuilder<List<Accessory_ModelOrderBLL>?>(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData && IntiteStatus != -2) {
              return TableBodyGList<Accessory_ModelOrderBLL>(
                  Headers: <Widget>[
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Group)),
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Accessory),
                        Flex: 2),
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Quantity)),
                    HeaderLable(
                        PersonalCase.GetLable(ResourceKey.Checks_Quantity)),
                    HeaderLable(PersonalCase.GetLable(ResourceKey.ErrorAmount)),
                  ],
                  Items: snapshot.data!,
                  OnClickItems: (Index) {
                    showAlertDailog(PersonalCase, snapshot.data![Index],RefeshCurrent);
                  });
            } else
              return LoadingContainer(IntiteStatus: IntiteStatus);
          },
        )
      ]),
    );
  }
}
