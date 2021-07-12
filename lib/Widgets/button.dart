import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final Function onPressed;
  final String NormalText;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color buttonBorderColor;
  final Color TextColor;
  final List<Widget> children;

  StretchableButton({
    @required this.buttonColor,
    this.NormalText,
    this.children,
    this.borderRadius = 5,
    this.splashColor,
    this.buttonBorderColor,
    this.onPressed,
    this.TextColor,
    this.buttonPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        /* if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          contents.add(Spacer());
        }*/

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: MaterialButton(
            onPressed: onPressed,
            color: buttonColor,
            splashColor: splashColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

Widget StandardButton({String Lable, Color ForColor,Color BakColor, Function OnTap,double FontSize = 14 }) =>
    TextButton(
        child: Text(Lable.toUpperCase(), style: TextStyle(fontSize: FontSize)),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
            foregroundColor: MaterialStateProperty.all<Color>(ForColor),
            backgroundColor:MaterialStateProperty.all<Color>(BakColor) ,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: ForColor)))),
        onPressed: OnTap);


Widget CircleButton({Color ForColor,Color BakColor,IconData ActionIcon,Function OnTap}){
  return ClipOval(
    child: Material(
      color: BakColor, // button color
      child: InkWell(
        splashColor: ForColor, // inkwell color
        child: SizedBox(width: 56, height: 100, child: Icon(ActionIcon,color: ForColor,size: 50,)),
        onTap: OnTap,
      ),
    ),
  );
}



class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.value,
    this.function,
    this.backGroundColor,
    this.width,
    this.height,
    this.textColor,
    this.textSize = 20,
  }) : super(key: key);

  final String value;

  final Function function;

  final Color backGroundColor;
  final Color textColor;
  final double width;

  final double height;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backGroundColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: function,
        child: CustomText(
          text: value,
          size: textSize,
          color: textColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}