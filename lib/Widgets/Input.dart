import 'package:flutter/material.dart';

import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Standard_Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final Function onValidator;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final TextInputType Ktype;
  final int MinLines;
  final int MaxLines;

  Standard_Input({
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.borderColor = ArgonColors.border,
    this.controller,
    this.onValidator,
    this.Ktype = TextInputType.text,
    this.MinLines= 1,
    this.MaxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 60,
      child: TextField(
          cursorColor: ArgonColors.muted,
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          keyboardType: Ktype,
          autofocus: autofocus,
          minLines: this.MinLines,
          maxLines: this.MaxLines,
          style:
          TextStyle(height: 0.85, fontSize: 16.0, color: ArgonColors.initial),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
              filled: true,
              fillColor: ArgonColors.white,
              hintStyle: TextStyle(
                color: ArgonColors.muted,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: borderColor, width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: borderColor, width: 1.0, style: BorderStyle.solid)),
              hintText: placeholder)),
    );
  }
}

class Input_Form extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final Function onValidator;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final String labelText;
  final String labelHint;
  final Function validator;
  final TextInputType KType;
  final double InputHeight;
  Input_Form(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.controller,
      this.onValidator,
      this.labelText,
      this.labelHint,
      this.validator,
      this.KType = TextInputType.text,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.InputHeight = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:this.InputHeight ,
      child: TextFormField(
        controller: controller,
        autofocus: this.autofocus,
        onTap: this.onTap,
        onChanged: this.onChanged,

        keyboardType: KType,
        decoration: InputDecoration(
          prefixIcon: this.prefixIcon,
          suffixIcon: this.suffixIcon,
          labelText: this.labelText,
          labelStyle:
          TextStyle(height: 1.5, fontWeight: FontWeight.w800, fontSize: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.lightGreen)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue)),
          hintText: labelHint,
          hintStyle: TextStyle(height: 1.5, fontWeight: FontWeight.w300),
        ),
        validator: this.validator),);
  }
}
