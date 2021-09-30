import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Inline_QualityErrors {
  int Id = 0;
  int? User_QualityTracking_Detail_Id;
  int? Quality_Items_Id;
  String? Quality_Image;

  Inline_QualityErrors(
      {this.Quality_Items_Id,
      this.User_QualityTracking_Detail_Id,
      this.Quality_Image});

  Map<String, String> toPost() =>
      {
        'Id': Id.toString(),
        'User_QualityTracking_Detail_Id': User_QualityTracking_Detail_Id.toString(),
        'Quality_Items_Id': Quality_Items_Id.toString(),
        'Quality_Image': Quality_Image??'',
      };

  Future<bool> Set_QualityInlineError() async {
    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_QualityInlineError));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> Delete_QualityInlineError() async {
    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Delete_QualityInlineError));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {}
    return false;
  }
}
