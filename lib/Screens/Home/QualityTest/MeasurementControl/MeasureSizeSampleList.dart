import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/Dikim_InlineControl/Dikim_InlineRound.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/MeasuerTestTable.dart';

import 'MeasureSample.dart';

class MeasureSizeSample_List extends StatefulWidget {
  @override
  _MeasureSizeSample_ListState createState() => _MeasureSizeSample_ListState();
}

class _MeasureSizeSample_ListState extends State<MeasureSizeSample_List> {


  int IntiteStatus = 0;
  DateTime SelectedDate = DateTime.now();

  Future<List<QualityDept_ModelOrder_TrackingBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<QualityDept_ModelOrder_TrackingBLL>? Criteria =
    await QualityDept_ModelOrder_TrackingBLL
        .GetInlineDikim_QualityDept_ModelOrder_Tracking(
        Employee_Id: PersonalCase.GetCurrentUser().Id,
        DeptModelOrder_QualityTest_Id:1009,
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
    AlertPopupDialogWithAction(context:context,
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
            Tracking.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest!.Id;
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
      DetailBar(Title:PersonalCase.SelectedTest!.Test_Name??'',PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),

      /// TODO :CHANGE PAGE NAME AND HEADER NAME
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(

                  PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header,
              FontSize: ArgonSize.Header3),
          subtitle: Text(DateFormat("yyyy/MM/dd HH:mm")
              .format(PersonalCase.SelectedDepartment!.Start_Date)),
          dense: true,
          selected: true,
        ),
        FutureBuilder<List<QualityDept_ModelOrder_TrackingBLL>?>(
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
                    StandardButton(
                        Lable:
                        PersonalCase.GetLable(ResourceKey.ControlValid),
                        ForColor: ArgonColors.white,
                        BakColor: ArgonColors.primary,
                        OnTap: () async {
                          await GenerateNewRound(PersonalCase);
                        }),
                    // DateTimePicker(SelectedDate: (DateTime SelectedTime) {
                    //   setState(() {
                    //     SelectedDate = SelectedTime;
                    //   });
                    // }),
                    Tb_InlineDikimList2(
                      OnClickItems: (int Index) {
                        if (snapshot.data![Index].Status ==
                            DikimInlineStatus.Open.index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Measuer_Sample(
                                      RoundItem: snapshot.data![Index])));
                      },
                      Items: snapshot.data,
                      Headers: <Widget>[
                        HeaderLable(PersonalCase.GetLable(ResourceKey.Number),
                            Flex: 1),

                        ///TODO: ADD KEY SAMPLE CONTROL AMOUNT
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Start_date),
                            Flex: 1),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.End_date),
                            Flex: 1),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Status),
                            Flex: 1),

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
