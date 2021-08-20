import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';

class Dikim_InlineEmployeeOperationControl extends StatefulWidget {
  User_QualityTracking_DetailBLL EmployeeOperation;
  bool IsDirect;

  Dikim_InlineEmployeeOperationControl({required this.EmployeeOperation,this.IsDirect = true});

  @override
  _Dikim_InlineEmployeeOperationControlState createState() =>
      _Dikim_InlineEmployeeOperationControlState();
}

class _Dikim_InlineEmployeeOperationControlState
    extends State<Dikim_InlineEmployeeOperationControl> {
  int IntiteStatus = 0;
  int AssignAmount = 1;

  Future<bool> LoadingOpenPage() async {
    bool IsOkay = await widget.EmployeeOperation.Start_DikimInlineProcess();

    if (IsOkay) {
      IntiteStatus = 1;
      return true;
    } else {
      IntiteStatus = -1;
    }
    return false;
  }

  void OnCloseCurrentWidget(CaseProvider){
    CaseProvider.ReloadAction();
    if(widget.IsDirect)
      Navigator.pop(context);
    else
    {
      int Counter = 0;
      Navigator.of(context).popUntil((route) {
        return Counter++ == 2;
      });
    }
  }

  Widget MainPageAction(PersonalProvider PersonalCase,SubCaseProvider CaseProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BoxMainContainer(
          Childrens: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderLable('${PersonalCase.GetLable(ResourceKey.Order_Number)} / ' '${PersonalCase.GetLable(ResourceKey.Operation_Name)}' ,Flex:3 ),
                TableLable(PersonalCase.SelectedOrder!.Order_Number??'',Flex:2),
                TableLable(widget.EmployeeOperation.Operation_Name.toString(),Flex:2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderLable('${PersonalCase.GetLable(ResourceKey.Employee_Name)} / ' '${PersonalCase.GetLable(ResourceKey.Sample_Amount)}' , Flex:3),
                TableLable(widget.EmployeeOperation.Inline_Employee_Name??'',Flex:2),
                TableLable((widget.EmployeeOperation.Amount ?? 0).toString(),Flex:2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderLable('${PersonalCase.GetLable(ResourceKey.Error_Amount)} / ' '${PersonalCase.GetLable(ResourceKey.Correct_Amount)}' , Flex:3),
                TableLable(
                    (widget.EmployeeOperation.Error_Amount ?? 0).toString(), Flex:2),
                TableLable(
                    (widget.EmployeeOperation.Correct_Amount ?? 0).toString(), Flex:2),
              ],
            ),
          ],
        ),
        BoxMainContainer(Childrens: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex:3,
                  child: CustomButton(
                      backGroundColor: ArgonColors.inputSuccess,
                      textSize: ArgonSize.Header5,
                      height: ArgonSize.HeightSmall1,
                      value: PersonalCase.GetLable(ResourceKey.Correct_Amount),
                      function: () async {
                        bool Check = await widget.EmployeeOperation
                            .Assign_EmployeeControlAmount(AssignAmount, "C");

                        if (Check) setState(() {});

                      })),
              Expanded(

                child: Padding(
                  child: SpinBox(
                    max: 999999,

                    textStyle:TextStyle(fontSize:ArgonSize.Header3),
                    value: 1,
                    onChanged: (value) {
                      AssignAmount = value.toInt();
                    },
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                flex: 5,
              ),
              Expanded(
                flex:3,

                  child: CustomButton(
                      backGroundColor: ArgonColors.error,
                      textSize: ArgonSize.Header5,
                      height: ArgonSize.HeightSmall1,
                      width :ArgonSize.WidthSmall1,
                      value: PersonalCase.GetLable(ResourceKey.Error_Amount),
                      function: () async {
                        bool Check = await widget.EmployeeOperation
                            .Assign_EmployeeControlAmount(AssignAmount, "E");
                        if (Check) setState(() {});
                      })),
            ],
          ),
          SizedBox(
            height: ArgonSize.Padding2,
          ),
          CustomButton(
            width: getScreenWidth()/3,

              height: ArgonSize.HeightMedium,
              textSize: ArgonSize.Header4,

              value: PersonalCase.GetLable(ResourceKey.CloseControl),
              backGroundColor: ArgonColors.primary,
              function: () async {
                widget.EmployeeOperation.Order_Id =
                    PersonalCase.SelectedOrder!.Order_Id;
                var Check = await widget.EmployeeOperation
                    .CloseEmployeeOperationControlRound();
                if (Check) {
                  OnCloseCurrentWidget(CaseProvider);
                } else {
                  AlertPopupDialog(
                      context,
                      PersonalCase.GetLable(ResourceKey.SaveErrorMessage),
                      PersonalCase.GetLable(ResourceKey.InvalidAction),
                      ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
                }
              })
        ]),
      ],
    );
  }

  String Lable = "";

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return Scaffold(
      appBar: DetailBar(Title:PersonalCase.SelectedTest!.Test_Name??'',PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(

                  PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header,
              FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString()??'',style:TextStyle(fontSize:ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingOpenPage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainPageAction(PersonalCase,CaseProvider);
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
