import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itex_soft_qualityapp/Models/Criteria_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:html/parser.dart' show parse;
import 'package:itex_soft_qualityapp/Widgets/TimerButton.dart';

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
  void initState() {
    super.initState();
    var document = parse('<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!') ;
    print(parse.toString());

  }@override
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
                var document = parse(
                    snapshot.data!.HTML_Data??'');
                print(document.outerHtml);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      !IsUserApproved
                          ? TimerButton(
                        label:
                        PersonalCase.GetLable(ResourceKey.Validation),
                        activeTextStyle: TextStyle(
                          fontSize: ArgonSize.WidthSmall,
                          color: ArgonColors.white,
                        ),
                        disabledTextStyle: TextStyle(
                            fontSize: ArgonSize.WidthSmall,
                            color: ArgonColors.white),
                        timeOutInSeconds: WaitSYC > 0 ? WaitSYC : 1,
                        onPressed: () async {
                          bool IsValidated = await PersonalCase
                              .SelectedTest!
                              .SetValidationAction(
                              PersonalCase.GetCurrentUser().Id);
                          if (IsValidated) Navigator.pop(context);
                        },
                        buttonType: ButtonType.RaisedButton,
                        disabledColor: Colors.amberAccent,
                        color: ArgonColors.myLightBlue,
                      )
                          : Container(),
                        new Container(
                            child: new Column(
                              children: <Widget>[
                                Html(
                                  data: snapshot.data!.HTML_Data  ?? "",
                                  style: {
                                  'p': Style(margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 8)),
                                  },
                                ),

                            //   Text( parse(snapshot.data!.HTML_Data ).outerHtml)


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
