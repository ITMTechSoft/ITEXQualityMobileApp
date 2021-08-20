import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Models/Accessory_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Accessory_Control extends StatefulWidget {
  @override
  _Accessory_ControlState createState() => _Accessory_ControlState();
}

class _Accessory_ControlState extends State<Accessory_Control> {
  int IntiteStatus = 0;
  int AssignAmount = 1;

  Future<List<Accessory_ModelOrderBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<Accessory_ModelOrderBLL>? Criteria =
        await Accessory_ModelOrderBLL.Get_Accessory_ModelOrder(
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
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

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    RefeshCurrent() {
      setState(() {});
    }

    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest!.Test_Name??'',
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(
            PersonalCase.SelectedDepartment!.Start_Date.toString()??'',
            style: TextStyle(fontSize: ArgonSize.Header6),
          ),
          dense: true,
          selected: true,
        ),
        FutureBuilder<List<Accessory_ModelOrderBLL>?>(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TableBodyGList<Accessory_ModelOrderBLL>(
                  Headers: <Widget>[
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Group)),
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Accessory),
                        Flex: 2),
                    HeaderLable(PersonalCase.GetLable(ResourceKey.Quantity)),
                    HeaderLable(
                        PersonalCase.GetLable(ResourceKey.Checks_Quantity)),
                  ],
                  Items: snapshot.data!,
                  OnClickItems: (Index) {
                    showDialog(
                        context: context,
                        builder: (cntx) => Container(
                              child: AlertDialog(
                                contentPadding: EdgeInsets.all(0.0),
                                title: Text(
                                  PersonalCase.GetLable(
                                      ResourceKey.RegisterTasnifAmount),
                                  style: TextStyle(fontSize: ArgonSize.Header3),
                                ),
                                content: Container(

                                  width: getScreenWidth() *0.7,
                                  padding: EdgeInsets.all(ArgonSize.Padding1),
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SpinBox(
                                        max: 999999,
                                        textStyle: TextStyle(
                                            fontSize: ArgonSize.Header2),
                                        value: 1,
                                        onChanged: (value) {
                                          AssignAmount = value.toInt();
                                        },
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
                                    child: Text(
                                        PersonalCase.GetLable(
                                            ResourceKey.Cancel),
                                        style: TextStyle(
                                            fontSize: ArgonSize.Header4)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                        PersonalCase.GetLable(ResourceKey.Save),
                                        style: TextStyle(
                                            fontSize: ArgonSize.Header4)),
                                    onPressed: () async {
                                      var Item = snapshot.data![Index];
                                      int Employee_Id =
                                          PersonalCase.GetCurrentUser().Id;
                                      var Tracking =
                                          new QualityDept_ModelOrder_TrackingBLL();
                                      // Tracking.Sample_Amount = int.tryParse(
                                      //     AccessoryAmountController.text);

                                      Tracking.Sample_Amount = AssignAmount;
                                      Tracking.Employee_Id = Employee_Id;
                                      Tracking.Accessory_ModelOrder_Id =
                                          Item.Id;
                                      Tracking.DeptModelOrder_QualityTest_Id =
                                          Item.DeptModelOrder_QualityTest_Id!;
                                      Tracking.ApprovalDate = DateTime.now();

                                      bool Status = await Tracking
                                          .RegisterAccessoryAmount();
                                      if (!Status)
                                        ActionMessage = PersonalCase.GetLable(
                                            ResourceKey.InvalidAction);
                                      else {
                                        //  AccessoryAmountController.text = "";
                                        AssignAmount = 1;
                                        //Item.Checks_Quantity += Tracking.Sample_Amount;
                                        Navigator.of(context).pop();
                                        RefeshCurrent();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ));
                  });
            } else if (IntiteStatus == 0)
              return Center(child: CircularProgressIndicator());
            else
              return ErrorPage(
                  ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                  MessageError:
                      PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                  DetailError: PersonalCase.GetLable(
                      ResourceKey.InvalidNetWorkConnection));
          },
        )
      ]),
    );
  }
}
