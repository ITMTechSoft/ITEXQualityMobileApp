import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/FinalControl/FinalControl.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

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

Widget StandardButton({String Lable,
  Color ForColor,
  Color BakColor,
  Function OnTap,
  double FontSize = 14}) =>
    TextButton(
        child: Text(Lable.toUpperCase(), style: TextStyle(fontSize: FontSize)),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
            foregroundColor: MaterialStateProperty.all<Color>(ForColor),
            backgroundColor: MaterialStateProperty.all<Color>(BakColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: ForColor)))),
        onPressed: OnTap);

Widget CircleButton(
    {Color ForColor, Color BakColor, IconData ActionIcon, Function OnTap}) {
  return ClipOval(
    child: Material(
      color: BakColor, // button color
      child: InkWell(
        splashColor: ForColor, // inkwell color
        child: SizedBox(
            width: 56,
            height: 100,
            child: Icon(
              ActionIcon,
              color: ForColor,
              size: 50,
            )),
        onTap: OnTap,
      ),
    ),
  );
}


Widget ButtonWithNumber({String text,
  int number,
  double buttonWidth,
  double buttonHegiht,
  Color btnBgColor,
  Color circleBgColor,
  double textSize = 20,
  int bubbleDirection,
  bool anotherBubble,
  int index,
  int currentIndex,
}) {
  return Stack(
    children: [
      Container(
        width: buttonWidth,
        height: buttonHegiht,
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: CustomContainer(
              width: buttonWidth,
              height: buttonHegiht,
              value: text,
              textColor: Colors.black54,
              backGroundColor: btnBgColor,
              textSize: textSize,
              function: () {
                //  print('button is clicked ');
              }),
        ),
      ),
      Positioned(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? circleBgColor : Colors.red,
          ),
          child: Text(
            number.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        top: 0,
        right: 0,
      ),
      anotherBubble == true
          ? Positioned(
        child:IconInsideCircle(icon: FontAwesomeIcons.minus,color: Colors.white,backGroundColor: Colors.red),
        bottom: 0,
        left: 0,
      )
          : Container(),
    ],
  );
}

Widget IconInsideCircle
    ({
  IconData icon ,
  Color color ,
  double iconSize =15,
  Color backGroundColor

}) {
  return Container(
    padding: EdgeInsets.all(11),
    margin: EdgeInsets.only(left: 2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backGroundColor,
    ),
    child: Icon(
      icon,
      size: iconSize,
      color: color,

    ),);

}

Widget CircleShape({String text,
  Color color = ArgonColors.myBlue2,
  double width = 80,
  double height = 70,
  double fontSize = 18}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backGroundColor, // background
        ),
        child: Center(
          child: CustomText(
            text: value,
            size: textSize,
            color: textColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  final TextDecoration textDecoration;
  final TextAlign textAlign;

  const CustomText({Key key,
    this.text,
    this.size,
    this.color = ArgonColors.Title,
    this.fontWeight = FontWeight.bold,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}