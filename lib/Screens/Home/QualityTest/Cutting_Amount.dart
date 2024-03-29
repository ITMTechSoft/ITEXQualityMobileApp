import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Screens/Home/Standard_List/Standard_Headers.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Cutting_Amount extends StatefulWidget {
  @override
  _Cutting_AmountState createState() => _Cutting_AmountState();
}

class _Cutting_AmountState extends State<Cutting_Amount> {
  int IntiteStatus = 0;

  final TextEditingController CuttingAmountController = new TextEditingController();

  String ActionMessage="";

  Future<List<OrderSizeColorDetailsBLL>> LoadingQualityTest(
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

  Widget RegisterCuttingAmount(BuildContext cntx, PersonalCase,
      OrderSizeColorDetailsBLL Item, Function Refersh) {
    showDialog(
        context: cntx,
        builder: (cntx) => AlertDialog(
      title: Text(PersonalCase.GetLable(ResourceKey.RegisterCuttingAmount)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Standard_Input(
            prefixIcon: Icon(Icons.cut),
            controller: CuttingAmountController,
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
            var Cutting = new QualityDept_ModelOrder_TrackingBLL();
            Cutting.Id = 0;
            Cutting.Sample_Amount = int.tryParse(CuttingAmountController.text);
            Cutting.Employee_Id = PersonalCase.GetCurrentUser().Id;
            Cutting.OrderSizeColorDetail_Id = Item.Id;
            Cutting.DeptModelOrder_QualityTest_Id =
                PersonalCase.SelectedTest.Id;
            Cutting.ApprovalDate = DateTime.now();
            bool Status = await Cutting.RegisterCuttingAmount();
            if (!Status)
              ActionMessage = PersonalCase.GetLable(ResourceKey.InvalidAction);
            else {
              CuttingAmountController.text = "";
              Navigator.of(context).pop();
            }
            Item.SizeColor_QTY =
                (Item.SizeColor_QTY ?? 0) + Cutting.Sample_Amount;
            Refersh();
          },
        ),
      ],
    ));
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
            return CuttingModelOrderMatrix(PersonalCase, snapshot.data[i], () {
              PersonalCase.SelectedMatrix = snapshot.data[i];
              setState(() {
                snapshot.data[i].IsChecked = true;
              });
              RegisterCuttingAmount(cntx, PersonalCase, snapshot.data[i], () {
                setState(() {});
              });
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(
          PersonalCase.GetLable(ResourceKey.CuttingAmount), PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(
                PersonalCase.SelectedTest.Test_Name +
                    ": " +
                    PersonalCase.SelectedOrder.Order_Number,
                color: ArgonColors.header,
                FontSize: ArgonSize.Header2),
            subtitle:
                Text(PersonalCase.SelectedDepartment.Start_Date.toString()),
            dense: true,
            selected: true,
          ),
          FutureBuilder(
            future: LoadingQualityTest(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ModelOrderMatrixHeader(PersonalCase),
                      ModelOrderList(context, PersonalCase, snapshot),
                    ],
                  ),
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
          )
        ],
      ),
    );
  }
}

class CuttingMatrixDataTable extends StatefulWidget {
  List<OrderSizeColorDetailsBLL> Items;
  PersonalProvider PersonalCase;

  CuttingMatrixDataTable(this.Items, this.PersonalCase);

  @override
  _CuttingMatrixDataTableState createState() => _CuttingMatrixDataTableState();
}

class _CuttingMatrixDataTableState extends State<CuttingMatrixDataTable> {
  final TextEditingController CuttingAmountController =
      new TextEditingController();
  List<OrderSizeColorDetailsBLL> SelectedItems;
  bool sort;

  String ActionMessage = "";

  @override
  void initState() {
    sort = false;
    SelectedItems = [];
    super.initState();
  }

  WrapColumn(String Lable, {Isnumeric = false}) => DataColumn(
        label: Expanded(
            child: Container(
          alignment: Alignment.center,
          child: Text(
            Lable,
            style: TextStyle(color: ArgonColors.Title),
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
        )),
        numeric: Isnumeric,
        tooltip: Lable,
      );

  Widget _buildPopupDialog(BuildContext context, PersonalCase,
      OrderSizeColorDetailsBLL Item, Function Refersh) {
    return new AlertDialog(
      title: Text(PersonalCase.GetLable(ResourceKey.RegisterCuttingAmount)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Standard_Input(
            prefixIcon: Icon(Icons.cut),
            controller: CuttingAmountController,
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
            var Cutting = new QualityDept_ModelOrder_TrackingBLL();
            Cutting.Id = 0;
            Cutting.Sample_Amount = int.tryParse(CuttingAmountController.text);
            Cutting.Employee_Id = PersonalCase.GetCurrentUser().Id;
            Cutting.OrderSizeColorDetail_Id = Item.Id;
            Cutting.DeptModelOrder_QualityTest_Id =
                PersonalCase.SelectedTest.Id;
            Cutting.ApprovalDate = DateTime.now();
            bool Status = await Cutting.RegisterCuttingAmount();
            if (!Status)
              ActionMessage = PersonalCase.GetLable(ResourceKey.InvalidAction);
            else {
              CuttingAmountController.text = "";
              Navigator.of(context).pop();
            }
            Item.SizeColor_QTY =
                (Item.SizeColor_QTY ?? 0) + Cutting.Sample_Amount;
            Refersh();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SingleChildScrollView DataBody(PersonalCase) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortAscending: sort,
          sortColumnIndex: 0,
          showCheckboxColumn: false,
          columns: [
            WrapColumn(PersonalCase.GetLable(ResourceKey.SizeName)),
            WrapColumn(PersonalCase.GetLable(ResourceKey.ColorName)),
            WrapColumn(PersonalCase.GetLable(ResourceKey.PlanningAmount)),
            WrapColumn(PersonalCase.GetLable(ResourceKey.CuttingAmount)),
          ],
          rows: widget.Items.map(
            (item) => DataRow(
                //   selected: SelectedItems.contains(item),
                onSelectChanged: (b) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context, PersonalCase, item, () {
                      setState(() {});
                    }),
                  );
                },
                cells: [
                  DataCell(
                    Text(item.SizeParam_StringVal),
                    onTap: () {
                      print('Selected ${item.SizeParam_StringVal}');
                    },
                  ),
                  DataCell(
                    Text(item.ColorParam_StringVal),
                  ),
                  DataCell(
                    Text((item.PlanSizeColor_QTY ?? 0).toString()),
                  ),
                  DataCell(
                    Text((item.SizeColor_QTY ?? 0).toString()),
                  ),
                ]),
          ).toList(),
        ),
      );
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          DataBody(widget.PersonalCase),
        ],
      ),
    );
  }
}
