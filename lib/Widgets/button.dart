import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

const double defaultBorderRadius = 3.0;

Widget StandardButton(
        {required String Lable,
        required Function() OnTap,
        Color ForColor = ArgonColors.primary,
        Color BakColor = ArgonColors.primary,
        double? FontSize}) =>
    TextButton(
        child: Text(Lable.toUpperCase(),
            style: TextStyle(fontSize: FontSize ?? ArgonSize.Header4)),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(ArgonSize.Padding4)),
            foregroundColor: MaterialStateProperty.all<Color>(ForColor),
            backgroundColor: MaterialStateProperty.all<Color>(BakColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: ForColor)))),
        onPressed: OnTap);

Widget CircleButton(
    {Color ForColor = ArgonColors.myGreen,
    Color BakColor = ArgonColors.primary,
    required IconData ActionIcon,
    required Function() OnTap}) {
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
  required String text,
  double? buttonWidth ,
  double? buttonHegiht ,
  Color btnBgColor = ArgonColors.myLightBlue,
  double? textSize,
  Color  textColor = Colors.black54,
  Widget? topRight,
  Widget? topLeft,
  Widget? bottomRight,
  Widget? bottomLeft,
  Widget? image,
  bool orientation = false,
  Function()? OnTap
}) {
    return InkWell(
    child: Container(
        width: buttonWidth,
        height: buttonHegiht,
        child: Stack(children: [
          CustomContainer(
            width : buttonWidth??ArgonSize.WidthBig,
            height: buttonHegiht??ArgonSize.HeightBig,
            text: text,
            textColor: textColor,
            backGroundColor: btnBgColor,
            textSize: textSize ?? ArgonSize.Header4,
            image: image??Container(),
            topRight:    topRight?? Container(),
            topLeft:     topLeft??  Container(),
            bottomRight: bottomRight??Container(),
            bottomLeft:  bottomLeft??Container(),),
        ])),
    onTap: OnTap,
  );
}

Widget IconInsideCircle(
    {required IconData icon,
    Color color = Colors.white,
    double? iconSize,
    Color backGroundColor = ArgonColors.primary,
    double size = 13,
    Function()? function}) {
  return GestureDetector(
    onTap: function ?? () {},
    child: Container(
      padding: EdgeInsets.all(size),
      margin: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        size: iconSize ?? ArgonSize.IconSize,
        color: color,
      ),
    ),
  );
}

Widget CircleShape(
    {required String text,
    Color color = ArgonColors.myBlue2,
    required double width,
    required double height,
    double? fontSize,
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
            color: textColor,
            fontSize: fontSize ?? ArgonSize.Header4,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.value,
    required this.function,
    this.width,
    required this.height,
    this.backGroundColor = ArgonColors.primary,
    this.textColor       = ArgonColors.white,
    this.textSize,
  });

  final String value;
  final Function() function;
  final Color backGroundColor;
  final Color textColor;
  final double? width;
  final double height;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??getScreenWidth()/2,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backGroundColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: function,
        child: CustomText(
          text: value,
          size: textSize ?? ArgonSize.Header4,
          color: textColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required  this.text,
    this.backGroundColor = ArgonColors.primary,
    required this.width,
    required this.height,
    this.textColor = ArgonColors.black,
    required this.textSize ,
    required this.image,
    required this.topRight,
    required this.topLeft,
    required this.bottomRight,
    required this.bottomLeft,

  }) : super(key: key);



  final String text;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            /// TODO: REPLACE THE STATIC NUMBER WITH VALUE FROM ARGONSIZE
            padding: EdgeInsets.all(5),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                ///TODO: AND HERE
                borderRadius: BorderRadius.circular(15),
                color: backGroundColor, // background
              ),
              child: Padding(
                padding: image != null
                ///TODO : AND HERE
                    ? const EdgeInsets.only(bottom: 8.0)
                    : const EdgeInsets.only(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    image ,
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomText(
                          text: text,
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
          Positioned(
            child: topRight,
            top: 0,
            right: 0,
          ),
          Positioned(
            child: topLeft,
            top: 0,
            left: 0,
          ),
          Positioned(
            child: bottomLeft,
            bottom: 0,
            left: 0,
          ),
          Positioned(
            child: bottomRight,
            bottom: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}

class CircularIconWithNumber extends StatelessWidget {
  final IconData icon;
  final Color    backGroundColor;
  final Color    iconColor;
  final double   size;
  final double?  iconSize;
  final double?  bubbleWidth;
  final double?  bubbleHeight;
  final String?  bubbleText;
  final double?  bubbleTextSize;
  final Color    bubbleBgColor;
  final Function()? function;

  const CircularIconWithNumber(
      {Key? key,
      required this.icon,
      this.backGroundColor = ArgonColors.white,
      this.iconColor = ArgonColors.primary,
        /// TODO : CHNAGE THE FIXED NUMBER INTO VALUE FROM ARGON FILE
      this.size = 15,
      this.iconSize,
      this.bubbleWidth ,
      this.bubbleHeight ,
      this.bubbleText ,
      this.bubbleTextSize ,
      this.bubbleBgColor = ArgonColors.inputError,
      this.function,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: function??(){
            print('inside the function ');
          },
          child: AbsorbPointer(
            child: Container(
              child: Stack(
            children: [
                IconInsideCircle(
                    icon: icon,
                    backGroundColor: backGroundColor,
                    color: Colors.white,
                    iconSize: iconSize??ArgonSize.IconSize,
                    size: size),
                Positioned(
                    child: CircleShape(
                        color:   bubbleBgColor,
                        text :   bubbleText??'',
                        width:  bubbleWidth??ArgonSize.WidthSmall,
                        height: bubbleHeight??ArgonSize.HeightSmall,
                        fontSize: bubbleTextSize??ArgonSize.Header5),
                    top: 0,
                    right: 0),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
