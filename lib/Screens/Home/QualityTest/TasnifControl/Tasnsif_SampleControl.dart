import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Tasnsif_SampleControl extends StatefulWidget {
  @override
  _Tasnsif_SampleControlState createState() => _Tasnsif_SampleControlState();
}

class _Tasnsif_SampleControlState extends State<Tasnsif_SampleControl> {
  int IntiteStatus = 0;
  int AssignAmount = 1;

  bool showSmall = true;
  IconData arrowIcon = Icons.arrow_downward;
  DeptModOrderQuality_ItemsBLL XAxias = new DeptModOrderQuality_ItemsBLL();

  DeptModOrderQuality_ItemsBLL YAxias = new DeptModOrderQuality_ItemsBLL();

  final TextEditingController SampleAmountController =
      new TextEditingController();

  List<DeptModOrderQuality_ItemsBLL> XAxsiasItems;
  List<DeptModOrderQuality_ItemsBLL> YAxsiasItems;

  /* Future<List<QualityDept_ModelOrder_TrackingBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<QualityDept_ModelOrder_TrackingBLL> Criteria =
    await QualityDept_ModelOrder_TrackingBLL.Get_QualityDept_ModelOrder_TrackingBLL(
        PersonalCase.SelectedOrder.Order_Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }*/

  LoadingOpenPage(PersonalProvider PersonalCase) async {
    List<DeptModOrderQuality_ItemsBLL> Criteria =
        await DeptModOrderQuality_ItemsBLL.Get_DeptModOrderQualityTest_Items(
            PersonalCase.SelectedTest.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      XAxsiasItems =
          Criteria.where((element) => element.Item_Level == ItemLevel.XAxis)
              .toList();
      YAxsiasItems =
          Criteria.where((element) => element.Item_Level == ItemLevel.YAxis)
              .toList();
      SampleAmountController.text = "1";
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  RegisterSampeAmount(PersonalCase, bool IsCorrect) async {
    int ActionStatus = 0;
    if (XAxias.Id == null) ActionStatus = 1;

    if (YAxias.Id == null) ActionStatus = 2;

    int SampleAmount = int.tryParse(SampleAmountController.text);
    if (SampleAmount == 0) ActionStatus = 3;

    if (ActionStatus == 0) {
      var UsrQualityTrac = User_QualityTracking_DetailBLL();
      UsrQualityTrac.QualityDept_ModelOrder_Tracking_Id =
          PersonalCase.SelectedTracking.Id;
      UsrQualityTrac.Create_Date = DateTime.now();
      UsrQualityTrac.Xaxis_QualityItem_Id = XAxias.Id;
      UsrQualityTrac.Yaxis_QualityItem_Id = YAxias.Id;
      if (IsCorrect)
        UsrQualityTrac.Correct_Amount =
            int.tryParse(SampleAmountController.text);
      else
        UsrQualityTrac.Error_Amount = int.tryParse(SampleAmountController.text);

      await UsrQualityTrac.Set_User_QualityTracking_Detail();
    } else {
      AlertPopupDialog(
          context,
          PersonalCase.GetLable(ResourceKey.SaveErrorMessage),
          PersonalCase.GetLable(ResourceKey.MandatoryFields),
          ActionLable: PersonalCase.GetLable(ResourceKey.Okay));
    }
  }

  Widget HeaderPage(PersonalCase) => ListTile(
        title: HeaderTitle(PersonalCase.SelectedOrder.Order_Number,
            color: ArgonColors.header, FontSize: ArgonSize.Header2),
        subtitle: Text(PersonalCase.SelectedDepartment.Start_Date.toString(),style:TextStyle(fontSize:ArgonSize.Header6)),
        dense: true,
        selected: true,
      );

  Widget MainInformationBox(PersonalProvider PersonalCase) =>
    showSmall == true ?InformationBoxSmall(icon: arrowIcon,height:60,function : (){
      setState(() {
        showSmall = !showSmall;
        arrowIcon = Icons.arrow_upward;
      });

    },MainPage:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 2,
                child: LableTitle(

                        PersonalCase.GetLable(ResourceKey.Model))),


            Expanded(
                flex: 2,
                child: LableTitle(PersonalCase.SelectedOrder.Model_Name,
                    color: ArgonColors.text)),
          ],
        ),

      ],
    )):  InformationBox(icon:arrowIcon,function : (){
      setState(() {
        showSmall = !showSmall;
        arrowIcon = Icons.arrow_downward;

      });
    },MainPage:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.Model))),


              Expanded(
                  flex: 2,
                  child: LableTitle(PersonalCase.SelectedOrder.Model_Name,
                      color: ArgonColors.text)),
            ],
          ),
          SizedBox(height:8),

          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      '${PersonalCase.GetLable(ResourceKey.Sample_Amount)} / '
                      '${PersonalCase.GetLable(ResourceKey.Fabric_TopNo)} ')),
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      (PersonalCase.SelectedTracking.Sample_Amount ?? 0)
                          .toString(),
                      color: ArgonColors.text)),
              Expanded(
                  flex: 2,
                  child: LableTitle(PersonalCase.SelectedTracking.Fabric_TopNo,
                      color: ArgonColors.text)),
            ],
          ),
          SizedBox(height:8),

          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      '${PersonalCase.GetLable(ResourceKey.SizeName)} / '
                      '${PersonalCase.GetLable(ResourceKey.ColorName)}')),
              Expanded(
                  flex: 2,
                  child: LableTitle(PersonalCase.SelectedTracking.SizeName,
                      color: ArgonColors.text)),
              Expanded(
                  flex: 2,
                  child: LableTitle(PersonalCase.SelectedTracking.ColorName,
                      color: ArgonColors.text)),
            ],
          ),
          SizedBox(height:8),

          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      '${PersonalCase.GetLable(ResourceKey.PlanningAmount)} / '
                      '${PersonalCase.GetLable(ResourceKey.OrderSizeColor_QTY)}')),
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      (PersonalCase.SelectedTracking.SizeColor_QTY ?? 0)
                          .toString(),
                      color: ArgonColors.text)),
              Expanded(
                  flex: 2,
                  child: LableTitle(
                      (PersonalCase.SelectedTracking.OrderSizeColor_QTY ?? 0)
                          .toString(),
                      color: ArgonColors.text)),
            ],
          )
        ],
      ));

  Widget GroupLevel(PersonalProvider PersonalCase) => Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ExpandedLableTitle(PersonalCase.GetLable(ResourceKey.ErrorGroup),
                IsCenter: true ,FontSize:ArgonSize.Header4),
            ExpandedLableTitle(
                PersonalCase.SelectedTracking.Group_Name ??
                    PersonalCase.GetLable(ResourceKey.ALL),
                color: ArgonColors.text,
                IsCenter: true,
                FontSize:ArgonSize.Header4),
          ],
        ),
      );

  Widget AxisItem(PersonalProvider PersonalCase) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Container(
                height: getScreenHeight()/2.5,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: XAxsiasItems.length,
                itemBuilder: (context, int i) {
                  return QualityAxisItem(XAxsiasItems[i],
                      IsSeleted: (XAxias.Id == XAxsiasItems[i].Id), OnTap: () {
                    setState(() {
                      XAxias = XAxsiasItems[i];
                    });
                  });
                }),
          )),
          Expanded(
              child: Container(
                       height: getScreenHeight()/2.5,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: YAxsiasItems.length,
                itemBuilder: (context, int i) {
                  return QualityAxisItem(YAxsiasItems[i],
                      IsSeleted: YAxsiasItems[i].Id == YAxias.Id, OnTap: () {
                    setState(() {
                      YAxias = YAxsiasItems[i];
                    });
                  });
                }),
          ))
        ],
      );

  Widget ActionInputItems(PersonalProvider PersonalCase) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: IconInsideCircle(
                      icon: FontAwesomeIcons.plus,
                      backGroundColor: ArgonColors.primary,
                      color: Colors.white,
                      iconSize: ArgonSize.IconSize,
                      size: ArgonSize.IconSize,
                      function: () async {
                        await RegisterSampeAmount(PersonalCase, true);
                      }),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Standard_Input(
                      prefixIcon: Icon(
                        Icons.countertops,
                        color: ArgonColors.Title,
                      ),
                      controller: SampleAmountController,
                      Ktype: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: IconInsideCircle(
                      icon: FontAwesomeIcons.minus,
                      backGroundColor: Colors.red,
                      color: Colors.white,
                      iconSize: ArgonSize.IconSize,
                      size: ArgonSize.IconSize,
                      function: () async {
                        await RegisterSampeAmount(PersonalCase, true);
                      }),
                )
              ],
            ),
          ),
          StandardButton(
              ForColor: ArgonColors.white,
              BakColor: ArgonColors.myGreen,
              FontSize: ArgonSize.Header3,
              Lable: PersonalCase.GetLable(ResourceKey.CloseSample),
              OnTap: () async {
                await PersonalCase.SelectedTracking.CloseTanifSample();
                Navigator.pop(context, "Okay");
              })
        ],
      );

  Widget inputWidget (PersonalProvider PersonalCase) =>    BoxMainContainer(Childrens: <Widget>[
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex:2,
              child: IconInsideCircle(
                  icon: FontAwesomeIcons.plus,
                  backGroundColor: ArgonColors.primary,
                  color: Colors.white,
                  iconSize: ArgonSize.IconSize,
                  size: ArgonSize.IconSize,
                  function: () async {
                    await RegisterSampeAmount(PersonalCase, true);
                  }),
            ),
            Expanded(

              child: Padding(
                child: SpinBox(
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
              flex:2,
              child: IconInsideCircle(
                  icon: FontAwesomeIcons.minus,
                  backGroundColor: Colors.red,
                  color: Colors.white,
                  iconSize: ArgonSize.IconSize,
                  size: ArgonSize.IconSize,
                  function: () async {
                    await RegisterSampeAmount(PersonalCase, true);
                  }),
            ),


          ],
        ),
        StandardButton(
            ForColor: ArgonColors.white,
            BakColor: ArgonColors.myGreen,
            FontSize: ArgonSize.Header3,
            Lable: PersonalCase.GetLable(ResourceKey.CloseSample),
            OnTap: () async {
              await PersonalCase.SelectedTracking.CloseTanifSample();
              Navigator.pop(context, "Okay");
            })
      ],
    ),

  ]);

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest.Test_Name,
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: FutureBuilder(
        future: LoadingOpenPage(PersonalCase),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(children: [
              HeaderPage(PersonalCase),
              MainInformationBox(PersonalCase),
              GroupLevel(PersonalCase),
              AxisItem(PersonalCase),
              //ActionInputItems(PersonalCase),
              inputWidget (PersonalCase)
            ]);
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
      ),
    );
  }
}
