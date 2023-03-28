import 'package:flutter/material.dart';

Widget FilterSwitch(String lable, bool FilterValue, Function Action) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(lable),
      Switch(
          value: FilterValue,
          onChanged: (value) {
            Action(value);
          })
    ],
  );
}