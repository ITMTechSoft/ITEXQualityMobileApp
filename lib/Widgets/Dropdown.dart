import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

Widget DropDowndList<T>(
    {T CurrentItem,
    Function OnChange,
    String Lable,
    List<DropdownMenuItem<T>> Items}) {
  return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      height: 40,
      color: ArgonColors.Group,

      child: DropdownButton<T>(
          hint: Text(Lable),
          isExpanded: true,
          value: CurrentItem,
          style:
          TextStyle(height: 0.85, fontSize: 16.0, color: ArgonColors.initial),
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 40,
          elevation: 40,
          onChanged: OnChange,
          items: Items));
}
