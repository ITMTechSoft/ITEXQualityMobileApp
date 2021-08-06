import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

Widget StandardButton(
    {String Lable,
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

Widget ButtonWithNumber({
  String text,
  double buttonWidth =500,
  double buttonHegiht=40,
  Color btnBgColor = ArgonColors.myLightBlue,
  double textSize = 20,
  Color textColor = Colors.black54,
  double padding = 5,
  Widget topRight,
  Widget topLeft,
  Widget bottomRight,
  Widget bottomLeft,
  Widget image,
  bool orientation = false,

}) {
  return Container (
      width:  buttonWidth,
      height: buttonHegiht,
      child:Stack(
          children:[
            CustomContainer(
              width: buttonWidth,
              height: buttonHegiht,
              value: text,
              textColor: textColor,
              backGroundColor: btnBgColor,
              textSize: textSize,
              image: image,
              topRight:topRight,
              topLeft:topLeft,
              bottomRight:bottomRight,
              bottomLeft:bottomLeft,
              padding1:padding
            ),

          ]
      )
  );
}

Widget IconInsideCircle(
    {IconData icon,
      Color color,
      double iconSize = 15,
      Color backGroundColor,
      double size = 13,
    Function function}) {
  return GestureDetector(
    onTap :function,
    child: Container(
      padding: EdgeInsets.all(size),
      margin: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backGroundColor,

    ),
      child: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
    ),
  );
}

Widget CircleShape(
    {String text,
      Color color = ArgonColors.myBlue2,
      double width = 80,
      double height = 70,
      double fontSize = 18,
      Color textColor = Colors.white}) {
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
            color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold),
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
    this.image, this.topRight, this.topLeft, this.bottomRight, this.bottomLeft, this.padding1=10,
  }) : super(key: key);

  final String value;

  final Function function;

  final Color backGroundColor;
  final Color textColor;
  final double width;

  final double height;
  final double textSize;
  final image;
  final Widget topRight;
  final Widget topLeft;
  final Widget bottomRight;
  final Widget bottomLeft;
  final double padding1 ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            padding:EdgeInsets.all( 5),
            child: Container(

              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backGroundColor, // background
              ),
              child: Padding(
                padding: image != null
                    ? const EdgeInsets.only(bottom: 8.0)
                    : const EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    image != null
                        ? Expanded(flex: 3, child: image)
                        : Container(width: 0, height: 0),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomText(
                          text: value,
                          size: textSize,
                          color: textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          topRight != null
              ? Positioned(
            child: topRight,
            top: 0,
            right: 0,
          )
              : Container(
            width: 0,
            height: 0,
          ),
          topLeft != null
              ? Positioned(
            child: topLeft,
            top: 0,
            left: 0,
          )
              : Container(
            width: 0,
            height: 0,
          ),
          bottomLeft != null
              ? Positioned(
            child: bottomLeft,
            bottom: 0,
            left: 0,
          )
              : Container(width: 0, height: 0),
          bottomRight != null
              ? Positioned(
            child: bottomRight,
            bottom: 0,
            right: 0,
          )
              : Container(
            width: 0,
            height: 0,
          ),
        ],
      ),
    );
  }
}

class CircularIconWithNumber extends StatelessWidget {
  final IconData icon;

  final Color backGroundColor;

  final Color iconColor;

  final double size;

  final double bubbleWidth;

  final double bubbleHeight;

  final String bubbleText;
  final double bubbleTextSize;
  final double fontSize;

  const CircularIconWithNumber(
      {Key key,
        this.icon,
        this.backGroundColor,
        this.iconColor,
        this.size = 15,
        this.bubbleWidth = 25,
        this.bubbleHeight = 25,
        this.bubbleText = '',
        this.bubbleTextSize = 25, this.fontSize=15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(children: [
            IconInsideCircle(
                icon: FontAwesomeIcons.exclamation,
                backGroundColor: Colors.red,
                color: Colors.white,
                iconSize: 25,
                size: size),
            Positioned(
                child: CircleShape(
                    text: bubbleText,
                    width: bubbleWidth,
                    height: bubbleHeight,
                    fontSize: fontSize),
                top: 0,
                right: 0),
          ]),
        ),
      ],
    );
  }
}

class ImageButton extends StatelessWidget {
  final String text;

  final Function function;

  final Color color;

  final double width;
  final double height;
  final Widget childWidget;

  const ImageButton(
      {Key key,
        this.text,
        this.function,
        this.color,
        this.width = 200,
        this.height = 80,
        this.childWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
            //
          ),
          child: Column(children: [
            childWidget != null
                ? Expanded(flex: 2, child: childWidget)
                : Container(width: 0, height: 0),
            Expanded(
              flex: 1,
              child: Center(child: CustomText(text: text)),
            )
          ])),
    );
  }
}