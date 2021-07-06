import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

AlertDialog AlertPopupDialog(@required BuildContext context,
    @required String title, @required String Message,
    {String ActionLable}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: LableTitle(title, color: ArgonColors.warning),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[LableTitle(Message, FontSize: 10)],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(ActionLable),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

AlertDialog AlertPopupDialogWithAction(
  @required BuildContext context, {
  @required String title,
  @required List<Widget> Children,
  @required String FirstActionLable,
  Function OnFirstAction,
  @required String SecondActionLable,
  Function OnSecondAction,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: LableTitle(title, color: ArgonColors.warning),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Children,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(FirstActionLable),
                onPressed: () {
                  if (OnFirstAction != null) OnFirstAction();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(SecondActionLable),
                onPressed: () {
                  if (OnSecondAction != null) OnSecondAction();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
