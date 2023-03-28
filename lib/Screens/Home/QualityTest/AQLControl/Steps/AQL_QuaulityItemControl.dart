import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/TakeImageCamera.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/MyLabeledInput.dart';
import 'package:itex_soft_qualityapp/Widgets/SwitchWidget.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';

class QuaulityItemControl extends StatefulWidget {
  List<Quality_ItemsBLL> ListQualityItems;

  QuaulityItemControl(this.ListQualityItems);

  @override
  State<QuaulityItemControl> createState() => _QuaulityItemControlState();
}

class _QuaulityItemControlState extends State<QuaulityItemControl> {
  List<Quality_ItemsBLL>? QualityItems;

  bool _FilterMinor = false;
  bool _FilterMajor = false;
  String? _FilterName = null;
  bool _IsDeletedVal = false;

  @override
  Widget build(BuildContext context) {
    QualityItems = widget.ListQualityItems ?? [];
    if (_FilterMajor)
      QualityItems =
          widget.ListQualityItems.where((element) => element.Item_Level == 6)
              .toList();

    if (_FilterMinor)
      QualityItems =
          widget.ListQualityItems.where((element) => element.Item_Level == 5)
              .toList();

    if (_FilterName != null)
      QualityItems = widget.ListQualityItems.where((element) => element
          .Item_Name!
          .toLowerCase()
          .contains(_FilterName!.toLowerCase())).toList();

    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        MainInformationBox(PersonalCase, CaseProvider),
        SampleList(context, PersonalCase, CaseProvider)
      ],
    );
  }

  Widget MainInformationBox(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) {
    String ColorName = PersonalCase.GetLable(ResourceKey.ColorName);
    String SizeName = PersonalCase.GetLable(ResourceKey.SizeName);
    String SampleNo = PersonalCase.GetLable(ResourceKey.SampleNo);
    String Color = (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? '');
    String Size = (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? '');
    String Sample = (CaseProvider.QualityTracking!.SampleNo ?? 0).toString();
    String Minor = PersonalCase.GetLable(ResourceKey.Minor);
    String Major = PersonalCase.GetLable(ResourceKey.Major);

    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardRow("$ColorName - $SizeName", SampleNo, "$Color / $Size",
              "Sample  / $Sample "),
          SizedBox(height: 8),
          CardRow(
              Minor, Major, (GetMinor()).toString(), (GetMajor()).toString()),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterSwitch("Minor", _FilterMinor, (value) {
                setState(() {
                  _FilterMinor = value;
                  _FilterMajor = false;
                  _FilterName = null;
                });
              }),
              MyLabeledInput(
                  labelText: "Filter",
                  initialValue: _FilterName,
                  onChanged: (value) {
                    setState(() {
                      _FilterMajor = _FilterMinor = false;
                      _FilterName = value;
                    });
                  },),
              FilterSwitch("Major", _FilterMajor, (value) {
                setState(() {
                  _FilterMajor = value;
                  _FilterMinor = false;
                  _FilterName = null;
                });
              }),
            ],
          ),
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  int GetMinor() {
    int Minor = 0;
    for (int i = 0; i < widget.ListQualityItems!.length; i++)
      if (widget.ListQualityItems![i].Item_Level == 5)
        Minor += (widget.ListQualityItems![i].Amount ?? 0);

    return Minor;
  }

  int GetMajor() {
    int Major = 0;
    for (int i = 0; i < widget.ListQualityItems!.length; i++) {
      if (widget.ListQualityItems![i].Item_Level != 5)
        Major += (widget.ListQualityItems![i].Amount ?? 0);

      if (widget.ListQualityItems![i].Item_Level ==
          5) if (widget.ListQualityItems![i].Minor! > 0)
        Major += ((widget.ListQualityItems![i].Amount ?? 0) /
                (widget.ListQualityItems![i].Minor ?? 1))
            .toInt();
    }

    return Major;
  }

  Widget SampleList(context, PersonalCase, SubCaseProvider CaseProvider) {
    Future OnTapQualityItem(Quality_ItemsBLL item, index) async {
      var UserQuality = new User_QualityTracking_DetailBLL();
      UserQuality.Quality_Items_Id = item.Id;
      UserQuality.QualityDept_ModelOrder_Tracking_Id =
          CaseProvider.QualityTracking!.Id;

      if (_IsDeletedVal)
        UserQuality.Amount = -1;
      else
        UserQuality.Amount = 1;

      if (_IsDeletedVal == false && (item.IsTakeImage ?? false)) {
        UserQuality.Image64 = await TakeImageFromCamera();
      }

      bool CheckStatus = await UserQuality.Set_QualityAQLError();

      if (CheckStatus)
        setState(() {
          if (_IsDeletedVal) {
            if ((QualityItems![index].Amount ?? 0) > 0)
              QualityItems![index].Amount =
                  (QualityItems![index].Amount ?? 0) - 1;
          } else
            QualityItems![index].Amount =
                (QualityItems![index].Amount ?? 0) + 1;
        });
    }

    int GetMajorValue(Quality_ItemsBLL item) {
      if (item.Item_Level == 5) {
        if ((item.Minor ?? 0) > 0) {
          return ((item.Amount ?? 0) / item.Minor!).toInt();
        }
      } else
        return (item.Amount ?? 0);

      return 0;
    }

    return BoxMaterialCard(Childrens: <Widget>[
      GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: getScreenWidth() > 500 ? 3 / 2 : 7 / 6,
        crossAxisCount: 3,
        children: List.generate(QualityItems!.length, (index) {
          return ButtonWithNumber(
              text: QualityItems![index].Item_Name!,
              buttonWidth: getScreenWidth() / 3,
              buttonHegiht: getScreenHeight() / 6,
              textColor: Color(QualityItems![index].Font_Color ?? 2315255808),
              btnBgColor:
                  Color(QualityItems![index].Item_Hex_Color ?? -2519964),
              textSize: (QualityItems![index].Font_Size ?? ArgonSize.Header4)
                  .toDouble(),
              topRight: CircleShape(
                  text: GetMajorValue(QualityItems![index]).toString(),
                  width: ArgonSize.WidthSmall,
                  height: ArgonSize.WidthSmall,
                  color: Color(QualityItems![index].Circle_Color ?? 4278204558),
                  fontSize: ArgonSize.Header4),
              topLeft: QualityItems![index].Item_Level == 5
                  ? CircleShape(
                      text: (QualityItems![index].Amount ?? 0).toString(),
                      width: ArgonSize.WidthSmall,
                      height: ArgonSize.WidthSmall,
                      color: ArgonColors.myYellow,
                      textColor: ArgonColors.myBlue,
                      fontSize: ArgonSize.Header4)
                  : Container(width: 0, height: 0),
              bottomRight: _IsDeletedVal == true
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
              bottomLeft: QualityItems![index].IsTakeImage == true
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
              OnTap: () async {
                await OnTapQualityItem(QualityItems![index], index);
              });
        }, growable: false),
      ),
    ]);
  }
}
