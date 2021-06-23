import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Models/Accessory_ModelOrder.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Accessory_Control extends StatefulWidget {
  @override
  _Accessory_ControlState createState() => _Accessory_ControlState();
}

class _Accessory_ControlState extends State<Accessory_Control> {
  int IntiteStatus = 0;

  Future<List<Accessory_ModelOrderBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<Accessory_ModelOrderBLL> Criteria =
        await Accessory_ModelOrderBLL.Get_Accessory_ModelOrder(
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  SelectedNewItem(PersonalCase,Accessory_ModelOrderBLL Item) {
    setState(() {
      PersonalCase.SelectedAccessoryModel = Item;
    });
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
              return Accessory_Model_List(
                  PersonalCase: PersonalCase,
                  context: context,
                  Items: snapshot.data,
                      //(int Index) =>SelectedNewItem(PersonalCase,snapshot.data[Index]));
                  onClick:(int Index) =>SelectedNewItem(PersonalCase,snapshot.data[Index]));
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
