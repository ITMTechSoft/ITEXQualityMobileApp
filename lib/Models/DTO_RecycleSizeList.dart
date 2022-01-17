import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class DTO_RecycleSizeList {
  String? SizeName;
  int? Size_Id;
  int? Error_Amount;

  DTO_RecycleSizeList.fromJson(Map<String, dynamic> json)
      : Size_Id = json['Size_Id'],
        SizeName = json['SizeName'],
        Error_Amount = json['Error_Amount'];

  static Future<List<DTO_RecycleSizeList>?> Get_RecycleSizeList(
      int DeptModelOrder_QualityTest_Id) async {
    List<DTO_RecycleSizeList>? ItemList;
    try {
      Map<String, String> qParams = {
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_RecycleSizeList,
          Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DTO_RecycleSizeList.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
}
