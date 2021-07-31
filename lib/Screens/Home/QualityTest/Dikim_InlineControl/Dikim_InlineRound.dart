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

import 'Dikim_InlineEmployeeOperationControl.dart';

class Dikim_InlineRound extends StatefulWidget {
  QualityDept_ModelOrder_TrackingBLL RoundItem;

  Dikim_InlineRound({this.RoundItem});

  @override
  _Dikim_InlineRoundState createState() => _Dikim_InlineRoundState();
}

class _Dikim_InlineRoundState extends State<Dikim_InlineRound> {
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

                          ///TODO : ADD Start Measuring to ResourceKey
                            Lable: PersonalCase.GetLable(
                                ResourceKey.AddControlEmployee),
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
                            Lable: PersonalCase.GetLable(ResourceKey.CloseControl),
                            ForColor: ArgonColors.white,
                            BakColor: ArgonColors.warning,
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

                    Tb_InlineRoundList(
                      Items: snapshot.data,
                      PersonalCase: PersonalCase,
                      OnClickItems: (int Index) {
                        if (snapshot.data[Index].CheckStatus ==
                            DikimInlineStatus.Open.index)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Dikim_InlineEmployeeOperationControl(
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
