import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/TopBar.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Cutting_PastalControl extends StatefulWidget {
  @override
  _Cutting_PastalControlState createState() => _Cutting_PastalControlState();
}

class _Cutting_PastalControlState extends State<Cutting_PastalControl> {
  int IntiteStatus = 0;

  List<DeptModOrderQuality_ItemsBLL>? Quality_Item;
  int SampleAmount = 0;
  int ErrorAmount = 0;
  int Percentage = 0;

  CalculateHeader() {
    SampleAmount = 0;
    ErrorAmount = 0;
    Quality_Item!.forEach((element) {
      SampleAmount += element.Amount ?? 0;
      ErrorAmount += element.Error_Amount ?? 0;
    });
    Percentage = 0;
    if ((SampleAmount ?? 0) > 0)
      Percentage = ((ErrorAmount * 100) / SampleAmount).ceil();
  }

  Future<bool> LoadingCutttingControl(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    Quality_Item =
        await DeptModOrderQuality_ItemsBLL.Get_DeptModOrderQuality_Items(
            PersonalCase.GetCurrentUser().Id,
            PersonalCase.SelectedTest!.Id,
            PersonalCase.SelectedSize!.Id,
            CaseProvider.SelectedPastal!.Id);

    if (Quality_Item != null) {
      IntiteStatus = 1;
      CalculateHeader();
      return true;
    } else {
      IntiteStatus = -1;
    }
    return false;
  }

  DeptModOrderQuality_ItemsBLL? SelectedItem;
  double IncrementVal = 1;
  double FarkVal = 0;

  Future<bool> CorrentVal(PersonalProvider PersonalCase) async {
    if (SelectedItem != null) {
      var UserQuality = new User_QualityTracking_DetailBLL();
      UserQuality.Correct_Amount = IncrementVal.toInt();
      UserQuality.QualityDept_ModelOrder_Tracking_Id =
          PersonalCase.SelectedTracking!.Id;
      UserQuality.Create_Date = DateTime.now();
      UserQuality.Xaxis_QualityItem_Id = SelectedItem!.Id;
      bool? Check = await UserQuality.SetFull_User_QualityTracking_Detail();

      if (Check == null) return false;
    } else {
      AlertPopupDialog(
          context,
          PersonalCase.GetLable(ResourceKey.WarrningMessage),
          PersonalCase.GetLable(ResourceKey.PleaseChooseValue),
          ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
    }
    return true;
  }

  Future<bool> ErrorVal(PersonalProvider PersonalCase) async {
    if (SelectedItem != null) {
      var UserQuality = new User_QualityTracking_DetailBLL();
      UserQuality.Error_Amount = IncrementVal.toInt();
      UserQuality.QualityDept_ModelOrder_Tracking_Id =
          PersonalCase.SelectedTracking!.Id;
      UserQuality.Create_Date = DateTime.now();
      UserQuality.Xaxis_QualityItem_Id = SelectedItem!.Id;
      UserQuality.Pastal_Fark = FarkVal;
      bool? Check = await UserQuality.SetFull_User_QualityTracking_Detail();
      if (Check == null) return false;
    } else {
      AlertPopupDialog(
          context,
          PersonalCase.GetLable(ResourceKey.WarrningMessage),
          PersonalCase.GetLable(ResourceKey.PleaseChooseValue),
          ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
    }
    return true;
  }

  /// Pastal Header Test
  Widget AraControlHeader(PersonalProvider PersonalCase) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ArgonColors.Group,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      LableTitle(PersonalCase.GetLable(ResourceKey.SizeName))),
              Expanded(
                  child: LableTitle(
                      PersonalCase.SelectedSize!.SizeParam_StringVal ?? '',
                      color: ArgonColors.text)),
              Expanded(
                flex: 2,
                child:
                    LableTitle(PersonalCase.GetLable(ResourceKey.TotalControl)),
              ),
              Expanded(
                child: LableTitle(SampleAmount.toString(),
                    color: ArgonColors.text),
              )
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            children: [
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ErrorAmount))),
              Expanded(
                  child: LableTitle(ErrorAmount.toString(),
                      color: ArgonColors.text)),
              Expanded(
                flex: 2,
                child: LableTitle(
                    PersonalCase.GetLable(ResourceKey.ErrorPercentage)),
              ),
              Expanded(
                child: LableTitle(Percentage.toString() + " % ",
                    color: ArgonColors.text),
              )
            ],
          )
        ],
      ),
    );
  }

  /// List Items
  Widget ListHeader(PersonalProvider PersonalCase) => Container(
        padding: EdgeInsets.all(ArgonSize.Padding7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 6,
                child: LableTitle(
                    PersonalCase.GetLable(ResourceKey.ControlAxaisName),
                    FontSize: ArgonSize.Header4)),
            Expanded(
                flex: 2,
                child: LableTitle(
                    PersonalCase.GetLable(ResourceKey.ControlAmount),
                    FontSize: ArgonSize.Header4)),
            Expanded(
                flex: 2,
                child: LableTitle(
                    PersonalCase.GetLable(ResourceKey.ControlError),
                    FontSize: ArgonSize.Header4))
          ],
        ),
      );

  Widget ListItem(DeptModOrderQuality_ItemsBLL Item) => Container(
        padding: EdgeInsets.all(ArgonSize.Padding7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 6,
                child: LableTitle(Item.Item_Name ?? '',
                    color: ArgonColors.text, FontSize: ArgonSize.Header4)),
            Expanded(
                flex: 2,
                child: Center(
                  child: LableTitle((Item.Amount ?? 0).toString(),
                      color: ArgonColors.text, FontSize: ArgonSize.Header4),
                )),
            Expanded(
                flex: 2,
                child: Center(
                  child: LableTitle((Item.Error_Amount ?? 0).toString(),
                      color: ArgonColors.text, FontSize: ArgonSize.Header4),
                ))
          ],
        ),
      );

  Widget ActionItems(PersonalProvider PersonalCase) => Container(
        padding: EdgeInsets.all(ArgonSize.Padding7),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomButton(
                  value: PersonalCase.GetLable(ResourceKey.Saglim),
                  backGroundColor: ArgonColors.primary,
                  width: getScreenWidth() / 2,
                  height: ArgonSize.HeightVeryBig,
                  function: () async {
                    bool Check = await CorrentVal(PersonalCase);
                    if (Check) {
                      setState(() {
                        IncrementVal = 1;
                        FarkVal = 0.0;
                      });
                    }
                  }),
            ),
            SizedBox(width: 20),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    LableTitle(PersonalCase.GetLable(ResourceKey.Amount)),
                    SpinBox(
                      max: 1000,
                      min: 0,
                      textStyle: TextStyle(fontSize: ArgonSize.Header3),
                      value: IncrementVal,
                      incrementIcon: Icon(
                        Icons.add_circle,
                        color: ArgonColors.myBlue,
                        size: ArgonSize.IconSizeMedium,
                      ),
                      decrementIcon: Icon(
                        Icons.remove_circle,
                        color: ArgonColors.myRed,
                        size: ArgonSize.IconSizeMedium,
                      ),
                      onChanged: (value) {
                        IncrementVal = value;
                      },
                    ),
                    SizedBox(
                      height: ArgonSize.Padding7,
                    ),
                    LableTitle(PersonalCase.GetLable(ResourceKey.Fark)),
                    SpinBox(
                      max: 1000,
                      min: -1000,
                      step: 0.5,
                      decimals: 1,
                      textStyle: TextStyle(fontSize: ArgonSize.Header3),
                      value: FarkVal,
                      incrementIcon: Icon(
                        Icons.add_circle,
                        color: ArgonColors.myBlue,
                        size: ArgonSize.IconSizeMedium,
                      ),
                      decrementIcon: Icon(
                        Icons.remove_circle,
                        color: ArgonColors.myRed,
                        size: ArgonSize.IconSizeMedium,
                      ),
                      onChanged: (value) {
                        FarkVal = value;
                      },
                    ),
                  ],
                )),
            SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: CustomButton(
                  value: PersonalCase.GetLable(ResourceKey.Error),
                  backGroundColor: ArgonColors.myRed,
                  width: getScreenWidth() / 2,
                  height: ArgonSize.HeightVeryBig,
                  function: () async {
                    bool Check = await ErrorVal(PersonalCase);
                    if (Check) {
                      setState(() {
                        IncrementVal = 1;
                        FarkVal = 0.0;
                      });
                    }
                  }),
            ),
          ],
        ),
      );

  ///

  Color IsSelected(DeptModOrderQuality_ItemsBLL Item) {
    bool CheckVal =
        (SelectedItem != null ? (SelectedItem!.Id == Item.Id) : false);
    if (CheckVal) return ArgonColors.myYellow;

    return ArgonColors.white;
  }

  Widget PastalList(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BoxMaterialCard(
        Childrens: [
          ListHeader(PersonalCase),
          ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              itemCount: Quality_Item!.length,
              itemBuilder: (context, int i) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      SelectedItem = Quality_Item![i];
                    });
                  },
                  child: Card(
                      color: IsSelected(Quality_Item![i]),
                      shadowColor: ArgonColors.black,
                      elevation: 10,
                      child: ListItem(Quality_Item![i])),
                );
              }),
          ActionItems(PersonalCase),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: ScreenAppBar(PersonalCase, context, CloseAction: () {
        CaseProvider.ReloadAction();
      }),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
                color: ArgonColors.header, FontSize: ArgonSize.Header2),
            subtitle: Text(
                PersonalCase.SelectedDepartment!.Start_Date.toString(),
                style: TextStyle(fontSize: ArgonSize.Header6)),
            dense: true,
            selected: true,
          ),
          FutureBuilder<bool>(
              future: LoadingCutttingControl(PersonalCase, CaseProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        AraControlHeader(PersonalCase),
                        PastalList(PersonalCase, CaseProvider)
                      ]);
                else
                  return LoadingContainer(IntiteStatus: IntiteStatus);
              })
        ],
      ),
    );
  }
}
