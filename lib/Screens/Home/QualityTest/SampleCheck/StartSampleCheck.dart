import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/ApplicationBars.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';

class StartSampleCheck extends StatefulWidget {
  @override
  _StartSampleCheckState createState() => _StartSampleCheckState();
}

class _StartSampleCheckState extends State<StartSampleCheck> {
  int IntiteStatus = 0;

  final TextEditingController RejectNote = new TextEditingController();
  late TextEditingController TrackingNote = new TextEditingController();
  bool OnTapClick = false;

  Future<List<DeptModOrderQuality_ItemsBLL>?> LoadingOpenPage(
      SubCaseProvider CaseProvider, PersonalProvider PersonalCase) async {



    List<DeptModOrderQuality_ItemsBLL>? Criteria =
        await DeptModOrderQuality_ItemsBLL.Get_SampleCheckQuality_Items(
            CaseProvider.QualityTracking!.Id, PersonalCase.SelectedTest!.Id);

    Criteria = Criteria!.where((r) => r.Item_Name!.isNotEmpty).toList();

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  /// Check Objects
  Widget CheckQualityItem(
      PersonalProvider PersonalCase,
      DeptModOrderQuality_ItemsBLL Item,
      Function() Approve,
      Function() Reject,
      Function() ReOpenAction) {
    /// EDIT BUTTON
    Widget editButton = Row(children: [
      Expanded(flex: 1, child: Container()),
      Expanded(flex: 4, child: Container()),
      Expanded(
          flex: 4,
          child: CustomButton(
              textSize: ArgonSize.Header5,
              value: PersonalCase.GetLable(ResourceKey.Edit),
              backGroundColor: ArgonColors.myGreen,
              height: ArgonSize.HeightSmall1,
              width: getScreenWidth() > 500
                  ? getScreenWidth() / 3
                  : getScreenWidth() / 2.4,
              function: ReOpenAction)),
    ]);
    Widget ActionControl = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 4,
          child: CustomButton(
              value: PersonalCase.GetLable(ResourceKey.ControlValid),
              textSize: ArgonSize.Header5,
              backGroundColor: ArgonColors.primary,
              function: Approve,
              height: ArgonSize.HeightSmall1,
              width: getScreenWidth() > 500
                  ? getScreenWidth() / 3
                  : getScreenWidth() / 2),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 4,
          child: CustomButton(
              textSize: ArgonSize.Header5,
              value: PersonalCase.GetLable(ResourceKey.ControlInvalid),
              backGroundColor: ArgonColors.warning,
              height: ArgonSize.HeightSmall1,
              width: getScreenWidth() > 500
                  ? getScreenWidth() / 3
                  : getScreenWidth() / 2,
              function: Reject),
        ),
      ],
    );

    if (Item.CheckStatus == 1)
      ActionControl = InkWell(
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Icon(Icons.check_circle_rounded,
                      color: ArgonColors.success,
                      size: ArgonSize.IconSizeMedium),
                ),
                SizedBox(width: ArgonSize.Padding5),
                Expanded(
                  child: Text(PersonalCase.GetLable(ResourceKey.Approved),
                      style: TextStyle(fontSize: ArgonSize.Header4)),
                )
              ],
            ),
            SizedBox(height: ArgonSize.Padding3),
            editButton
          ],
        ),
        //  onTap: ReOpenAction,
      );
    else if (Item.CheckStatus == 0)
      ActionControl = InkWell(
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Icon(Icons.cancel_outlined,
                      color: ArgonColors.warning,
                      size: ArgonSize.IconSizeMedium),
                ),
                SizedBox(width: ArgonSize.Padding5),
                Expanded(
                  child: Text(
                      PersonalCase.GetLable(ResourceKey.Rejected) +
                          ': ' +
                          Item.Reject_Note!,
                      style: TextStyle(fontSize: ArgonSize.Header4)),
                )
              ],
            ),
            SizedBox(height: ArgonSize.Padding3),
            editButton
          ],
        ),
        // onTap: ReOpenAction,
      );

    Widget MainRow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: ArgonSize.Padding6),
        LableTitle(Item.Item_Name ?? '',
            color: ArgonColors.text, FontSize: ArgonSize.Header4),
        SizedBox(height: ArgonSize.Padding3),
        ActionControl,
        SizedBox(height: ArgonSize.Padding6),
      ],
    );

    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: MainRow,
      ),
    );
  }

  /// Check List
  Widget Get_CheckItemsList(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider, snapshot) {
    if (snapshot.data.length == 0)
      return ErrorPage(
          ActionName: PersonalCase.GetLable(ResourceKey.WarrningMessage),
          MessageError: PersonalCase.GetLable(
              ResourceKey.PleaseCompleteQualityTestBeforeStart),
          DetailError:
              PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return CheckQualityItem(PersonalCase, snapshot.data[i], () async {
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
                CaseProvider.QualityTracking!.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
            Item.CheckStatus = 1;
            Item.Create_Date = DateTime.now();
            await QualityDept_ModelOrder_TrackingBLL
                .CuttingPastal_ApproveRejectItem(Item);
            setState(() {});
          }, () async {
            RejectNote.text = "";
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
                CaseProvider.QualityTracking!.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
            Item.CheckStatus = 0;
            Item.Create_Date = DateTime.now();

            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(PersonalCase, context, Item),
            );

            setState(() {});
          }, () async {
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
          CaseProvider.QualityTracking!.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
              await QualityDept_ModelOrder_TrackingBLL.CuttingPastal_ReOpenCheckItem(Item);
            setState(() {});
          });
        });
  }

  Widget MainInformationBox(PersonalProvider PersonalCase,
          SubCaseProvider CaseProvider, BuildContext context) =>
      InformationBox(
          function: () {
            setState(() {});
          },
          MainPage: Padding(
            padding: EdgeInsets.all(ArgonSize.Header7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            PersonalCase.GetLable(ResourceKey.Note),
                            FontSize: ArgonSize.Header4)),
                    Expanded(
                        child: CustomButton(
                          height: ArgonSize.WidthSmall1,
                          width: getScreenWidth() / 2.5,
                          textSize: ArgonSize.Header4,
                          backGroundColor: ArgonColors.myLightGreen,
                          value: PersonalCase.GetLable(ResourceKey.Save),
                          function: () async {
                            CaseProvider.QualityTracking!.Tracking_Note =
                                TrackingNote.text;
                            setState(() {
                              CaseProvider.QualityTracking!.UpdateEntity();
                              OnTapClick = false;
                            });
                          },
                        )),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Container(
                          decoration: new BoxDecoration(color: Colors.white),
                          height: OnTapClick? 150:50,
                          child: TextFormField(
                            controller: TrackingNote,
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
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 2,
                            onTap: (){
                              setState(() {
                                OnTapClick = true;
                              });
                            },

                            // initialValue: ,
                          ),
                        ))
                  ],
                ),

              ],
            ),
          ));

  Widget _buildPopupDialog(PersonalCase, BuildContext context, Item) {
    return new AlertDialog(
      title: Text(PersonalCase.GetLable(ResourceKey.RejectNot)),
      content: Container(
        width: getScreenWidth() * 0.7,
        height: getScreenHeight() * 0.3,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child:
            // Standard_Input(
            //   prefixIcon: Icon(Icons.event_note),
            //   controller: CuttingAmountController,
            //   Ktype: TextInputType.multiline,
            //   MinLines: 2,
            //   MaxLines: 10,
            // ),

            TextFormField(
          controller: RejectNote,
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
            Item.Reject_Note = RejectNote.text;
            await QualityDept_ModelOrder_TrackingBLL
                .CuttingPastal_ApproveRejectItem(Item);
            Navigator.of(context).pop();
            setState(() {});
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    TrackingNote.text =  (CaseProvider.QualityTracking!.Tracking_Note ??"");
    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest!.Test_Name ?? '',
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString(),
              style: TextStyle(fontSize: ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        MainInformationBox(PersonalCase, CaseProvider, context),
        SizedBox(height: ArgonSize.Padding4),
        FutureBuilder(
          future: LoadingOpenPage(CaseProvider, PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Get_CheckItemsList(PersonalCase, CaseProvider, snapshot);
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
