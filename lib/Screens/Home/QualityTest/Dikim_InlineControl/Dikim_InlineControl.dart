import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/Dikim_InlineControl/Dikim_InlineRound.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/DateTimeComponent.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Dikim_InlineControl extends StatefulWidget {
  @override
  _Accessory_ControlState createState() => _Accessory_ControlState();
}

class _Accessory_ControlState extends State<Dikim_InlineControl> {


  int IntiteStatus = 0;
  DateTime SelectedDate = DateTime.now();

  Future<List<QualityDept_ModelOrder_TrackingBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<QualityDept_ModelOrder_TrackingBLL> Criteria =
        await QualityDept_ModelOrder_TrackingBLL
            .GetInlineDikim_QualityDept_ModelOrder_Tracking(
                Employee_Id: PersonalCase.GetCurrentUser().Id,
                DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest.Id,
                SelectDate: SelectedDate);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Future<void> GenerateNewRound(PersonalProvider PersonalCase) async {
    AlertPopupDialogWithAction(context,
        title: PersonalCase.GetLable(ResourceKey.WarrningMessage),
        Children: <Widget>[
          LableTitle(
              PersonalCase.GetLable(ResourceKey.OpenNewRoundWillCloseOldOne),
              FontSize: ArgonSize.Header4)
        ],
        FirstActionLable: PersonalCase.GetLable(ResourceKey.Okay),
        SecondActionLable: PersonalCase.GetLable(ResourceKey.Cancel),
        OnFirstAction: () async {
      try {
        var Tracking = new QualityDept_ModelOrder_TrackingBLL();
        Tracking.Employee_Id = PersonalCase.GetCurrentUser().Id;
        Tracking.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest.Id;
        Tracking.Status = DikimInlineStatus.Open.index;
        Tracking.StartDate = DateTime.now();
        await Tracking.Generate_DikimInline_Tracking();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dikim_InlineRound(RoundItem: Tracking)));
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar:
      DetailBar(Title:PersonalCase.SelectedTest.Test_Name,PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(

                  PersonalCase.SelectedOrder.Order_Number,
              color: ArgonColors.header,
              FontSize: ArgonSize.Header3),
          subtitle: Text(DateFormat("yyyy/MM/dd HH:mm")
              .format(PersonalCase.SelectedDepartment.Start_Date)),
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
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children:[
                        CustomButton(
                             width:getScreenWidth()/2.3,
                            height: ArgonSize.HeightSmall,
                  textSize:ArgonSize.Header4,
                            value:
                            PersonalCase.GetLable(ResourceKey.ControlValid),
                            backGroundColor: ArgonColors.primary,
                            function: () async {
                              await GenerateNewRound(PersonalCase);
                            }),
                        DateTimePicker(SelectedDate: (DateTime SelectedTime) {
                          setState(() {
                            SelectedDate = SelectedTime;
                          });
                        }),
                      ]
                    ),
                    SizedBox(height:ArgonSize.Padding3),
                    Tb_InlineDikimList(
                      OnClickItems: (int Index) {
                        if (snapshot.data[Index].Status ==
                            DikimInlineStatus.Open.index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dikim_InlineRound(
                                      RoundItem: snapshot.data[Index])));
                      },
                      Items: snapshot.data,
                      Headers: <Widget>[
                        HeaderLable(PersonalCase.GetLable(ResourceKey.Id),
                            Flex: 1),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Start_Time),
                            Flex: 2),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.End_Time),
                            Flex: 2),
                        HeaderLable(PersonalCase.GetLable(ResourceKey.Status),
                            Flex: 1)
                      ],
                    ),
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
      ]),
    );
  }
}
