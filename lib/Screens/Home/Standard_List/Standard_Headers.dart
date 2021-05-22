import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

Widget ModelOrderMatrixHeader(PersonalCase) {
  return Card(
    shadowColor: ArgonColors.black,
    elevation: 1,
    child: Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: LableTitle(PersonalCase.GetLable(ResourceKey.SizeName),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ColorName),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.PlanningAmount),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.SizeColor_QTY),
                      IsCenter: true))
            ],
          ),
        ],
      ),
    ),
  );
}
Widget TasnifModelOrderMatrixHeader(PersonalCase) {
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
            children: [
              Expanded(
                  child: LableTitle(PersonalCase.GetLable(ResourceKey.SizeName),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ColorName),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.SizeColor_QTY),
                      IsCenter: true)),
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.OrderSizeColor_QTY),
                      IsCenter: true))
            ],
          ),
        ],
      ),
    ),
  );
}


