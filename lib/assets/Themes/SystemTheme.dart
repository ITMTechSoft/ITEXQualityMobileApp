import 'dart:ui';
import 'package:flutter/material.dart';


class ArgonColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

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

  static const Color muted = Color.fromRGBO(231, 238, 139, 1.0);

  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static const Color errorinfo = Color.fromRGBO(180, 141, 123, 1.0);

  static const Color Group = Color.fromRGBO(255, 255, 204, 1.0);

  static const Color Title = Color.fromRGBO(64, 0, 0, 1.0);
}
class ArgonSize{
  static const double Header = 35;
  static const double MainMargin = 10;
  static const double normal = 13;
  static const double Header1 = 30;
  static const double Header2 = 25;
  static const double Header3 = 20;
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