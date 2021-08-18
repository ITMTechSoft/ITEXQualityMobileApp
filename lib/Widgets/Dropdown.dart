import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

Widget DropDowndList<T>(

    {T? CurrentItem,
     required Function(T?) OnChange,
    String? Lable,
    List<DropdownMenuItem<T>>? Items}) {
  return DropdownButton<T>(
      hint: Text(Lable!),
      isExpanded: true,
      value: CurrentItem,
      style:
      TextStyle(height: 0.85, fontSize: ArgonSize.Header5, color: ArgonColors.initial),
      isDense: true,
      icon: Icon(Icons.keyboard_arrow_down,size:ArgonSize.IconSize),
      iconSize: 40,
      elevation: 40,
      items: Items,
      onChanged: OnChange);
}
