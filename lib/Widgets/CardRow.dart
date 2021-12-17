import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

import 'LableText.dart';

Widget CardRow(String lable1, String lable2, String value1, String value2,
    {int LabelFex = 3, int ValueFlex = 2}) {
  return Row(
    children: [
      Expanded(flex: LabelFex, child: LableTitle(lable1 + ' / ' + lable2)),
      Expanded(
          flex: ValueFlex,
          child: LableTitle(value1, color: ArgonColors.text, IsCenter: true)),
      Expanded(
          flex: ValueFlex,
          child: LableTitle(value2, color: ArgonColors.text, IsCenter: true)),
    ],
  );
}
