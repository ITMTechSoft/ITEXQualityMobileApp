import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/AQLControl/AQL_Control.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/QualityTestImports.dart';
import 'QualityTest/Cutting_Control/Cutting_Control.dart';
import 'QualityTest/MeasurementControl/OrderSizeMatrix.dart';

class QualityTestList extends StatefulWidget {
  @override
  _QualityTestListState createState() => _QualityTestListState();
}

class _QualityTestListState extends State<QualityTestList> {
  int IntiteStatus = 0;
  bool? IsUserApproved ;

  Future<List<DepartmentModelOrder_QualityTestBLL>?> LoadEmployeeOrders(
      PersonalProvider PersonalCase) async {
    try {
      List<DepartmentModelOrder_QualityTestBLL>? Items =
          await DepartmentModelOrder_QualityTestBLL
              .Get_DepartmentModelOrder_QualityTest(
                  PersonalCase.SelectedOrder!.Id);

      if (Items != null)
        IntiteStatus = 1;
      else
        IntiteStatus = -1;
      return Items;
    } catch (Excption) {}
  }

  Future<void> MappingSelectedQualityTest(
      PersonalProvider PersonalCase, DataList, Index) async {
    var Critiera = (DataList as List<DepartmentModelOrder_QualityTestBLL>)
        .where((el) => el.IsMandatory == true && el.QualityTest_Id == 1)
        .toList();

    if (Critiera.length > 0 && DataList[Index].QualityTest_Id != 1) {
      IsUserApproved = await Critiera.first
          .IsUserApprovedBefore(Employee_Id: PersonalCase.GetCurrentUser().Id);
      if (IsUserApproved!)
       {
         PersonalCase.SelectedTest = DataList[Index];
         MandatoryCritieraAction(PersonalCase.SelectedTest!);
       }
      else {
        PersonalCase.SelectedTest = Critiera.first;
        AlertPopupDialogWithAction(
          context:context,
          title: PersonalCase.GetLable(ResourceKey.WarrningMessage),
          Children: [
            LableTitle(PersonalCase.GetLable(ResourceKey.PleaseCheckCriteria),
                FontSize: ArgonSize.Header5),
          ],
          FirstActionLable: PersonalCase.GetLable(ResourceKey.Okay),

          SecondActionLable: PersonalCase.GetLable(ResourceKey.Cancel),
            OnFirstAction:(){
            Navigator.pop(context);
            MandatoryCritieraAction(PersonalCase.SelectedTest!);
            }
        );
      }
    } else {
      PersonalCase.SelectedTest = DataList[Index];
      MandatoryCritieraAction(PersonalCase.SelectedTest!);
    }
  }

  void MandatoryCritieraAction(DepartmentModelOrder_QualityTestBLL TargetTest) {
    switch (TargetTest.QualityTest_Id) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Criteria_Test()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Amount()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cutting_Control()));
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Accessory_Control()));
        break;
      case 8:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dikim_InlineControl()));
        break;
      case 9:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dikim_LastControl()));
        break;
      case 10:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderSize_Matrix()));
        break;
      case 11:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AQL_Control()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
      appBar:
      DetailBar(Title: PersonalCase.GetLable(ResourceKey.QualityTests),PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: FutureBuilder<List<DepartmentModelOrder_QualityTestBLL>?> (
        future: LoadEmployeeOrders(PersonalCase),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                shrinkWrap: true,
                primary: false,

                children: <Widget>[
              Container(
                  margin: EdgeInsets.all(ArgonSize.MainMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: HeaderTitle(
                            PersonalCase.SelectedOrder!.Order_Number,
                            color: ArgonColors.header,
                            FontSize: ArgonSize.Header1),
                        subtitle: Text(
                            PersonalCase.SelectedOrder!.Model_Name.toString(),
                            style: TextStyle(fontSize: ArgonSize.Header6)),
                        dense: true,
                        selected: true,
                        tileColor: ArgonColors.Title,
                      ),
                      SizedBox(height: ArgonSize.Padding3),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int i) {
                            return OneItem(
                                ItemName: snapshot.data![i].Test_Name!,
                                ItemValue: snapshot.data![i].StartDate != null
                                    ? snapshot.data![i].StartDate.toString()
                                    : "Not Started Yet",
                                OnTap: () async {
                                  await MappingSelectedQualityTest(
                                      PersonalCase, snapshot.data, i);
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
                MessageError:
                    PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                DetailError: PersonalCase.GetLable(
                    ResourceKey.InvalidNetWorkConnection));
        },
      ),
    );
  }
}
