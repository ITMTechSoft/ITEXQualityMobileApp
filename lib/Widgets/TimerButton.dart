import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

enum ButtonType { RaisedButton, FlatButton, OutlineButton }

const int aSec = 1;

const String secPostFix = 's';
const String labelSplitter = " |  ";

class TimerButton extends StatefulWidget {
  /// Create a TimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  ///label
  final String label;

  ///[timeOutInSeconds] after which the button is enabled
  final int timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base colors
  final Color color;

  /// The color to use for this button's text when the button is disabled.
  final Color disabledColor;

  /// activeTextStyle
  final TextStyle activeTextStyle;

  ///disabledTextStyle
  final TextStyle disabledTextStyle;

  ///buttonType
  final ButtonType buttonType;

  ///If resetTimerOnPressed is true reset the timer when the button is pressed : default to true
  final bool resetTimerOnPressed;

  const TimerButton({
    required this.label,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.color = Colors.blue,
    this.resetTimerOnPressed = true,
    this.disabledColor = ArgonColors.myGrey,
    this.buttonType = ButtonType.RaisedButton,
    this.activeTextStyle = const TextStyle(color: Colors.white),
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  });

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool timeUpFlag = false;
  int timeCounter = 0;

  String get _timerText => '$timeCounter$secPostFix';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0)
        _timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  Widget _buildChild() {
    return Container(
      child: timeUpFlag
          ? Text(
        widget.label,
        style: (widget.buttonType == ButtonType.OutlineButton)
            ? widget.activeTextStyle.copyWith(color: widget.color)
            : widget.activeTextStyle,
      )
          : Text(
        widget.label + labelSplitter + _timerText,
        style: widget.disabledTextStyle,
      ),
    );
  }

  _onPressed() {
    if (timeUpFlag) {
      setState(() {
        timeUpFlag = false;
      });
      timeCounter = widget.timeOutInSeconds;

      if (widget.onPressed != null) {
        widget.onPressed();
      }
      // reset the timer when the button is pressed
      if (widget.resetTimerOnPressed) {
        _timerUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.RaisedButton:
      //TODO: (Ajay) Remove deprecated members
      // ignore: deprecated_member_use
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: widget.disabledColor,
            backgroundColor: widget.color,
          ),
          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
      case ButtonType.FlatButton:
      // ignore: deprecated_member_use
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: widget.color,
            disabledBackgroundColor: widget.disabledColor,
          ),

          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
      case ButtonType.OutlineButton:
      // ignore: deprecated_member_use
        return OutlinedButton(

          style: TextButton.styleFrom(
            backgroundColor: widget.color,
            disabledBackgroundColor: widget.disabledColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
    }

    return Container();
  }
}