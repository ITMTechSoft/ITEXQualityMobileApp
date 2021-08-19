import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

AlertPopupDialog(BuildContext context, String title, String Message,
    {String ActionLable = "Okay"}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: LableTitle(title, color: ArgonColors.warning),
            content: Container(
              width: getScreenWidth() * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[LableTitle(Message, FontSize: 10)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(ActionLable,
                    style: TextStyle(fontSize: ArgonSize.Header5)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

AlertDialog AlertPopupDialogWithAction(
  {required BuildContext context,
  required String title,
  required List<Widget> Children,
  required String FirstActionLable,
  required Function OnFirstAction,
  required String SecondActionLable,
    Function? OnSecondAction,
  Color textButton1Color = ArgonColors.primary,
  Color textButton2Color = ArgonColors.primary,
  Color messageColor = ArgonColors.warning,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Container(
            child: AlertDialog(
              title: LableTitle(title,
                  color: messageColor, FontSize: ArgonSize.Header3),
              content: Container(
                width: getScreenWidth() * 0.8,
                height: getScreenHeight() * 0.1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Children,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(FirstActionLable,
                      style: TextStyle(
                          fontSize: ArgonSize.Header4,
                          color: textButton1Color)),
                  onPressed: () async {
                    if (OnFirstAction != null) await OnFirstAction();
                    //  Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(SecondActionLable,
                      style: TextStyle(
                          fontSize: ArgonSize.Header4,
                          color: textButton2Color)),
                  onPressed: () {
                    if (OnSecondAction != null) OnSecondAction();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
}
