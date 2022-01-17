import 'dart:ui';
import 'package:flutter/material.dart';


class ArgonColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color myGreen = Color.fromRGBO(33, 155, 84, 1.0);
  static const Color myYellow = Color.fromRGBO(233 , 237, 82, 1.0);
  static const Color myRed = Color.fromRGBO(237  , 82, 82, 1.0);
  static const Color LigthRed = Color.fromRGBO(109, 64, 64, 1.0);
  static const Color myBlue = Color.fromRGBO(2  , 8, 74, 1.0);
  static const Color myVinous = Color.fromRGBO(74  , 2, 2, 1.0);
  static const Color myOrange = Color.fromRGBO(	255, 199, 114, 1.0);
  static const Color myLightBlue = Color.fromRGBO(	63, 81, 181,1.0);
  static const Color myLightRed = Color.fromRGBO(  212, 53, 58,1.0);
  static const Color myLightGreen = Color.fromRGBO(    0, 207, 108,0.5);
  static const Color myBlue2 = Color.fromRGBO(    0, 56, 142, 1.0);
  static const Color myRed2 = Color.fromRGBO(     200, 8, 21,1);
  



  static const Color myGrey = Color.fromRGBO(124  , 124, 124, 1.0);

  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);

  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);

  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);

  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);

  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);

  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);

  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(250, 250, 221, 1.0);

  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);

  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);

  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);

  static const Color muted = Color.fromRGBO(238, 238, 212, 1.0);

  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static const Color errorinfo = Color.fromRGBO(180, 141, 123, 1.0);

  static const Color Group = Color.fromRGBO(255, 255, 204, 1.0);

  static const Color Title = Color.fromRGBO(64, 0, 0, 1.0);
  static const Color Pending = Color.fromRGBO(194, 191, 191, 1.0);
  static const Color Success = Color.fromRGBO(0, 110, 50, 1.0);
  static const Color Invalid = Color.fromRGBO(252, 50, 50, 1.0);
  static const Color UnderCheck = Color.fromRGBO(255, 255, 100, 1.0);

  static Color NormalColor = ArgonColors.white;
  static Color SelectedColor = ArgonColors.muted;
}
class ArgonSize{
  static  double Header = getAdaptiveTextSize(20);
  static const double MainMargin = 10;
  static const double normal = 13;

  //TEXT
  static  double BigHeader = getAdaptiveTextSize(50);
  static  double Header1 = getAdaptiveTextSize(30);
  static  double Header2 = getAdaptiveTextSize(25);
  static  double Header3 = getAdaptiveTextSize(20);
  static  double Header35 = getAdaptiveTextSize(18);
  static  double Header4 = getAdaptiveTextSize(15);
  static  double Header5 = getAdaptiveTextSize(12);
  static  double Header6 = getAdaptiveTextSize(10);
  static  double Header7 = getAdaptiveTextSize(9);


  static double Width1  = getAdaptiveTextSize(40);
  static double Height1 = getAdaptiveTextSize(40);


  static double WidthVeryBig     = getAdaptiveTextSize(90);
  static double HeightVeryBig    = getAdaptiveTextSize(90);

  static double ImageHeight    = getAdaptiveTextSize(160);

  static double WidthBig     = getAdaptiveTextSize(70);
  static double HeightBig    = getAdaptiveTextSize(70);

  static double HeightXMedium    = getAdaptiveTextSize(60);

  static double WidthMedium  = getAdaptiveTextSize(50);
  static double HeightMedium = getAdaptiveTextSize(50);

  static double WidthSmall1   = getAdaptiveTextSize(40);
  static double HeightSmall1  = getAdaptiveTextSize(40);

  static double WidthSmall   = getAdaptiveTextSize(30);
  static double HeightSmall  = getAdaptiveTextSize(30);

  static double WidthtooSmall   = getAdaptiveTextSize(20);
  static double HeighttooSmall  = getAdaptiveTextSize(20);

  static double IconSize    = getAdaptiveTextSize(20);
  static double IconSizeMedium    = getAdaptiveTextSize(30);
  static double IconSizeBig    = getAdaptiveTextSize(40);


  ///

  //PADDINGS
  static double Padding1  = getAdaptiveTextSize(20);
  static double Padding2  = getAdaptiveTextSize(15);
  static double Padding3  = getAdaptiveTextSize(15);

  static double Padding4 = getAdaptiveTextSize(14);
  static double Padding5  = getAdaptiveTextSize(10);
  static double Padding7  = getAdaptiveTextSize(12);
  static double Padding6  = getAdaptiveTextSize(8);
  static double Padding0  = getAdaptiveTextSize(50);

  static double RadioSwitchValue =  getAdaptiveTextSize(0.8);

}

final BlueTheme = ThemeData(
    primaryColor: Color(0xFF3F51B5),
    accentColor: Color(0xFFFF9800),
    backgroundColor: Color(0xFFFFFFFF),
    hintColor: Colors.grey,

    );

final DarkTheme = ThemeData(
    primaryColor: Color(0xFF000000),
    accentColor: Color(0xFFBB86FC),
    backgroundColor: Color(0xFF4A4A4A));

final GreenTheme = ThemeData(
    primaryColor: Color(0xFF4CAF50),
    accentColor: Color(0xFF631739),
    backgroundColor: Color(0xFFFFFFFF));

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = BlueTheme;

  ThemeNotifier(){}

  GetTheme() => _themeData;

  SetTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth ;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

double getScreenWidth() {
  double screenWidth = SizeConfig.screenWidth!;
  return screenWidth;
}
double getScreenHeight() {
  double screenHeight = SizeConfig.screenHeight!;
  //double screenHeight = 1000;

  return screenHeight;
}
// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getWidgetHeight(double num)
{
  double screenHeight = SizeConfig.screenHeight!;
  return (screenHeight/num);
}


double getAdaptiveTextSize(double value) {
  // 720 is medium screen height


  print( 'the screen height is ${ getScreenHeight()}');
  return (value / 720) * getScreenHeight();
}