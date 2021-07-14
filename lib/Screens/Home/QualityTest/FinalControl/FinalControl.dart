import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/ModelOrder_Matrix.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Model_Order_Control.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/Dikim_InlineProcess.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/ImageLoader.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
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
  ModelOrder_MatrixBLL ModelOrder;

  Future<bool> LoadingOpenPage(SubCaseProvider CaseProvider) async {
    ModelOrder = await ModelOrder_MatrixBLL.Get_ModelOrder_Matrix(
        CaseProvider.ModelOrderMatrix.Order_Id,
        CaseProvider.ModelOrderMatrix.Id);
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
    return await ModelOrder.GetModelOrderImage();
  }

  Widget ProductDetail(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) {
    return BoxMaterialCard(
      Childrens: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageLoader(LoadingImage: GetModelImage()),
                  SizedBox(
                    height: 10,
                  ),
                  LableTitle(ModelOrder.Model_Name)
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
                              value: ModelOrder.Customer_Name),
                          LabelWithValue(
                              label:
                                  PersonalCase.GetLable(ResourceKey.Employee),
                              value:
                                  CaseProvider.QualityTracking.Employee_Name),
                          LabelWithIntegerVal(
                              label: PersonalCase.GetLable(
                                  ResourceKey.Plan_Quantity),
                              value: ModelOrder.PlanSizeColor_QTY),
                          LabelWithValue(
                              label:
                                  PersonalCase.GetLable(ResourceKey.SizeColor),
                              value:
                                  "${ModelOrder.SizeName}/ ${ModelOrder.ColorName}")
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        LabelWithValue(
                            label:
                                PersonalCase.GetLable(ResourceKey.Order_Number),
                            value: ModelOrder.Order_Number),
                        LabelWithValue(
                            label: PersonalCase.GetLable(ResourceKey.Model_STD),
                            value: (ModelOrder.Analysis_Model_STD ?? 0)
                                .toString()),
                        LabelWithIntegerVal(
                            label: PersonalCase.GetLable(
                                ResourceKey.OrderSizeColor_QTY),
                            value: ModelOrder.OrderSizeColor_QTY),
                        LabelWithIntegerVal(
                            label:
                                PersonalCase.GetLable(ResourceKey.SizeColorQTY),
                            value: ModelOrder.SizeColor_QTY),
                      ],
                    )),
                  ]),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    var mediaQuery = MediaQuery.of(context).orientation;

    SizeConfig().init(context);
    return Scaffold(
        appBar:
            DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
          Navigator.pop(context);
        }),
        body: ListView(
          children: [
            FutureBuilder(
              future: LoadingOpenPage(CaseProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                          child: ProductDetail(PersonalCase, CaseProvider)),
                      Container(
                        child: ProductFirstQuality(
                          FirstQualityInfo: new Model_Order_ControlBLL(
                              Control_Type: GroupType.FirstQuality,
                              QualityDept_ModelOrder_Tracking_Id:
                                  CaseProvider.QualityTracking.Id),
                        ),
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
                                        CaseProvider.QualityTracking.Id),
                              ),
                            ),
                            Expanded(
                              child: ProductTamirQuality(
                                TamirQualityInfo: new Model_Order_ControlBLL(
                                    Control_Type: GroupType.TamirQuality,
                                    QualityDept_ModelOrder_Tracking_Id:
                                        CaseProvider.QualityTracking.Id),
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

  ProductFirstQuality({this.FirstQualityInfo});

  @override
  _ProductFirstQualityState createState() => _ProductFirstQualityState();
}

class _ProductFirstQualityState extends State<ProductFirstQuality> {
  bool _switchValue = false;
  Model_Order_ControlBLL Critiera;
  int IntiteStatus = 0;
  int warning_massage = 0;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL> ModelList =
          await widget.FirstQualityInfo.Get_Model_Order_Control();

      if (widget.FirstQualityInfo != null) {
        IntiteStatus = 1;
        widget.FirstQualityInfo = ModelList[0];
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
            Childrens: <Widget>[
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(children: [
                        Text(
                          PersonalCase.GetLable(ResourceKey.RecycleReturn),
                          style: TextStyle(
                              color: ArgonColors.myBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                          ),
                        ),
                      ])),
                  Expanded(
                      flex: 4,
                      child: CustomText(
                        text: PersonalCase.GetLable(
                            ResourceKey.Quality_FirstQuality),
                        size:
                            AdaptiveTextSize().getadaptiveTextSize(context, 30),
                        color: ArgonColors.myGrey,
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
              GestureDetector(
                onTap: () async {
                  var UserQuality = new User_QualityTracking_DetailBLL();
                  UserQuality.Quality_Items_Id = CaseProvider.FirstQuality.Id;
                  UserQuality.QualityDept_ModelOrder_Tracking_Id =
                      CaseProvider.QualityTracking.Id;
                  UserQuality.Amount = 1;
                  UserQuality.IsRecycle = _switchValue;
                  int CheckStatus =
                      await UserQuality.Set_UserQualityFinalControl();
                  switch (CheckStatus) {
                    case 0:
                      setState(() {});
                      break;
                    case 1:
                      AlertPopupDialog(
                          context,
                          PersonalCase.GetLable(ResourceKey.WarrningMessage),
                          PersonalCase.GetLable(
                              ResourceKey.YouCanotExceedPlanAmount));
                      break;
                    case -1:
                      AlertPopupDialog(
                          context,
                          PersonalCase.GetLable(ResourceKey.WarrningMessage),
                          PersonalCase.GetLable(
                              ResourceKey.ErrorWhileLoadingData));
                      break;
                  }
                },
                child: ButtonWithNumber(
                  text: (widget.FirstQualityInfo.Employee_Matrix_Amount ?? 0)
                      .toString(),
                  textColor: Colors.white,
                  buttonWidth: getScreenWidth() / 2,
                  buttonHegiht: getScreenHeight()/8,
                  btnBgColor: ArgonColors.myGreen,
                  textSize: 26,
                  topLeft: CircleShape(
                      text: (widget.FirstQualityInfo.Matrix_Control_Amount ?? 0)
                          .toString(),
                      width: 40,
                      height: 40),
                ),
              ),
            ],
            topRight: warning_massage != 0
                ? CircularIconWithNumber(
                    icon: FontAwesomeIcons.exclamation,
                    backGroundColor: Colors.red,
                    iconColor: Colors.white,
                    size: 10,
                    bubbleHeight: 15,
                    bubbleWidth: 15,
                    bubbleText: warning_massage.toString(),
                  )
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

  ProductSecondQuality({this.SecondQualityInfo});

  @override
  _ProductSecondQualityState createState() => _ProductSecondQualityState();
}

class _ProductSecondQualityState extends State<ProductSecondQuality> {
  Model_Order_ControlBLL Critiera;
  int IntiteStatus = 0;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL> ModelList =
          await widget.SecondQualityInfo.Get_Model_Order_Control();

      if (widget.SecondQualityInfo != null) {
        IntiteStatus = 1;
        widget.SecondQualityInfo = ModelList[0];
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
            Childrens: <Widget>[
              Column(children: [
                CustomText(
                  text: PersonalCase.GetLable(ResourceKey.SecondQuality),
                  size: AdaptiveTextSize().getadaptiveTextSize(context, 20),
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
                    buttonHegiht: getScreenHeight()/10,
                    btnBgColor: ArgonColors.myOrange,
                    textSize: 25,
                    padding: 10,
                    topLeft: CircleShape(
                        text: (widget.SecondQualityInfo.Matrix_Control_Amount ??
                                0)
                            .toString(),
                        width: 30,
                        height: 30,
                        fontSize: 10),

                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SewingEmployeeControl(
                              GroupType: GroupType.SecondQuality,
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
                    buttonHegiht: getScreenHeight()/9,
                    btnBgColor: ArgonColors.myOrange,
                    textSize: 15,
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

  ProductTamirQuality({this.TamirQualityInfo});

  @override
  _ProductTamirQualityState createState() => _ProductTamirQualityState();
}

class _ProductTamirQualityState extends State<ProductTamirQuality> {
  Model_Order_ControlBLL Critiera;
  int IntiteStatus = 0;

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      List<Model_Order_ControlBLL> ModelList =
          await widget.TamirQualityInfo.Get_Model_Order_Control();

      if (widget.TamirQualityInfo != null) {
        IntiteStatus = 1;
        widget.TamirQualityInfo = ModelList[0];
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
            Childrens: <Widget>[
              Column(children: [
                CustomText(
                  text: PersonalCase.GetLable(ResourceKey.Quality_TAMIR),
                  size: AdaptiveTextSize().getadaptiveTextSize(context, 20),
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
                    buttonHegiht: getScreenHeight()/10,
                    btnBgColor: ArgonColors.myYellow,
                    textSize: 25,
                    padding: 10,

                    ///TODO : DO THE NUMBERS IN CIRCLE
                    topLeft: CircleShape(
                        text:
                            (widget.TamirQualityInfo.Matrix_Control_Amount ?? 0)
                                .toString(),
                        width: 30,
                        height: 30,
                        fontSize: 10),
                  ),
                ),

////
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new SewingEmployeeControl(
                              GroupType: GroupType.TamirQuality,
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
                    buttonWidth:  getScreenWidth() / 2,
                    buttonHegiht: getScreenHeight()/10,
                    btnBgColor: ArgonColors.myYellow,
                    textSize: 15,
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

AppBar MyAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text('ITM Tech Soft'),
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios_outlined, // add custom icons also
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 20.0),
      ),
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Icon(Icons.more_vert),
        ),
      ),
    ],
  );
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
