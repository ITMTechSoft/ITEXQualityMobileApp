import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/Employee_Department.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDepartment_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/ImageLoader.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'package:intl/intl.dart';

Widget DepartmentCard(Employee_DepartmentBLL Item, Function() OnTap) {
  return Container(
    height: ArgonSize.WidthBig,
    width: ArgonSize.HeightBig,
    padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
    child: Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Center(
        child: ListTile(
          onTap: OnTap,
          title: Text(
            Item.Depart_Name ?? '',
            style:
                TextStyle(fontSize: ArgonSize.Header3, color: ArgonColors.text),
          ),
          subtitle: Text(
            Item.Depart_Name ?? '',
            style: TextStyle(fontSize: ArgonSize.Header4),
          ),
        ),
      ),
    ),
  );
}

Widget OneItem(
    {required String ItemName,
    required String ItemValue,
    required Function() OnTap}) {
  return Container(
    height: ArgonSize.HeightBig,
    width: ArgonSize.WidthBig,
    child: Card(
        shadowColor: ArgonColors.black,
        elevation: 10,
        child: Center(
          child: ListTile(
            onTap: OnTap,
            title: Text(
              ItemName,
              style: TextStyle(
                  fontSize: ArgonSize.Header3,
                  color: ArgonColors.black.withOpacity(0.6)),
            ),
            subtitle: Text(
              ItemValue,
              style: TextStyle(
                  fontSize: ArgonSize.Header5,
                  color: ArgonColors.black.withOpacity(0.5)),
            ),
          ),
        )),
  );
}

class OrderCard extends StatelessWidget {
  Future<String?> GetModelImage() async {
    return await Item.GetModelOrderImage();
  }

  final QualityDepartment_ModelOrderBLL Item;
  final Function() OnTap;

  const OrderCard({Key? key, required this.Item, required this.OnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ArgonSize.HeightBig,
      width: ArgonSize.WidthBig,
      padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
      child: Card(
        elevation: 3,
        child: Center(
          child: ListTile(
            onTap: OnTap,
            title: Padding(
              padding: EdgeInsets.only(bottom: ArgonSize.Padding3),
              child: CustomText(
                  text: Item.Order_Number ?? "",
                  size: ArgonSize.Header5,
                  textAlign: TextAlign.left,
                  color: ArgonColors.black.withOpacity(0.6)),
            ),
            subtitle: CustomText(
                text: Item.Model_Name ?? "",
                size: ArgonSize.Header6,
                textAlign: TextAlign.left,
                color: ArgonColors.black.withOpacity(0.5)),
            leading: SizedBox(
                width: ArgonSize.WidthSmall,
                height: ArgonSize.WidthMedium,
                child: ImageLoader(LoadingImage: GetModelImage())),
            trailing: Text(''),
          ),
        ),
      ),
    );
  }
}

Widget CuttingPastalControl(
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
                    color: ArgonColors.success, size: ArgonSize.IconSizeMedium),
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
                    color: ArgonColors.warning, size: ArgonSize.IconSizeMedium),
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

Widget TansifControlList(PersonalProvider PersonalCase,
    QualityDept_ModelOrder_TrackingBLL Item, Function() OnTap) {
  Widget FinishStatus = ClipOval(
    child: Icon(
      Icons.check_circle_rounded,
      color: ArgonColors.success,
    ),
  );

  Widget PendingStatus = ClipOval(
    child: Icon(
      Icons.panorama_fish_eye_rounded,
      color: ArgonColors.warning,
    ),
  );

  Widget MainRow = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 3,
              child: LableTitle(
                '${PersonalCase.GetLable(ResourceKey.ColorName)} / '
                '${PersonalCase.GetLable(ResourceKey.SizeName)}',
              )),
          Expanded(
              flex: 2,
              child: LableTitle(Item.ColorName.toString(),
                  color: ArgonColors.text, IsCenter: true)),
          Expanded(
              flex: 2,
              child: LableTitle(Item.SizeName ?? '',
                  color: ArgonColors.text, IsCenter: true)),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 3,
              child: LableTitle(
                  '${PersonalCase.GetLable(ResourceKey.OrderSizeColor_QTY)} / '
                  '${PersonalCase.GetLable(ResourceKey.SizeColor_QTY)}')),
          Expanded(
              flex: 2,
              child: LableTitle((Item.OrderSizeColor_QTY ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
          Expanded(
              flex: 2,
              child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 3,
              child: LableTitle(
                  '${PersonalCase.GetLable(ResourceKey.OrderSizeColor_QTY)} / '
                  '${PersonalCase.GetLable(ResourceKey.Sample_Amount)}')),
          Expanded(
              flex: 2,
              child: LableTitle((Item.OrderSizeColor_QTY ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
          Expanded(
              flex: 2,
              child: LableTitle((Item.Sample_Amount ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
        ],
      ),
      SizedBox(height: 8),
      Row(children: [
        Expanded(
            flex: 3,
            child: LableTitle(
                '${PersonalCase.GetLable(ResourceKey.Error_Amount)} / '
                '${PersonalCase.GetLable(ResourceKey.Sample_Status)}')),
        Expanded(
            flex: 2,
            child: LableTitle((Item.Error_Amount ?? 0).toString(),
                color: ArgonColors.text, IsCenter: true)),
        Expanded(
            flex: 2,
            child: Item.Status == ControlStatus.TansifControlCloseStatus
                ? FinishStatus
                : PendingStatus),
      ])
    ],
  );

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 10,
    child: Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: OnTap,
        child: MainRow,
      ),
    ),
  );
}

/// TASNIF CORRECTION LIST

Widget CuttingModelOrderMatrix(
    PersonalCase, OrderSizeColorDetailsBLL Item, Function() OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedMatrix != null &&
      PersonalCase.SelectedMatrix.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 20,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Center(
                  child: LableTitle(Item.SizeParam_StringVal ?? '',
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle(Item.ColorParam_StringVal ?? '',
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.PlanSizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget TasnifModelOrderMatrix(
    PersonalCase, OrderSizeColorDetailsBLL Item, Function() OnTap) {
  Color SelectedColor = ArgonColors.white;
  if (PersonalCase.SelectedMatrix != null &&
      PersonalCase.SelectedMatrix.Id == Item.Id)
    SelectedColor = ArgonColors.muted;

  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      onTap: OnTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Center(
                  child: LableTitle(Item.SizeParam_StringVal ?? '',
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle(Item.ColorParam_StringVal ?? '',
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.SizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                )),
                Expanded(
                    child: Center(
                  child: LableTitle((Item.OrderSizeColor_QTY ?? 0).toString(),
                      color: ArgonColors.text),
                ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget QualityAxisItem(DeptModOrderQuality_ItemsBLL Item,
    {IsSeleted = false, required Function() OnTap}) {
  Color SelectedColor;
  Color SelectedTextColor;

  if (IsSeleted) {
    SelectedColor = ArgonColors.primary;
    SelectedTextColor = ArgonColors.white;
  } else {
    SelectedColor = ArgonColors.white;
    SelectedTextColor = ArgonColors.Title;
  }
  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    color: SelectedColor,
    child: InkWell(
      focusColor: Colors.lightGreenAccent,
      highlightColor: Colors.deepOrange,
      onTap: OnTap,
      child: Container(
        color: SelectedColor,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: LableTitle(Item.Item_Name ?? '', color: SelectedTextColor),
      ),
    ),
  );
}

///// Table Headers

Color NormalColor = ArgonColors.white;
Color SelectedColor = ArgonColors.muted;

Widget HeaderColumn({List<Widget> children = const <Widget>[]}) {
  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    child: Container(
      padding: EdgeInsets.all(5),
      color: ArgonColors.bgColorScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        ],
      ),
    ),
  );
}

Widget TableColumn(
    {List<Widget> children = const <Widget>[], bool IsSelectedItem = false}) {
  return Card(
      shadowColor: ArgonColors.black,
      elevation: 1,
      color: IsSelectedItem ? SelectedColor : NormalColor,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: children,
            ),
          ],
        ),
      ));
}

Widget RowColumn(
    {List<Widget> children = const <Widget>[], bool IsSelectedItem = false}) {
  return Card(
      shadowColor: ArgonColors.black,
      elevation: 1,
      color:
          IsSelectedItem ? ArgonColors.SelectedColor : ArgonColors.NormalColor,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ));
}

//// New Design for Header and Table Information
class TableBodyGList<T> extends StatefulWidget {
  List<T> Items;
  Function(int) OnClickItems;
  List<Widget> Headers;

  TableBodyGList(
      {required this.Headers,
      required this.Items,
      required this.OnClickItems(int)});

  @override
  _TableBodyGListState createState() => _TableBodyGListState();
}

class _TableBodyGListState extends State<TableBodyGList> {
  int SelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
            children: widget.Headers,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        if (widget.OnClickItems != null) widget.OnClickItems(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable(widget.Items[i].Group_Name),
                        TableLable(widget.Items[i].Accessory, Flex: 2),
                        TableLable((widget.Items[i].Quantity ?? 0).toString()),
                        TableLable(
                            (widget.Items[i].Checks_Quantity ?? 0).toString()),
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}
///// Dikim Inline

class Tb_InlineDikimList extends StatefulWidget {
  List<QualityDept_ModelOrder_TrackingBLL> Items;
  Function OnClickItems;
  List<Widget> Headers;

  Tb_InlineDikimList(
      {required this.Headers, required this.Items, required this.OnClickItems});

  @override
  _Tb_InlineDikimListState createState() => _Tb_InlineDikimListState();
}

class _Tb_InlineDikimListState extends State<Tb_InlineDikimList> {
  int SelectedIndex = -1;

  Widget GetStatusIcon(int Status) {
    if (Status == 1)
      return Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.check_circle_rounded,
              color: ArgonColors.success,
            ),
          )
        ],
      );
    else
      return Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.brightness_1_outlined,
              color: ArgonColors.warning,
            ),
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
            children: widget.Headers,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        if (widget.OnClickItems != null) widget.OnClickItems(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable("Tur " + widget.Items[i].SampleNo.toString(),
                            Flex: 1),
                        TableLable(
                            DateFormat('HH:mm')
                                .format(widget.Items[i].StartDate!),
                            Flex: 3),
                        TableLable(
                            widget.Items[i].EndDate != null
                                ? DateFormat('HH:mm')
                                    .format(widget.Items[i].EndDate!)
                                : "",
                            Flex: 3),
                        Expanded(child: GetStatusIcon(widget.Items[i].Status!)),
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}

Widget BoxColorWithText(String Lable, Color SelectedColor,
    {double Width = 50,
    double Height = 50,
    FontColor = ArgonColors.text,

    /// TODO edit this
    FontSize = ArgonSize.normal}) {
  return Container(
    width: Width,
    height: Height,
    decoration: BoxDecoration(
      color: SelectedColor,
      border: Border.all(
        color: Color.fromARGB(2, 116, 193, 232),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        new BoxShadow(
          color: Color.fromARGB(2, 3, 59, 87),
          offset: new Offset(3.0, 3.0),
        ),
      ],
    ),
    child: Center(
        child: Text(Lable,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FontSize,
                color: FontColor))),
  );
}

Widget StatusWidget(
    {required IconData icon,
    required String text,
    required Color backGroundColor,
    required Color iconColor}) {
  return Row(children: [
    IconInsideCircle(
        icon: icon,
        backGroundColor: backGroundColor,
        color: iconColor,
        iconSize: 30,
        size: 10),
    SizedBox(width: 10),
    CustomText(
      text: text,
      size: 20,
      fontWeight: FontWeight.normal,
    )
  ]);
}

/// Dikim Inline Round List
class Tb_InlineRoundList extends StatefulWidget {
  List<User_QualityTracking_DetailBLL> Items;
  Function OnClickItems;
  PersonalProvider PersonalCase;

  Tb_InlineRoundList(
      {required this.PersonalCase,
      required this.Items,
      required this.OnClickItems});

  @override
  _Tb_InlineRoundListState createState() => _Tb_InlineRoundListState();
}

class _Tb_InlineRoundListState extends State<Tb_InlineRoundList> {
  int SelectedIndex = -1;

  Widget GetBoxInfo(int CheckStatus) {
    switch (CheckStatus) {
      case 0:
        return BoxColorWithText(
            widget.PersonalCase.GetLable(ResourceKey.Pending),
            ArgonColors.Pending,
            Width: ArgonSize.ImageHeight,
            Height: 50,
            FontSize: ArgonSize.Header4);
      case 1:
        return BoxColorWithText(
            widget.PersonalCase.GetLable(ResourceKey.Success),
            ArgonColors.Success,
            Width: ArgonSize.ImageHeight,
            Height: 50,
            FontSize: ArgonSize.Header4,
            FontColor: ArgonColors.white);
      case 2:
        return BoxColorWithText(
          widget.PersonalCase.GetLable(ResourceKey.UnderCheck),
          ArgonColors.UnderCheck,
          Width: ArgonSize.ImageHeight,
          Height: 50,
          FontSize: ArgonSize.Header4,
        );
      case 3:
        return BoxColorWithText(
            widget.PersonalCase.GetLable(ResourceKey.Invalid),
            ArgonColors.Invalid,
            Width: ArgonSize.ImageHeight,
            Height: 50,
            FontSize: ArgonSize.Header4,
            FontColor: ArgonColors.white);
    }
    return BoxColorWithText(
      widget.PersonalCase.GetLable(ResourceKey.Pending),
      ArgonColors.Pending,
      Width: ArgonSize.ImageHeight,
      Height: 50,
      FontSize: ArgonSize.Header4,
    );
  }

  Widget RoundControl(
      PersonalProvider PersonalCase, User_QualityTracking_DetailBLL Item) {
    return Flexible(
        child: Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        margin: EdgeInsets.all(5),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
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
                                PersonalCase.GetLable(ResourceKey.Operator)),
                            flex: 2),
                        Expanded(
                            child: LableTitle(
                                (Item.Inline_Employee_Name ?? 0).toString(),
                                color: ArgonColors.text,
                                IsCenter: true),
                            flex: 2),
                        Expanded(
                            child: LableTitle(
                              PersonalCase.GetLable(ResourceKey.Sample_Amount),
                            ),
                            flex: 2),
                        Expanded(
                            child: LableTitle((Item.Amount ?? 0).toString(),
                                color: ArgonColors.text, IsCenter: true)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: LableTitle(
                              PersonalCase.GetLable(ResourceKey.Operation),
                            ),
                            flex: 2),
                        Expanded(
                            child: LableTitle(Item.Operation_Name ?? '',
                                color: ArgonColors.text, IsCenter: true),
                            flex: 2),
                        Expanded(
                            child: LableTitle(
                              PersonalCase.GetLable(ResourceKey.Error_Amount),
                            ),
                            flex: 2),
                        Expanded(
                            child: LableTitle(
                                (Item.Error_Amount ?? 0).toString(),
                                color: ArgonColors.text,
                                IsCenter: true)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: LableTitle(
                              PersonalCase.GetLable(ResourceKey.Start_Time),
                            ),
                            flex: 2),
                        Expanded(
                            child: LableDateTime(Item.StartDate!,
                                Format: "HH:mm",
                                color: ArgonColors.text,
                                IsCenter: true)),
                        Expanded(
                          child: LableTitle(
                            PersonalCase.GetLable(ResourceKey.End_Time),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                            child: LableDateTime(Item.EndDate!,
                                Format: "HH:mm",
                                color: ArgonColors.text,
                                IsCenter: true)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: GetBoxInfo(Item.CheckStatus!),
                          padding: EdgeInsets.all(5),
                        )
                      ],
                    )
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          SelectedIndex = i;
                        });
                        if (widget.OnClickItems != null) widget.OnClickItems(i);
                      },
                      child: TableColumn(children: [
                        RoundControl(widget.PersonalCase, widget.Items[i])
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}

/// Employee List Filter
Widget DropDownBox(
    {required String ItemName,
    bool IsCritical = false,
    required Function() OnTap,
    bool IsSelected = false}) {
  return Card(
      color: IsCritical ? ArgonColors.myRed : ArgonColors.white,
      shadowColor: ArgonColors.black,
      elevation: 1,
      //   margin: EdgeInsets.all(1),
      child: InkWell(
          onTap: OnTap,
          child: Container(
            height: ArgonSize.WidthSmall,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
            color: IsSelected ? ArgonColors.muted : ArgonColors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ItemName,
                style: TextStyle(
                    fontSize: ArgonSize.Header4, color: ArgonColors.text),
              ),
            ),
          )));
}
