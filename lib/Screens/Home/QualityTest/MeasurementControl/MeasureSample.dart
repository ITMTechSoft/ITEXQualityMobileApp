import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/Dikim_InlineProcess.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/Dikim_InlineControl/Dikim_EmployeeOperationMerge.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/MeasuerTestTable.dart';

import 'MeasureItemControl.dart';


class Measuer_Sample extends StatefulWidget {
  QualityDept_ModelOrder_TrackingBLL RoundItem;

  Measuer_Sample({this.RoundItem});

  @override
  _Measuer_SampleState createState() => _Measuer_SampleState();
}

class _Measuer_SampleState extends State<Measuer_Sample> {
  int IntiteStatus = 0;

  Future<List<User_QualityTracking_DetailBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<User_QualityTracking_DetailBLL> Criteria =
    await User_QualityTracking_DetailBLL.Get_User_QualityTracking_Detail(
        widget.RoundItem.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        CaseProvider.ReloadAction();
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
              return Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StandardButton(
                            Lable: PersonalCase.GetLable(
                                ResourceKey.StartMeasure),
                            ForColor: ArgonColors.white,
                            BakColor: ArgonColors.primary,
                            OnTap: () async {
                              CaseProvider.ReloadAction();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dikim_EmployeeOperationMerge(
                                            RoundItem: widget.RoundItem,
                                          )));
                            }),
                        SizedBox(width: 50,),
                        StandardButton(
                            Lable: PersonalCase.GetLable(ResourceKey.EndMeasure),
                            ForColor: ArgonColors.white,
                            BakColor: ArgonColors.myLightBlue,
                            OnTap: () {
                              AlertPopupDialogWithAction(context,
                                  title: PersonalCase.GetLable(
                                      ResourceKey.WarrningMessage),
                                  Children: <Widget>[
                                    LableTitle(PersonalCase.GetLable(
                                        ResourceKey.ConfirmationCloseControl))
                                  ],
                                  FirstActionLable:
                                  PersonalCase.GetLable(ResourceKey.Okay),
                                  SecondActionLable:
                                  PersonalCase.GetLable(ResourceKey.Cancel),
                                  OnFirstAction: () async {
                                    await widget.RoundItem.CloseDikimInlineTur();
                                    CaseProvider.ReloadAction();
                                    Navigator.pop(context);
                                  });


                            }),
                      ],

                    ),

                    Tb_MeasuerCard(
                      Items: snapshot.data,
                      PersonalCase: PersonalCase,
                      OnClickItems: (int Index) {
                        if (snapshot.data[Index].CheckStatus ==
                            DikimInlineStatus.Open.index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MeasureItem_Control(
                                        EmployeeOperation:
                                        snapshot.data[Index]),));
                      },
                    ),
                  ],
                ),
              );
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
