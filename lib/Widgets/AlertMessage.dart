import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

AlertDialog AlertPopupDialog(
    @required BuildContext context,
    @required String title,
    @required String Message,
    {String ActionLable ="Okay"}) {
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
      Color textButton1Color = Colors.black,
      Color textButton2Color = Colors.black,

    }) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        child: AlertDialog(
              title: LableTitle(title, color: ArgonColors.warning,FontSize: ArgonSize.Header3),
              content:  Container(
                width:getScreenWidth()*0.8,
                height:getScreenHeight()*0.1,
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Children,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(FirstActionLable,style:TextStyle(fontSize:ArgonSize.Header4,color:textButton1Color)),
                  onPressed: () async {
                    if (OnFirstAction != null) await OnFirstAction();
                  //  Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(SecondActionLable,style:TextStyle(fontSize:ArgonSize.Header4,color:textButton2Color)),
                  onPressed: () {
                    if (OnSecondAction != null) OnSecondAction();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      ));
}
