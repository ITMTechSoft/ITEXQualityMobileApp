import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

import 'ErrorFixing.dart';

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
    var QualityList = await Quality_ItemsBLL.Get_Quality_Items(
        GroupType.FirstQuality);
    if (ModelOrder != null && QualityList != null) {
      IntiteStatus = 1;
      CaseProvider.FirstQuality = QualityList[0];
    }
    else
      IntiteStatus = -1;
    return true;
  }

  Future<String> GetModelImage() async {
    return await ModelOrder.GetModelOrderImage();
  }

  Widget ProductDetail(PersonalProvider PersonalCase,
      SubCaseProvider CaseProvider) {
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
                  ImageLoader(
                      LoadingImage: GetModelImage()),
                  SizedBox(height: 10,),
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
                              label: PersonalCase.GetLable(
                                  ResourceKey.Employee),
                              value: CaseProvider.QualityTracking
                                  .Employee_Name),
                          LabelWithIntegerVal(
                              label: PersonalCase.GetLable(
                                  ResourceKey.Plan_Quantity),
                              value: ModelOrder.PlanSizeColor_QTY),
                          LabelWithValue(
                              label:
                              PersonalCase.GetLable(ResourceKey.SizeColor),
                              value: "${ModelOrder.SizeName}/ ${ModelOrder
                                  .ColorName}")
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
                                label: PersonalCase.GetLable(
                                    ResourceKey.Model_STD),
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
    var mediaQuery = MediaQuery
        .of(context)
        .orientation;

    SizeConfig().init(context);
    return Scaffold(
        appBar:
        DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
          Navigator.pop(context);
        }),
        body: ListView(
          children: [
            Container(
                height: mediaQuery == Orientation.portrait
                    ? getScreenHeight() / 15.5
                    : getScreenWidth() / 4,
                child: ListTile(
                  title: HeaderTitle(PersonalCase.SelectedOrder.Order_Number,
                      color: ArgonColors.header, FontSize: ArgonSize.Header2),
                  subtitle: Text(
                      PersonalCase.SelectedDepartment.Start_Date.toString()),
                  dense: true,
                  selected: true,
                )),
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
                              QualityDept_ModelOrder_Tracking_Id: CaseProvider
                                  .QualityTracking.Id
                          ),),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ProductSecondQuality(),
                            ),
                            Expanded(
                              child: ProductTamirQuality(),
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

  Future<bool> LoadingOpenPage(PersonalProvider PersonalCase) async {
    try {
      await widget.FirstQualityInfo.Get_Model_Order_Control();
    } catch (e) {

    }
    if (widget.FirstQualityInfo != null) {
      IntiteStatus = 1;
    } else {
      IntiteStatus = -1;
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                      child: CustomText(
                        text: PersonalCase.GetLable(
                            ResourceKey.Quality_FirstQuality),
                        size: 30,
                        color: ArgonColors.myGrey,
                      )),
                  Expanded(
                      child: IconButton(
                        icon: Icon(Icons.warning_amber_sharp,
                            color: Colors.redAccent),
                        onPressed: () {
                          setState(() async {});
                        },
                      )),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                  width: 300,
                  height: 70,
                  value: (widget.FirstQualityInfo.Employee_Matrix_Amount ?? 0)
                      .toString(),
                  textColor: Colors.white,
                  backGroundColor: ArgonColors.myGreen,
                  textSize: 30,
                  function: () async {
                    var UserQuality = new User_QualityTracking_DetailBLL();
                    UserQuality.Quality_Items_Id = CaseProvider.FirstQuality.Id;
                    UserQuality.QualityDept_ModelOrder_Tracking_Id = CaseProvider.QualityTracking.Id;
                    UserQuality.Amount = 1;
                    UserQuality.IsRecycle = _switchValue;
                    int CheckStatus = await UserQuality.Set_UserQualityFinalControl();
                    switch (CheckStatus) {
                      case 0:
                        setState(() {

                        });
                        break;
                      case 1:
                        AlertPopupDialog(context,
                            PersonalCase.GetLable(ResourceKey.WarrningMessage),
                            PersonalCase.GetLable(ResourceKey.YouCanotExceedPlanAmount));
                        break;
                      case -1:
                        AlertPopupDialog(context,
                            PersonalCase.GetLable(ResourceKey.WarrningMessage),
                            PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData));
                        break;
                    }
                  })

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
    );
  }
}


class ProductSecondQuality extends StatefulWidget {

  @override
  _ProductSecondQualityState createState() => _ProductSecondQualityState();
}

class _ProductSecondQualityState extends State<ProductSecondQuality> {
  @override
  Widget build(BuildContext context) {
    return BoxMaterialCard(
      Childrens: <Widget>[Column(children: [
        CustomText(
          text: "2.Kalite",
          size: 25,
          color: ArgonColors.myGrey,
        ),
        SizedBox(height: 20),
        CustomButton(
            width: 200,
            height: 60,
            value: "100",
            textColor: Colors.white,
            backGroundColor: ArgonColors.myRed,
            textSize: 30,
            function: () {}),
        SizedBox(height: 20),
        CustomButton(
            width: 200,
            height: 60,
            value: 'Dikim',
            textColor: Colors.white,
            backGroundColor: ArgonColors.Invalid,
            textSize: 30,
            function: () {})
      ])
      ],
    );
  }
}

class ProductTamirQuality extends StatefulWidget {

  @override
  _ProductTamirQualityState createState() => _ProductTamirQualityState();
}

class _ProductTamirQualityState extends State<ProductTamirQuality> {
  @override
  Widget build(BuildContext context) {
    return BoxMaterialCard(
      Childrens: <Widget>[Column(children: [
        CustomText(
          text: "Tamir",
          size: 25,
          color: ArgonColors.myGrey,
        ),
        SizedBox(height: 20),
        CustomButton(
            width: 200,
            height: 60,
            value: '150',
            textColor: Colors.white,
            textSize: 30,
            backGroundColor: ArgonColors.myYellow,
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ErrorFixing()),
              );
            }),
        SizedBox(height: 20),
        CustomButton(
            width: 200,
            height: 60,
            value: 'Dikim',
            textColor: Colors.white,
            backGroundColor: ArgonColors.myYellow,
            textSize: 30,
            function: () {
              print('Dikim ');
            }),
      ])
      ],
    );
  }
}


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.value,
    this.function,
    this.backGroundColor,
    this.width,
    this.height,
    this.textColor,
    this.textSize = 20,
  }) : super(key: key);

  final String value;

  final Function function;

  final Color backGroundColor;
  final Color textColor;
  final double width;

  final double height;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backGroundColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: function,
        child: CustomText(
          text: value,
          size: textSize,
          color: textColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  final TextDecoration textDecoration;
  final TextAlign textAlign;

  const CustomText({Key key,
    this.text,
    this.size,
    this.color = ArgonColors.Title,
    this.fontWeight = FontWeight.bold,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
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
