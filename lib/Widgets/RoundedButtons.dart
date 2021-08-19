import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Utility/constants.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';




class ReusableRoundedButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final Color backgroundColor;
  final Widget child;
  final double elevation;

  const ReusableRoundedButton(
      {
        required this.onPressed,
        required this.height,
        this.elevation=6,
        this.backgroundColor = ArgonColors.primary,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation ?? 10,
      shape: kRoundedButtonShape,
      child: MaterialButton(
        height: height,
        // minWidth: 300,
        // elevation: 10,
        shape: kRoundedButtonShape,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}