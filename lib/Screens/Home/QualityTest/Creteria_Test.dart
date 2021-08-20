import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itex_soft_qualityapp/Models/Criteria_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class Criteria_Test extends StatefulWidget {
  @override
  _Criteria_TestState createState() => _Criteria_TestState();
}

class _Criteria_TestState extends State<Criteria_Test> {
  int IntiteStatus = 0;
  bool IsUserApproved = false;
  int WaitSYC = 1;

  //PDFViewController _pdfViewController;

  Future<Criteria_ModelOrderBLL?> LoginFunction(
      PersonalProvider PersonalCase) async {
    var Critiera = await Criteria_ModelOrderBLL.Get_Criteria_ModelOrder(
        PersonalCase.SelectedTest!.Id);

    IsUserApproved = await PersonalCase.SelectedTest!.IsUserApprovedBefore(
        Employee_Id: PersonalCase.GetCurrentUser().Id);
    if (Critiera != null)
      WaitSYC = ((Critiera.WaitTimeSNY ?? 0) / 100).toInt() + 1;

    var Item = new QualityDept_ModelOrder_TrackingBLL();
    Item.Employee_Id = PersonalCase.GetCurrentUser().Id;
    Item.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest!.Id;
    bool IsReading = await Item.SetReadValidationAction();

    if (Critiera != null) {
      IntiteStatus = 1;
    } else {
      IntiteStatus = -1;
    }
    return Critiera;
  }


  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar:

      DetailBar(Title:PersonalCase.GetLable(ResourceKey.CriteriaTest),PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number??'',
                color: ArgonColors.header, FontSize: ArgonSize.Header),
            subtitle:
                Text(PersonalCase.SelectedDepartment!.Start_Date.toString()),
            dense: true,
            selected: true,
          ),
          FutureBuilder<Criteria_ModelOrderBLL?>(
            future: LoginFunction(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      !IsUserApproved
                          ? Container()
                          : Container(),
                      new Container(
                          child: new Column(
                            children: <Widget>[
                              Html(
                                data: snapshot.data!.HTML_Data   ?? "",
                              ),
                            ],
                          )),

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
