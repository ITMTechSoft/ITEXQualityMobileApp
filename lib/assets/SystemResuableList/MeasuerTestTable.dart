import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderSizes.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import '../../SystemImports.dart';
class Tb_InlineDikimList2 extends StatefulWidget {
  List<QualityDept_ModelOrder_TrackingBLL>? Items;
  Function? OnClickItems;
  List<Widget>? Headers;

  Tb_InlineDikimList2({this.Headers, this.Items, this.OnClickItems});

  @override
  _Tb_InlineDikimListState2 createState() => _Tb_InlineDikimListState2();
}

class _Tb_InlineDikimListState2 extends State<Tb_InlineDikimList2> {
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
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
            children: widget.Headers!,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items!.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        if (widget.OnClickItems != null) widget.OnClickItems!(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable( widget.Items![i].SampleNo.toString(),
                            Flex: 1),
                        TableLable( '12:30',
                            Flex: 1),
                        TableLable( '12:30',
                            Flex: 1),
                        TableLable( 'Done',
                            Flex: 1),
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  })),
          SizedBox(height:20),
          ButtonWithNumber(text: PersonalCase.GetLable(ResourceKey.AddNewSample),textColor: Colors.white,buttonWidth: 300,buttonHegiht: 70)
        ]);
  }
}


class Tb_InlineDikimList1 extends StatefulWidget {
  List<ModelOrderSizesBLL>? Items;
  Function? OnClickItems;
  List<Widget>? Headers;

  Tb_InlineDikimList1({this.Headers, this.Items, this.OnClickItems});

  @override
  _Tb_InlineDikimListState1 createState() => _Tb_InlineDikimListState1();
}

class _Tb_InlineDikimListState1 extends State<Tb_InlineDikimList1> {
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
            children: widget.Headers!,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items!.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        if (widget.OnClickItems != null) widget.OnClickItems!(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable( widget.Items![i].SizeParam_StringVal.toString(),
                            Flex: 1),
                        TableLable(
                            widget.Items![i].Sample_Number.toString()  ,
                            Flex: 1),

                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}

////
class Tb_MeasuerCard extends StatefulWidget {
  List<User_QualityTracking_DetailBLL>? Items;
  Function? OnClickItems;
  PersonalProvider? PersonalCase;

  Tb_MeasuerCard(
      {@required this.PersonalCase,
        @required this.Items,
        @required this.OnClickItems});

  @override
  _MeasuerCardState createState() => _MeasuerCardState();
}
class _MeasuerCardState extends State<Tb_MeasuerCard> {
  int SelectedIndex = -1;

  Widget GetBoxInfo(int CheckStatus) {
    switch (CheckStatus) {
      case 0:
        return
          BoxColorWithText(
              widget.PersonalCase!.GetLable(ResourceKey.Pending),
    ArgonColors.Pending,
    Width: 100,
    Height: 50);
    // StatusWidget(icon:FontAwesomeIcons.clock,text:"pending",backGroundColor:ArgonColors.Pending ,iconColor:Colors.white);
    case 1:
    return BoxColorWithText(
    widget.PersonalCase!.GetLable(ResourceKey.Success),
    ArgonColors.Success,
    Width: 100,
    Height: 50,
    FontColor: ArgonColors.white);
    case 2:
    return BoxColorWithText(
    widget.PersonalCase!.GetLable(ResourceKey.UnderCheck),
    ArgonColors.UnderCheck,
    Width: 100,
    Height: 50);
    case 3:
    return BoxColorWithText(
    widget.PersonalCase!.GetLable(ResourceKey.Invalid),
    ArgonColors.Invalid,
    Width: 100,
    Height: 50,
    FontColor: ArgonColors.white);
    }
    return BoxColorWithText(
    widget.PersonalCase!.GetLable(ResourceKey.Pending), ArgonColors.Pending,
    Width: 100, Height: 50);
  }

  Widget RoundControl(
      PersonalProvider PersonalCase, User_QualityTracking_DetailBLL Item) {
    return Flexible(
        child: Card(
          shadowColor: ArgonColors.black,
          elevation: 10,
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
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
                                  PersonalCase.GetLable(ResourceKey.Measurement),
                                  FontSize  :20 ,

                                ),
                                flex: 2),

                          ],
                        ),
                        SizedBox(height:10),
                        LableTitle(
                          //  PersonalCase.GetLable(ResourceKey.Operator)
                            'Kol Measuerment',
                            FontSize  :17 ,
                            color:ArgonColors.primary

                        ),
                        SizedBox(height:10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: LableTitle(
                                  PersonalCase.GetLable(ResourceKey.MeasurementNumbers),


                                ),
                                flex: 2),
                            Expanded(
                                child: LableTitle(
                                    '10',
                                    color: ArgonColors.text, IsCenter: true),
                                flex: 1),
                            Expanded(
                                child: LableTitle(
                                  PersonalCase.GetLable(ResourceKey.Tolerans),

                                ),
                                flex: 2),
                            Expanded(
                                child: LableTitle(
                                    (Item.Error_Amount ?? 0).toString(),
                                    color: ArgonColors.text,
                                    IsCenter: true),
                                flex:1),
                            Expanded(
                                child: LableTitle(
                                  PersonalCase.GetLable(ResourceKey.Fark),

                                ),
                                flex: 1),
                            Expanded(
                                child: LableTitle(
                                    (Item.Error_Amount ?? 0).toString(),
                                    color: ArgonColors.text,
                                    IsCenter: true)),
                          ],
                        ),
                        SizedBox(height:10),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Expanded(
                        //         child: LableTitle(
                        //           PersonalCase.GetLable(ResourceKey.Start_Time),
                        //         ),
                        //         flex: 2),
                        //     Expanded(
                        //         child: LableDateTime(Item.StartDate,
                        //             Format: "HH:mm",
                        //             color: ArgonColors.text,
                        //             IsCenter: true)),
                        //     Expanded(
                        //       child: LableTitle(
                        //         PersonalCase.GetLable(ResourceKey.End_Time),
                        //       ),
                        //       flex: 2,
                        //     ),
                        //     Expanded(
                        //         child: LableDateTime(Item.EndDate,
                        //             Format: "HH:mm",
                        //             color: ArgonColors.text,
                        //             IsCenter: true)),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: GetBoxInfo(Item.CheckStatus),
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
                  itemCount: widget.Items!.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          SelectedIndex = i;
                        });
                        if (widget.OnClickItems != null) widget.OnClickItems!(i);
                      },
                      child: TableColumn(children: [
                        RoundControl(widget.PersonalCase!, widget.Items![i])
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}
