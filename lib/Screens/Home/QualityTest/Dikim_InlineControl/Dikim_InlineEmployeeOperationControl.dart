import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/TakeImageCamera.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';

class Dikim_InlineEmployeeOperationControl extends StatefulWidget {
  bool IsDirect;

  Dikim_InlineEmployeeOperationControl({this.IsDirect = true});

  @override
  _Dikim_InlineEmployeeOperationControlState createState() =>
      _Dikim_InlineEmployeeOperationControlState();
}

class _Dikim_InlineEmployeeOperationControlState
    extends State<Dikim_InlineEmployeeOperationControl> {
  int IntiteStatus = 0;

  /// Screen Bar App
  PreferredSizeWidget ScreenAppBar(PersonalProvider PersonalCase) {
    return DetailBar(
        Title: PersonalCase.SelectedTest!.Test_Name ?? '',
        PersonalCase: PersonalCase,
        OnTap: () {
          Navigator.pop(context);
        },
        context: context);
  }

  /// Loading Page After Rendering
  Future<bool> InitiateInlineProcess(SubCaseProvider CaseProvider) async {
    bool IsOkay =
        await CaseProvider.EmployeeOperation!.Start_DikimInlineProcess();
    CaseProvider.QualityItemList =
        await DeptModOrderQuality_ItemsBLL.Get_DikimInlineQuality_Items(
            CaseProvider.EmployeeOperation!.DeptModelOrder_QualityTest_Id,
            CaseProvider.EmployeeOperation!.Id);

    CaseProvider.EmployeeOperation!.Error_Amount =
        CaseProvider.Get_SumQualityItemList();

    if (IsOkay) {
      IntiteStatus = 1;
      return true;
    } else {
      IntiteStatus = -1;
    }
    return false;
  }

  /// Closing Function to back into Start page
  void OnCloseCurrentWidget(CaseProvider) {
    CaseProvider.ReloadAction();
    if (widget.IsDirect)
      Navigator.pop(context);
    else {
      int Counter = 0;
      Navigator.of(context).popUntil((route) {
        return Counter++ == 2;
      });
    }
  }

  Future CloseInlineOperation(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    int SampleAmount = PersonalCase.SelectedTest!.Sample_No ?? 0;
    if (SampleAmount <= CaseProvider.GetTotalAmount() || SampleAmount == 0) {
      CaseProvider.EmployeeOperation!.Order_Id =
          PersonalCase.SelectedOrder!.Order_Id;
      var Check = await CaseProvider.EmployeeOperation!
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
    } else {
      AlertPopupDialog(context, PersonalCase.GetLable(ResourceKey.Invalid),
          PersonalCase.GetLable(ResourceKey.CompleteSampleAmount),
          ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
    }
  }

  TextEditingController NoteController = new TextEditingController();

  RegisterNotAlertDialog(BuildContext context, PersonalProvider PersonalCase,SubCaseProvider CaseProvider) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(PersonalCase.GetLable(ResourceKey.Note)),
      content: Container(
        width: getScreenWidth() * 0.7,
        height: getScreenHeight() * 0.3,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: TextFormField(
          controller: NoteController,
          keyboardType: TextInputType.multiline,
          decoration: new InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
              child: Icon(Icons.event_note),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
          ),
          minLines: 1,
          maxLines: 10,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(PersonalCase.GetLable(ResourceKey.Save),
              style: TextStyle(fontSize: ArgonSize.Header3)),
          onPressed: () async {
           CaseProvider.EmployeeOperation!.Reject_Note = NoteController.text;
            var Check = await CaseProvider.EmployeeOperation!
                .UpdateEntity();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(PersonalCase.GetLable(ResourceKey.Cancel),
              style: TextStyle(fontSize: ArgonSize.Header3)),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Closing Control Button
  ClosingControl(PersonalProvider PersonalCase, SubCaseProvider CaseProvider) =>
      Container(
        margin:
            EdgeInsets.fromLTRB(ArgonSize.Padding6, 0, ArgonSize.Padding6, 0),
        child: Row(
          children: [
            Expanded(
                child: CustomButton(
                    width: getScreenWidth(),
                    height: ArgonSize.HeightSmall1,
                    textSize: ArgonSize.Header2,
                    value: PersonalCase.GetLable(ResourceKey.CloseControl),
                    backGroundColor: ArgonColors.primary,
                    function: () async {
                      await CloseInlineOperation(PersonalCase, CaseProvider);
                    })),
            Container(
              width: 15,
            ),
            Expanded(
                child: CustomButton(
                    width: getScreenWidth(),
                    height: ArgonSize.HeightSmall1,
                    textSize: ArgonSize.Header2,
                    value: PersonalCase.GetLable(ResourceKey.Note),
                    backGroundColor: ArgonColors.myYellow,
                    function: () async {
                      await RegisterNotAlertDialog(context, PersonalCase,CaseProvider);
                    }))
          ],
        ),
      );

  /// Main Page After Loading List
  Widget MainPageStructure(PersonalCase, CaseProvider) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [ClosingControl(PersonalCase, CaseProvider), InlineProcess()],
      );

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    NoteController = new TextEditingController(text: CaseProvider.EmployeeOperation!.Reject_Note);
    return Scaffold(
      appBar: ScreenAppBar(PersonalCase),
      body: ListView(
        children: [
          FutureBuilder(
              future: InitiateInlineProcess(CaseProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return MainPageStructure(PersonalCase, CaseProvider);
                else
                  return LoadingContainer(IntiteStatus: IntiteStatus);
              })
        ],
      ),
    );
  }
}

class InlineProcess extends StatefulWidget {
  InlineProcess();

  @override
  _InlineProcessState createState() => _InlineProcessState();
}

class _InlineProcessState extends State<InlineProcess> {
  bool _IsDeletedVal = false;
  late File _image;

  /// Header Which Display Data
  Widget Header(PersonalProvider PersonalCase, SubCaseProvider CaseProvider) =>
      BoxMainContainer(
        Childrens: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderLable(
                  '${PersonalCase.GetLable(ResourceKey.Order_Number)} / '
                  '${PersonalCase.GetLable(ResourceKey.Operation_Name)}',
                  Flex: 3,
                  IsCenter: false),
              TableLable(PersonalCase.SelectedOrder!.Order_Number ?? '',
                  Flex: 2),
              TableLable(
                  CaseProvider.EmployeeOperation!.Operation_Name.toString(),
                  Flex: 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderLable(
                  '${PersonalCase.GetLable(ResourceKey.Employee_Name)} / '
                  '${PersonalCase.GetLable(ResourceKey.Sample_Amount)}',
                  Flex: 3,
                  IsCenter: false),
              TableLable(
                  CaseProvider.EmployeeOperation!.Inline_Employee_Name ?? '',
                  Flex: 2),
              TableLable(CaseProvider.GetTotalAmount().toString(), Flex: 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderLable(
                  '${PersonalCase.GetLable(ResourceKey.Error_Amount)} / '
                  '${PersonalCase.GetLable(ResourceKey.Correct_Amount)}',
                  Flex: 3,
                  IsCenter: false),
              TableLable(
                  (CaseProvider.EmployeeOperation!.Error_Amount ?? 0)
                      .toString(),
                  Flex: 2),
              TableLable(
                  (CaseProvider.EmployeeOperation!.Correct_Amount ?? 0)
                      .toString(),
                  Flex: 2),
            ],
          ),
        ],
      );

  /// Quality Items List
  Widget QualityItem(
          PersonalProvider PersonalCase, SubCaseProvider CaseProvider) =>
      BoxMaterialCard(Childrens: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.fromLTRB(ArgonSize.Padding0, 0, 0, 0),
                  child: ButtonWithNumber(
                      btnBgColor: ArgonColors.inputSuccess,
                      textSize: ArgonSize.Header,
                      buttonWidth: getScreenWidth(),
                      buttonHegiht: ArgonSize.HeightBig,
                      text: PersonalCase.GetLable(ResourceKey.Correct_Amount),
                      topRight: CircleShape(
                          text:
                              (CaseProvider.EmployeeOperation!.Correct_Amount ??
                                      0)
                                  .toString(),
                          width: ArgonSize.WidthSmall,
                          height: ArgonSize.WidthSmall,
                          fontSize: ArgonSize.Header3),
                      bottomLeft: _IsDeletedVal == true
                          ? IconInsideCircle(
                              iconSize: getScreenWidth() > 1100
                                  ? ArgonSize.Header6
                                  : ArgonSize.Header6,
                              size: getScreenWidth() > 1000
                                  ? ArgonSize.Padding6
                                  : ArgonSize.Padding6,
                              icon: FontAwesomeIcons.minus,
                              color: Colors.white,
                              backGroundColor: Colors.red)
                          : Container(width: 0, height: 0),
                      OnTap: () async {
                        int AssignVal = 1;
                        if (_IsDeletedVal) AssignVal = -1;

                        if (_IsDeletedVal &&
                            CaseProvider.EmployeeOperation!.Correct_Amount! <=
                                0) AssignVal = 0;
                        bool Check = await CaseProvider.EmployeeOperation!
                            .Assign_EmployeeControlAmount(AssignVal);
                        if (Check) setState(() {});
                      }),
                ),
              ),
              Expanded(
                flex: 1,
                child: RadioSwitch(
                  Lable: PersonalCase.GetLable(ResourceKey.Delete),
                  fontSize: ArgonSize.Header5,
                  SwitchValue: _IsDeletedVal,
                  OnTap: (value) {
                    setState(() {
                      _IsDeletedVal = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ArgonSize.Padding4),
        GridView.count(
          crossAxisSpacing: 2,
          mainAxisSpacing: 3,
          shrinkWrap: true,
          primary: false,
          childAspectRatio: getScreenWidth() > 500 ? 3 / 1.7 : 7 / 6,
          crossAxisCount: 3,
          children:
              List.generate(CaseProvider.QualityItemList!.length, (index) {
            return GestureDetector(
              onTap: () async {
                String? Image64;
                if (_IsDeletedVal == false &&
                    (CaseProvider.QualityItemList![index].IsTakeImage ??
                        false)) {
                  Image64 = await TakeImageFromCamera();
                }

                bool check = await CaseProvider.QualityItemList![index]
                    .Set_QualityInlineError(CaseProvider.EmployeeOperation!.Id,
                        IsDelete: _IsDeletedVal, Image: Image64);
                if (check)
                  setState(() {
                    CaseProvider.EmployeeOperation!.Error_Amount =
                        CaseProvider.Get_SumQualityItemList();
                  });
              },
              child: InlineErrorButton(
                  CaseProvider.QualityItemList![index], index),
            );
          }),
        ),
      ]);

  /// button to Delete Data
  Widget InlineErrorButton(DeptModOrderQuality_ItemsBLL item, int Index) {
    return ButtonWithNumber(
      text: item.Item_Name!,
      buttonWidth: getScreenWidth() / 3,
      buttonHegiht: getScreenHeight() / 6,
      btnBgColor: ArgonColors.myOrange,
      textSize: ArgonSize.Header3,
      topRight: CircleShape(
          text: (item.Amount ?? 0).toString(),
          width: ArgonSize.WidthSmall,
          height: ArgonSize.WidthSmall,
          fontSize: ArgonSize.Header5),
      textColor: ArgonColors.myBlue,
      bottomLeft: _IsDeletedVal == true
          ? IconInsideCircle(
              iconSize: getScreenWidth() > 1100
                  ? ArgonSize.Header6
                  : ArgonSize.Header6,
              size: getScreenWidth() > 1000
                  ? ArgonSize.Padding6
                  : ArgonSize.Padding6,
              icon: FontAwesomeIcons.minus,
              color: Colors.white,
              backGroundColor: Colors.red)
          : Container(width: 0, height: 0),
      topLeft: item.IsTakeImage == true
          ? IconInsideCircle(
              iconSize: getScreenWidth() > 1100
                  ? ArgonSize.Padding2
                  : ArgonSize.Padding7,
              size: getScreenWidth() > 1000
                  ? ArgonSize.Padding2
                  : ArgonSize.Padding7,
              icon: FontAwesomeIcons.camera,
              color: Colors.white,
              backGroundColor: Colors.deepPurple)
          : Container(width: 0, height: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Column(
      children: [
        Header(PersonalCase, CaseProvider),
        QualityItem(PersonalCase, CaseProvider)
      ],
    );
  }
}
