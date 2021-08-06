import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderSizes.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/Dikim_InlineControl/Dikim_InlineRound.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/DateTimeComponent.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/MeasuerTestTable.dart';

import 'MeasureSample.dart';
import 'MeasureSizeSampleList.dart';

class OrderSize_Matrix extends StatefulWidget {
  @override
  _OrderSize_MatrixState createState() => _OrderSize_MatrixState();
}

class _OrderSize_MatrixState extends State<OrderSize_Matrix> {


  int IntiteStatus = 0;
  /// TODO : DELETE IT
  DateTime SelectedDate = DateTime.now();

  Future<List<ModelOrderSizesBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<ModelOrderSizesBLL> Criteria =
    await ModelOrderSizesBLL
        .Get_ModelOrderSizes(

     PersonalCase.SelectedTest.Order_Id,
        );

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

      /// TODO :CHANGE PAGE NAME AND HEADER NAME
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


                    Tb_InlineDikimList1(
                      OnClickItems: (int Index) {
                        if (snapshot.data[Index].Status ==
                            DikimInlineStatus.Open.index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MeasureSizeSample_List()));
                      },
                      Items: snapshot.data,
                      Headers: <Widget>[
                        HeaderLable(PersonalCase.GetLable(ResourceKey.SizeName),
                            Flex: 1),

                        ///TODO: ADD KEY SAMPLE CONTROL AMOUNT
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Sample_Amount),
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
