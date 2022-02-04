import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import 'LableText.dart';

class RadioSwitch extends StatefulWidget {
  String? Lable;
  Color? LableColor;
  Function? OnTap;
  bool? SwitchValue;
  double? fontSize;

  RadioSwitch(
      {this.Lable,
      this.LableColor = ArgonColors.myBlue,
      this.OnTap,
      this.SwitchValue = false,
      this.fontSize = 15});

  @override
  _RadioSwitchState createState() => _RadioSwitchState();
}

class _RadioSwitchState extends State<RadioSwitch> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomText(
        text:  widget.Lable!,
        color: widget.LableColor!,
        size:widget. fontSize!,
      ),
      // SizedBox(height:10),
      Transform.scale(
          scale: ArgonSize.RadioSwitchValue,
          child: InkWell(
            child: CupertinoSwitch(
              trackColor: Colors.black12, // **INACTIVE STATE COLOR**
              activeColor: Colors.green, // **ACTIVE STATE COLOR**
              value: widget.SwitchValue!,
              onChanged: (bool value) {
                setState(() {
                  widget.SwitchValue = value;
                  widget.OnTap!(widget.SwitchValue);
                });
              },
            ),

          )),
    ]);
  }
}
