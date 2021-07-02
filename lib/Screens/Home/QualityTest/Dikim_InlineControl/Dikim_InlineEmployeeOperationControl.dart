import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Dikim_InlineEmployeeOperationControl extends StatefulWidget {
  User_QualityTracking_DetailBLL EmployeeOperation;

  Dikim_InlineEmployeeOperationControl({this.EmployeeOperation});

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

  Widget MainPageAction(PersonalProvider PersonalCase) {
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
                HeaderLable(PersonalCase.GetLable(ResourceKey.Order_Number)),
                TableLable(PersonalCase.SelectedOrder.Order_Number),
                HeaderLable(PersonalCase.GetLable(ResourceKey.Operation_Name)),
                TableLable(widget.EmployeeOperation.Operation.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderLable(PersonalCase.GetLable(ResourceKey.Employee_Name)),
                TableLable(widget.EmployeeOperation.Inline_Employee_Name),
                HeaderLable(PersonalCase.GetLable(ResourceKey.Sample_Amount)),
                TableLable(widget.EmployeeOperation.Amount.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                HeaderLable(PersonalCase.GetLable(ResourceKey.Error_Amount)),
                TableLable(
                    (widget.EmployeeOperation.Error_Amount ?? 0).toString()),
                HeaderLable(PersonalCase.GetLable(ResourceKey.Correct_Amount)),
                TableLable(
                    (widget.EmployeeOperation.Correct_Amount ?? 0).toString()),
              ],
            ),
          ],
        ),
        BoxMaterialCard(
          Childrens: <Widget>[
            StandardButton(
                ForColor: ArgonColors.white,
                BakColor: ArgonColors.inputSuccess,
                FontSize: 12,
                Lable: PersonalCase.GetLable(ResourceKey.Correct_Amount),
                OnTap: () async {
                  bool Check = await widget.EmployeeOperation
                      .Assign_EmployeeControlAmount(AssignAmount, "C");
                  if (Check) setState(() {});
                }),
            Padding(
              child: SpinBox(
                value: 1,
                onChanged: (value) {
                  AssignAmount = value.toInt();
                },
              ),
              padding: const EdgeInsets.all(16),
            ),
            StandardButton(
                ForColor: ArgonColors.white,
                BakColor: ArgonColors.error,
                FontSize: 12,
                Lable: PersonalCase.GetLable(ResourceKey.Error_Amount),
                OnTap: () async {
                  bool Check = await widget.EmployeeOperation
                      .Assign_EmployeeControlAmount(AssignAmount, "E");
                  if (Check) setState(() {});
                }),
          ],
        ),
        BoxMaterialCard(
          Childrens: [
            StandardButton(
                Lable: PersonalCase.GetLable(ResourceKey.Validation),
                ForColor: ArgonColors.white,
                BakColor: ArgonColors.primary,
                OnTap: () async {
                  var Check = await widget.EmployeeOperation
                      .CloseEmployeeOperationControlRound();
                  if (Check) {
                    Navigator.pop(context);
                  } else {
                    AlertPopupDialog(
                        context,
                        PersonalCase.GetLable(ResourceKey.SaveErrorMessage),
                        PersonalCase.GetLable(ResourceKey.InvalidAction),
                        ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
                  }
                })
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
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
          future: LoadingOpenPage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainPageAction(PersonalCase);
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
