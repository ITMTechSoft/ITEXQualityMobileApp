import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

const double _kActiveFontSize = 14.0;
const double _LableFontSize = 12.0;
const double _kBottomMargin = 10.0;
const double _HeaderFontSize = 20.0;

Text HeaderTitle(String Title, {Color color, double FontSize}) {
  return Text(
    Title,
    style: TextStyle(
      fontSize: FontSize == null ? _HeaderFontSize : FontSize,
      fontWeight: FontWeight.bold,
      color: color == null ? Colors.indigo : color,
    ),
  );
}

Widget LableTitle(String Title,
    {Color color, double FontSize, bool IsCenter = false}) {
  if (IsCenter)

    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Center(
        child: Text(
          Title!=null ?Title.toUpperCase():"",
          style: TextStyle(
            fontSize: FontSize == null ? _LableFontSize : FontSize,
            fontWeight: FontWeight.bold,
            color: color == null ? ArgonColors.Title : color,
          ),
        ),
      ),
    );
  else
    return Text(

      (Title??"").toUpperCase(),
      style: TextStyle(
        fontSize: FontSize == null ? _LableFontSize : FontSize,
        fontWeight: FontWeight.bold,
        color: color == null ? ArgonColors.Title : color,
      ),
    );
}

Widget LableDateTime(DateTime TargetDate,
    {String Format="yyyy/MM/dd HH:mm", Color color, double FontSize, bool IsCenter = false}) {
  if (IsCenter)

    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Center(
        child: Text(
          TargetDate != null? DateFormat(Format).format(TargetDate): "",
          style: TextStyle(
            fontSize: FontSize == null ? _LableFontSize : FontSize,
            fontWeight: FontWeight.bold,
            color: color == null ? ArgonColors.Title : color,
          ),
        ),
      ),
    );
  else
    return Text(
      TargetDate != null? DateFormat(Format).format(TargetDate): "",
      style: TextStyle(
        fontSize: FontSize == null ? _LableFontSize : FontSize,
        fontWeight: FontWeight.bold,
        color: color == null ? ArgonColors.Title : color,
      ),
    );
}


Widget ExpandedLableTitle(String Title,
    {Color color, double FontSize, bool IsCenter = false}) {
  if (IsCenter)
    return Expanded(child: Text(
      (Title??"").toUpperCase(),
      style: TextStyle(
        fontSize: FontSize == null ? _LableFontSize : FontSize,
        fontWeight: FontWeight.bold,
        color: color == null ? ArgonColors.Title : color,
      ),
    ),);
}

Widget FilterItem(
        context, controller, Function onSearchTextChanged, PersonalCase) =>
    new Container(
      color: ArgonColors.inputSuccess,
      child: new Padding(
        padding: const EdgeInsets.all(1.0),
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search),
            title: new TextField(
              controller: controller,
              decoration: new InputDecoration(
                  hintText: PersonalCase.GetLable(ResourceKey.Search),
                  border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
