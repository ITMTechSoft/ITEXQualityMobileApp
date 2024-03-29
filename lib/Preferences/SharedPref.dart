import 'package:itex_soft_qualityapp/Models/Languages.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  static String ServerIp;
  static String ServerPort;
  static String UserName;
  static String UserPassword;
  static String WebApiDomain;
  static LanguagesBLL SelLanguage;

  readFromJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs != null)
      return json.decode(prefs.getString(key) ?? "");
    else
      return null;
  }

  Future<String> ReadFromString(String Key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String res = preferences.getString(Key) ?? '';
    print('User Data Model Retrived ' + res.toString());
    return res;
  }

  static SavePrefernce(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  RemovePrefernce(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  initiateAppPrefernce() async {
    try {
      ServerIp = await ReadFromString("ServerIp");
      ServerPort = await ReadFromString("PortServer");
      UserName = await ReadFromString("UserName");
      UserPassword = await ReadFromString("UserPassword");
      String Lang = await ReadFromString("SelLanguage");
      SelLanguage = LanguagesBLL.fromJson(json.decode(Lang));
      WebApiDomain = "api/Quality";

      if (ServerIp.isNotEmpty || ServerPort.isNotEmpty) return true;
    } catch (Exception) {
      print(Exception);
    }
    return false;
  }

  static String GetWebApiUrl(WebApiMethod MethodName) {
    return "http://$ServerIp:$ServerPort/$WebApiDomain/${MethodName.toString().split('.').last}";
  }

  static Uri GetWebApiUri(
      WebApiMethod MethodName, Map<String, dynamic> Paramters) {
    String path = "/" + MethodName.toString().split('.').last;

    Uri target;
    if (Paramters == null)
      target = new Uri(
          scheme: "http",
          host: ServerIp,
          port: int.parse(ServerPort, radix: 16),
          path: path);
    else
      target = new Uri(
          scheme: "http",
          host: ServerIp,
          port: int.parse(ServerPort, radix: 16),
          path: path,
          queryParameters: Paramters);

    print(target);
    return target;
  }

  static SetupAndSave() async {
    try {
      await SavePrefernce("ServerIp", ServerIp);
      await SavePrefernce("PortServer", ServerPort);

      await SavePrefernce("UserName", UserName);
      await SavePrefernce("UserPassword", UserPassword);

      await SavePrefernce("SelLanguage", json.encode(SelLanguage.toJson()));

      if (ServerIp.isNotEmpty || ServerPort.isNotEmpty) return true;
    } catch (Exception) {
      print(Exception);
    }
    return false;
  }
}
