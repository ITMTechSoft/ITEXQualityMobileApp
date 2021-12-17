import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

import 'LableText.dart';


Widget HeaderPage(PersonalCase) => ListTile(
  title: HeaderTitle(PersonalCase.SelectedOrder.Order_Number,
      color: ArgonColors.header, FontSize: ArgonSize.Header2),
  subtitle: Text(PersonalCase.SelectedDepartment.Start_Date.toString(),
      style: TextStyle(fontSize: ArgonSize.Header6)),
  dense: true,
  selected: true,
);