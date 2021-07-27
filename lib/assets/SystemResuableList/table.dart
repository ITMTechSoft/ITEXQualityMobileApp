import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/FinalControl/SewingEmployeeControl.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class table extends StatefulWidget {
  List<test> Items;
  Function OnClickItems;
  PersonalProvider PersonalCase;

  table(
      {@required this.PersonalCase,
        @required this.Items,
        @required this.OnClickItems});

  @override
  _OrderSizeColorMatrixState createState() => _OrderSizeColorMatrixState();
}

class _OrderSizeColorMatrixState extends State<table> {
  int SelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
              children: <Widget>[
                HeaderLable(widget.PersonalCase.GetLable(ResourceKey.Operation)),
                HeaderLable(widget.PersonalCase.GetLable(ResourceKey.Operator)),
                HeaderLable(widget.PersonalCase.GetLable(ResourceKey.CreateDate)),
                HeaderLable(''),

              ]
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
                     TableLable(widget.Items[i].operation),
                     TableLable(widget.Items[i].operator),
                        TableLable(widget.Items[i].date),

                     ButtonWithNumber(
                       text: PersonalCase.GetLable(ResourceKey.Delete),
                       textColor: Colors.white,
                       buttonWidth: 60,
                       buttonHegiht: 40,
                       btnBgColor: ArgonColors.myRed,
                       textSize: 12,


                     )
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}

