import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/ModelOrder_Matrix.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Model_Order_Control.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/ImageLoader.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'QualityItemsList.dart';
import 'SewingEmployeeControl.dart';

class FinalControl extends StatefulWidget {
  @override
  _FinalControlState createState() => _FinalControlState();
}

class _FinalControlState extends State<FinalControl> {
  int IntiteStatus = 0;
  ModelOrder_MatrixBLL? ModelOrder;
  bool OnePageShow = false;
  IconData arrowIcon = Icons.arrow_downward;

  Future<bool> LoadingOpenPage(SubCaseProvider CaseProvider) async {
    ModelOrder = await ModelOrder_MatrixBLL.Get_ModelOrder_Matrix(
        CaseProvider.ModelOrderMatrix!.Order_Id!,
        CaseProvider.ModelOrderMatrix!.Id);
    var QualityList =
        await Quality_ItemsBLL.Get_Quality_Items(GroupType.FirstQuality);
    if (ModelOrder != null && QualityList != null) {
      IntiteStatus = 1;
      CaseProvider.FirstQuality = QualityList[0];
    } else
      IntiteStatus = -1;
    return true;
  }

  Future<String> GetModelImage() async {
    return await ModelOrder!.GetModelOrderImage() ?? '';
  }

  Widget BoxHeaderInfo(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) {
    return InformationBox(
      height: OnePageShow ? ArgonSize.HeightXMedium : null,
      MainPage: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageLoader(LoadingImage: GetModelImage()),
                  LableTitle(ModelOrder!.Model_Name ?? '',
                      FontSize: ArgonSize.Header5)
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          LabelWithValue(
                              label:
                                  PersonalCase.GetLable(ResourceKey.Customer),
                              value: ModelOrder!.Customer_Name ?? '',
                              fontSize: ArgonSize.Header5),
                          LabelWithValue(
                              label:
                                  PersonalCase.GetLable(ResourceKey.Employee),
                              value:
                                  CaseProvider.QualityTracking!.Employee_Name ??
                                      '',
                              fontSize: ArgonSize.Header5),
                          LabelWithIntegerVal(
                              label: PersonalCase.GetLable(
                                  ResourceKey.Plan_Quantity),
                              value: ModelOrder!.PlanSizeColor_QTY ?? 0,
                              fontSize: ArgonSize.Header5),
                          LabelWithValue(
                              label:
                                  PersonalCase.GetLable(ResourceKey.SizeColor),
                              value:
                                  "${ModelOrder!.SizeName ?? ''}/ ${ModelOrder!.ColorName ?? ''}",
                              fontSize: ArgonSize.Header5)
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        LabelWithValue(
                            label:
                                PersonalCase.GetLable(ResourceKey.Order_Number),
                            value: ModelOrder!.Order_Number ?? '',
                            fontSize: ArgonSize.Header5),
                        LabelWithValue(
                            label: PersonalCase.GetLable(ResourceKey.Model_STD),
                            value: (ModelOrder!.Analysis_Model_STD ?? 0)
                                .toString(),
                            fontSize: ArgonSize.Header5),
                        LabelWithIntegerVal(
                            label: PersonalCase.GetLable(
                                ResourceKey.OrderSizeColor_QTY),
                            value: ModelOrder!.OrderSizeColor_QTY ?? 0,
                            fontSize: ArgonSize.Header5),
                        LabelWithIntegerVal(
                            label:
                                PersonalCase.GetLable(ResourceKey.SizeColorQTY),
                            value: ModelOrder!.SizeColor_QTY ?? 0,
                            fontSize: ArgonSize.Header5),
                      ],
                    )),
                  ]),
            ),
          ],
        ),
      ),
      function: () {
        setState(() {
          OnePageShow = !OnePageShow;
        });
      },
      icon: OnePageShow ? Icons.arrow_downward : Icons.arrow_upward,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    var mediaQuery = MediaQuery.of(context).orientation;

    SizeConfig().init(context);
    return Scaffold(
        appBar: DetailBar(
            Title: PersonalCase.SelectedTest!.Test_Name ?? '',
            PersonalCase: PersonalCase,
            OnTap: () {
              CaseProvider.ReloadAction();
              Navigator.pop(context);
            },
            context: context),
        body: ListView(
          children: [
            FutureBuilder(
              future: LoadingOpenPage(CaseProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      BoxHeaderInfo(PersonalCase, CaseProvider),
                      ProductFirstQuality(
                        FirstQualityInfo: new Model_Order_ControlBLL(
                            Control_Type: GroupType.FirstQuality,
                            QualityDept_ModelOrder_Tracking_Id:
                                CaseProvider.QualityTracking!.Id),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ProductSecondQuality(
                                SecondQualityInfo: new Model_Order_ControlBLL(
                                    Control_Type: GroupType.SecondQuality,
                                    QualityDept_ModelOrder_Tracking_Id:
                                        CaseProvider.QualityTracking!.Id),
                              ),
                            ),
                            Expanded(
                              child: ProductTamirQuality(
                                TamirQualityInfo: new Model_Order_ControlBLL(
                                    Control_Type: GroupType.TamirQuality,
                                    QualityDept_ModelOrder_Tracking_Id:
                                        CaseProvider.QualityTracking!.Id),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
            ),
          ],
        ));
  }
}

class ProductFirstQuality extends StatefulWidget {
  Model_Order_ControlBLL FirstQualityInfo;

  ProductFirstQuality({required this.FirstQualityInfo});

  @override
  _ProductFirstQualityState createState() => _ProductFirstQualityState();
}

class _ProductFirstQualityState extends State<ProductFirstQuality> {
  bool _switchValue = false;
  bool _IsDelete = false;
  Model_Order_ControlBLL? Critiera;
  int IntiteStatus = 0;
  int warning_massage = 0;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL>? ModelList =
          await widget.FirstQualityInfo.Get_Model_Order_Control();

      if (widget.FirstQualityInfo != null) {
        IntiteStatus = 1;
        widget.FirstQualityInfo = ModelList![0];
      } else {
        IntiteStatus = -1;
      }
    } catch (e) {}

    return true;
  }

  OnFirstQualityTap(PersonalCase, CaseProvider) async {
    var UserQuality = new User_QualityTracking_DetailBLL();
    UserQuality.Quality_Items_Id = CaseProvider.FirstQuality!.Id;
    UserQuality.QualityDept_ModelOrder_Tracking_Id =
        CaseProvider.QualityTracking!.Id;
    if (_IsDelete)
      UserQuality.Amount = -1;
    else
      UserQuality.Amount = 1;
    UserQuality.IsRecycle = _switchValue;
    int CheckStatus = await UserQuality.Set_UserQualityFinalControl();
    switch (CheckStatus) {
      case 0:
        setState(() {});
        break;
      case 1:
        AlertPopupDialog(
            context,
            PersonalCase.GetLable(ResourceKey.WarrningMessage),
            PersonalCase.GetLable(ResourceKey.YouCanotExceedPlanAmount));
        break;
      case -1:
        AlertPopupDialog(
            context,
            PersonalCase.GetLable(ResourceKey.WarrningMessage),
            PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return FutureBuilder(
      future: LoadingOpenPage(PersonalCase),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BoxMaterialCard(
            paddingVertical: getScreenHeight() > 1200
                ? ArgonSize.Header3
                : ArgonSize.Header4,
            Childrens: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RadioSwitch(
                      Lable: PersonalCase.GetLable(ResourceKey.RecycleReturn),
                      fontSize: ArgonSize.Header5,
                      SwitchValue: _switchValue,
                      OnTap: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomText(
                        text: PersonalCase.GetLable(
                            ResourceKey.Quality_FirstQuality),
                        size: ArgonSize.Header1,
                        color: ArgonColors.myGrey,
                      )),
                  Expanded(
                    flex: 1,
                    child: RadioSwitch(
                      Lable: PersonalCase.GetLable(ResourceKey.Delete),
                      fontSize: ArgonSize.Header5,
                      SwitchValue: _IsDelete,
                      OnTap: (value) {
                        setState(() {
                          _IsDelete = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: ArgonSize.Padding4),
              GestureDetector(
                child: ButtonWithNumber(
                  text: (widget.FirstQualityInfo.Employee_Matrix_Amount ?? 0)
                      .toString(),
                  textColor: Colors.white,
                  buttonWidth: getScreenWidth(),
                  buttonHegiht: getScreenHeight() / 8,
                  btnBgColor: ArgonColors.myGreen,
                  textSize: ArgonSize.BigHeader,
                  topLeft: CircleShape(
                    text: (widget.FirstQualityInfo.Matrix_Control_Amount ?? 0)
                        .toString(),
                    width: ArgonSize.Width1,
                    height: ArgonSize.Height1,
                    fontSize: ArgonSize.Header4,
                  ),
                ),
                onTap: () async {
                  await OnFirstQualityTap(PersonalCase, CaseProvider);
                },
              ),
            ],
            topRight: warning_massage > 0
                ? CircularIconWithNumber(
                    icon: FontAwesomeIcons.exclamation,
                    backGroundColor: Colors.red,
                    iconColor: Colors.white,
                    size: ArgonSize.Header5,
                    bubbleHeight: ArgonSize.WidthSmall / 2,
                    bubbleWidth: ArgonSize.WidthSmall / 2,
                    bubbleText: warning_massage.toString(),
                    bubbleTextSize: ArgonSize.Header7,
                    bubbleBgColor: Colors.red[900]!)
                : Container(width: 0, height: 0),
            bottomRight: _IsDelete == true
                ? IconInsideCircle(
                    icon: FontAwesomeIcons.minus,
                    iconSize: ArgonSize.Header3,
                    size: ArgonSize.Header5,
                    color: Colors.white,
                    backGroundColor: Colors.red)
                : Container(width: 0, height: 0),
          );
        } else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
              ActionName: PersonalCase.GetLable(ResourceKey.Loading),
              MessageError:
                  PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
              DetailError:
                  PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
      },
    );
  }
}

class ProductSecondQuality extends StatefulWidget {
  Model_Order_ControlBLL SecondQualityInfo;

  ProductSecondQuality({required this.SecondQualityInfo});

  @override
  _ProductSecondQualityState createState() => _ProductSecondQualityState();
}

class _ProductSecondQualityState extends State<ProductSecondQuality> {
  Model_Order_ControlBLL? Critiera;
  int IntiteStatus = 0;
  Quality_ItemsBLL? SecqStitch;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL>? ModelList =
          await widget.SecondQualityInfo.Get_Model_Order_Control();

      SecqStitch = await Quality_ItemsBLL.Get_StitchQuality_Items(
          GroupType.SecondQuality);

      if (widget.SecondQualityInfo != null) {
        IntiteStatus = 1;
        widget.SecondQualityInfo = ModelList![0];
      } else {
        IntiteStatus = -1;
      }
    } catch (e) {}

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return FutureBuilder(
      future: LoadingOpenPage(PersonalCase),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BoxMaterialCard(
            paddingVertical: getScreenHeight() > 1200
                ? ArgonSize.Header3
                : ArgonSize.Header5,
            Childrens: <Widget>[
              Column(children: [
                CustomText(
                  text: PersonalCase.GetLable(ResourceKey.SecondQuality),
                  size: ArgonSize.Header3,
                  color: ArgonColors.myGrey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new QualityItemsList(
                              GroupType: GroupType.SecondQuality,
                              HeaderName: PersonalCase.GetLable(
                                  ResourceKey.SecondQuality),
                              ParentReCalc: () {
                                setState(() {});
                              })),
                    );
                  },
                  child: ButtonWithNumber(
                    text: (widget.SecondQualityInfo.Employee_Matrix_Amount ?? 0)
                        .toString(),
                    textColor: Colors.black,
                    buttonWidth: getScreenWidth() / 2,
                    buttonHegiht: getScreenHeight() / 10,
                    btnBgColor: ArgonColors.myOrange,
                    textSize: ArgonSize.Header1,
                    topLeft: CircleShape(
                        text: (widget.SecondQualityInfo.Matrix_Control_Amount ??
                                0)
                            .toString(),
                        width: ArgonSize.Header1,
                        height: ArgonSize.Header1,
                        fontSize: ArgonSize.Header5),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SewingEmployeeControl(
                              QualityItem: SecqStitch!,
                              HeaderName: PersonalCase.GetLable(
                                  ResourceKey.SecondQuality),
                              ParentReCalc: () {
                                setState(() {});
                              })),
                    );
                  },
                  child: ButtonWithNumber(
                    text: PersonalCase.GetLable(ResourceKey.Sewing_Error),
                    textColor: Colors.black,
                    buttonWidth: getScreenWidth() / 2,
                    buttonHegiht: getScreenHeight() / 9,
                    btnBgColor: ArgonColors.myOrange,
                    textSize: ArgonSize.Header4,
                    image: Image.asset('lib/assets/images/sewing.png',
                        width: 100, height: 50),
                  ),
                ),
              ])
            ],
          );
        } else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
              ActionName: PersonalCase.GetLable(ResourceKey.Loading),
              MessageError:
                  PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
              DetailError:
                  PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
      },
    );
  }
}

class ProductTamirQuality extends StatefulWidget {
  Model_Order_ControlBLL TamirQualityInfo;

  ProductTamirQuality({required this.TamirQualityInfo});

  @override
  _ProductTamirQualityState createState() => _ProductTamirQualityState();
}

class _ProductTamirQualityState extends State<ProductTamirQuality> {
  Model_Order_ControlBLL? Critiera;
  Quality_ItemsBLL? TamirStitch;

  int IntiteStatus = 0;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL>? ModelList =
          await widget.TamirQualityInfo.Get_Model_Order_Control();

      TamirStitch = await Quality_ItemsBLL.Get_StitchQuality_Items(
          GroupType.TamirQuality);

      if (widget.TamirQualityInfo != null) {
        IntiteStatus = 1;
        widget.TamirQualityInfo = ModelList![0];
      } else {
        IntiteStatus = -1;
      }
    } catch (e) {}

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return FutureBuilder(
      future: LoadingOpenPage(PersonalCase),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BoxMaterialCard(
            paddingVertical: getScreenHeight() > 1200
                ? ArgonSize.Header3
                : ArgonSize.Header5,
            Childrens: <Widget>[
              Column(children: [
                CustomText(
                  text: PersonalCase.GetLable(ResourceKey.Quality_TAMIR),
                  size: ArgonSize.Header3,
                  color: ArgonColors.myGrey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new QualityItemsList(
                              GroupType: GroupType.TamirQuality,
                              HeaderName:
                                  PersonalCase.GetLable(ResourceKey.TamirList),
                              ParentReCalc: () {
                                setState(() {});
                              })),
                    );
                  },
                  child: ButtonWithNumber(
                    text: (widget.TamirQualityInfo.Employee_Matrix_Amount ?? 0)
                        .toString(),
                    textColor: Colors.black,
                    buttonWidth: getScreenWidth() / 2,
                    buttonHegiht: getScreenHeight() / 10,
                    btnBgColor: ArgonColors.myYellow,
                    textSize: ArgonSize.Header1,

                    ///TODO : DO THE NUMBERS IN CIRCLE
                    topLeft: CircleShape(
                        text:
                            (widget.TamirQualityInfo.Matrix_Control_Amount ?? 0)
                                .toString(),
                        width: ArgonSize.Header1,
                        height: ArgonSize.Header1,
                        fontSize: ArgonSize.Header5),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SewingEmployeeControl(
                              QualityItem: TamirStitch!,
                              HeaderName: PersonalCase.GetLable(
                                  ResourceKey.SecondQuality),
                              ParentReCalc: () {
                                setState(() {});
                              })),
                    );
                  },
                  child: ButtonWithNumber(
                    text: PersonalCase.GetLable(ResourceKey.Sewing_Fixing),
                    textColor: Colors.black,
                    buttonWidth: getScreenWidth() / 2,
                    buttonHegiht: getScreenHeight() / 9,
                    btnBgColor: ArgonColors.myYellow,
                    textSize: ArgonSize.Header4,
                    image: Image.asset('lib/assets/images/sewing.png',
                        width: 100, height: 50),
                  ),
                ),
              ])
            ],
          );
        } else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
              ActionName: PersonalCase.GetLable(ResourceKey.Loading),
              MessageError:
                  PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
              DetailError:
                  PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
      },
    );
  }
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
