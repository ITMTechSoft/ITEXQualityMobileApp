import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Home/Standard_List/Standard_Headers.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Tasnif_Amount extends StatefulWidget {
  @override
  _Tasnif_AmountState createState() => _Tasnif_AmountState();
}

class _Tasnif_AmountState extends State<Tasnif_Amount> {
  int IntiteStatus = 0;

  final TextEditingController TasnifAmountController =
  new TextEditingController();

  String ActionMessage = "";

  Future<List<OrderSizeColorDetailsBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<OrderSizeColorDetailsBLL> Criteria =
        await OrderSizeColorDetailsBLL.Get_OrderSizeColorDetails(
            PersonalCase.SelectedOrder.Order_Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget ModelOrderList(
      BuildContext cntx, PersonalProvider PersonalCase, snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int i) {
            return TasnifModelOrderMatrix(PersonalCase, snapshot.data[i], () {
              PersonalCase.SelectedMatrix = snapshot.data[i];
              setState(() {
                snapshot.data[i].IsChecked = true;
              });
              RegisterTasnifAmount(cntx, PersonalCase, snapshot.data[i], () {
                setState(() {

                });
              });
            });
          }),
    );
  }

  Widget RegisterTasnifAmount(BuildContext cntx, PersonalCase,
      OrderSizeColorDetailsBLL Item, Function Refersh) {
    showDialog(
        context: cntx,
        builder: (cntx) => AlertDialog(
              title: Text(
                  PersonalCase.GetLable(ResourceKey.RegisterTasnifAmount)),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Standard_Input(
                    prefixIcon: Icon(Icons.cut),
                    controller: TasnifAmountController,
                    Ktype: TextInputType.number,
                  ),
                  ActionMessage.isNotEmpty
                      ? Text(ActionMessage)
                      : SizedBox(
                          height: 1,
                        ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(PersonalCase.GetLable(ResourceKey.Cancel)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(PersonalCase.GetLable(ResourceKey.Save)),
                  onPressed: () async {
                    var Tasnif = new QualityDept_ModelOrder_TrackingBLL();
                    Tasnif.Id = 0;
                    Tasnif.Sample_Amount =
                        int.tryParse(TasnifAmountController.text);
                    Tasnif.Employee_Id = PersonalCase.GetCurrentUser().Id;
                    Tasnif.OrderSizeColorDetail_Id = Item.Id;
                    Tasnif.DeptModelOrder_QualityTest_Id =
                        PersonalCase.SelectedTest.Id;
                    Tasnif.ApprovalDate = DateTime.now();
                    bool Status = await Tasnif.RegisterTasnifAmount();
                    if (!Status)
                      ActionMessage =
                          PersonalCase.GetLable(ResourceKey.InvalidAction);
                    else {
                      TasnifAmountController.text = "";
                      Navigator.of(context).pop();
                    }
                    Item.OrderSizeColor_QTY =
                        (Item.OrderSizeColor_QTY ?? 0) + Tasnif.Sample_Amount;
                    Refersh();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(
              PersonalCase.SelectedTest.Test_Name +
                  ": " +
                  PersonalCase.SelectedOrder.Order_Number,
              color: ArgonColors.header,
              FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment.Start_Date.toString()),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TasnifModelOrderMatrixHeader(PersonalCase),
                    ModelOrderList(context,PersonalCase, snapshot),
                  ],
                ),
              );
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
