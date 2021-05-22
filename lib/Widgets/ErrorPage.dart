import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class ErrorPage extends StatelessWidget {
  final String ActionName;
  final String MessageError;
  final String DetailError;

  ErrorPage({this.ActionName, this.MessageError, this.DetailError});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.all(ArgonSize.MainMargin),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: ArgonColors.secondary,
        shadowColor: ArgonColors.error,
        child: Padding(
            padding: EdgeInsets.all(ArgonSize.MainMargin),
            child: Column(
              children: <Widget>[
                HeaderTitle(ActionName,
                    color: ArgonColors.error, FontSize: ArgonSize.Header),
                Container(
                  margin: new EdgeInsets.symmetric(horizontal: 10.0),
                  padding: new EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    MessageError,
                    style: TextStyle(
                        color: ArgonColors.errorinfo,
                        fontSize: ArgonSize.Header1),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
