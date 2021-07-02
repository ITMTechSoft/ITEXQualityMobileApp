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
