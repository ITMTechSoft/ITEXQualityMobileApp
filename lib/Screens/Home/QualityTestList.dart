import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/QualityTestImports.dart';



class QualityTestList extends StatefulWidget {
  @override
  _QualityTestListState createState() => _QualityTestListState();
}

class _QualityTestListState extends State<QualityTestList> {
  int IntiteStatus = 0;

  Future<List<DepartmentModelOrder_QualityTestBLL>> LoadEmployeeOrders(
      PersonalProvider PersonalCase) async {
    try {
      List<DepartmentModelOrder_QualityTestBLL> Items =
          await DepartmentModelOrder_QualityTestBLL
              .Get_DepartmentModelOrder_QualityTest(
                  PersonalCase.SelectedOrder.Id);

      if (Items != null)
        IntiteStatus = 1;
      else
        IntiteStatus = -1;
      return Items;
    } catch (Excption) {}
  }

  Future<void> MappingSelectedQualityTest(PersonalProvider PersonalCase, DataList,Index) async {
    var Critiera = (DataList as List<DepartmentModelOrder_QualityTestBLL>)
        .where((el) => el.IsMandatory == true && el.QualityTest_Id == 1)
        .toList();

    if(Critiera.length > 0) {
      bool IsUserApproved =
      await Critiera.first.IsUserApprovedBefore(Employee_Id: PersonalCase
          .GetCurrentUser()
          .Id);
      if(IsUserApproved)
        PersonalCase.SelectedTest = DataList[Index];
      else
        PersonalCase.SelectedTest = Critiera.first;

    }else{
      PersonalCase.SelectedTest = DataList[Index];
    }

    switch (PersonalCase.SelectedTest.QualityTest_Id) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Criteria_Test()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Amount()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Control()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Pastal()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tasnif_Control()));
        break;
      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tasnif_Amount()));
        break;
      case 7:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Accessory_Control()));
        break;
      case 8:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dikim_InlineControl()));
        break;
      case 9:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dikim_LastControl()));
        break;
    }
  }

  int MandatoryCritieraAction(DataList) {}

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
      appBar: DetailBar(PersonalCase.GetLable(ResourceKey.QualityTests), PersonalCase, () {
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
                            PersonalCase.SelectedOrder.Order_Number,
                            color: ArgonColors.Title,
                            FontSize: ArgonSize.Header),
                        subtitle: Text(
                            PersonalCase.SelectedOrder.Model_Name.toString()),
                        dense: true,
                        selected: true,
                        tileColor: ArgonColors.Title,
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int i) {
                            return OneItem(
                                ItemName: snapshot.data[i].Test_Name,
                                ItemValue: snapshot.data[i].StartDate != null
                                    ? snapshot.data[i].StartDate.toString()
                                    : "Not Started Yet",
                                OnTap: () async{
                                  await MappingSelectedQualityTest(
                                      PersonalCase, snapshot.data,i);
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
