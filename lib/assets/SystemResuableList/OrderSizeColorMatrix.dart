import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class OrderSizeColorMatrix extends StatefulWidget {
  List<OrderSizeColorDetailsBLL>? Items;
  Function? OnClickItems;
  PersonalProvider? PersonalCase;

  OrderSizeColorMatrix(
      {@required this.PersonalCase,
      @required this.Items,
      @required this.OnClickItems});

  @override
  _OrderSizeColorMatrixState createState() => _OrderSizeColorMatrixState();
}

class _OrderSizeColorMatrixState extends State<OrderSizeColorMatrix> {
  int SelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
            children: <Widget>[
              HeaderLable(widget.PersonalCase!.GetLable(ResourceKey.SizeName),Flex: 1),
              HeaderLable(widget.PersonalCase!.GetLable(ResourceKey.ColorName),Flex: 1),
              HeaderLable(widget.PersonalCase!.GetLable(ResourceKey.SizeColor_QTY),Flex: 1),
              HeaderLable(widget.PersonalCase!.GetLable(ResourceKey.ControlAmount),Flex: 1),
              HeaderLable(widget.PersonalCase!.GetLable(ResourceKey.Remain_Value),Flex: 1),
            ]
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
                        TableLable(widget.Items![i].SizeParam_StringVal??'',Flex: 1),
                        TableLable(widget.Items![i].ColorParam_StringVal??'',Flex: 1),
                        LableInteger(widget.Items![i].SizeColor_QTY,Flex: 1),
                        LableInteger(widget.Items![i].ControlAmount,Flex: 1),
                        LableInteger(widget.Items![i].Remain_Value,Flex: 1),
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}
