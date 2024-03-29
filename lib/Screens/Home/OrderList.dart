import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/QualityDepartment_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTestList.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int IntiteStatus = 0;
  final TextEditingController SearchController = new TextEditingController();

  Future<List<QualityDepartment_ModelOrderBLL>> LoadEmployeeOrders(
      PersonalProvider PersonalCase) async {
    try {
      List<QualityDepartment_ModelOrderBLL> MainItems =
          await QualityDepartment_ModelOrderBLL
              .Get_QualityDepartment_ModelOrder(
                  PersonalCase.SelectedDepartment.Department_Id);

      var Items =
          MainItems.where((i) => i.Order_Number.contains(SearchController.text))
              .toList();

      if (Items != null)
        IntiteStatus = 1;
      else
        IntiteStatus = -1;
      return Items;
    } catch (Excption) {}
  }

  Future FilterSearch(String FilterValue) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
      appBar: DetailBar(PersonalCase.GetLable(ResourceKey.ModelOrderList), PersonalCase, () {
        Navigator.pop(context);
      }),
      body: FutureBuilder(
        future: LoadEmployeeOrders(PersonalCase),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(ArgonSize.MainMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: HeaderTitle(
                            PersonalCase.SelectedDepartment.Depart_Name,
                            color: ArgonColors.header,
                            FontSize: ArgonSize.Header),
                        subtitle: Text(PersonalCase
                            .SelectedDepartment.Start_Date
                            .toString()),
                        dense: true,
                        selected: true,
                      ),
                      FilterItem(context, SearchController, FilterSearch,PersonalCase),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int i) {
                            return OrderCard(snapshot.data[i], () {
                              PersonalCase.SelectedOrder = snapshot.data[i];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QualityTestList()));
                            });
                          }),
                    ],
                  ))
            ]);
          } else if (IntiteStatus == 0)
            return Center(child: CircularProgressIndicator());
          else
            return ErrorPage(
                ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                MessageError: PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                DetailError: PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
        },
      ),
    );
  }
}
