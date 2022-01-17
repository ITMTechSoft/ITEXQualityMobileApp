import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Size_Measurement_AllowanceBLL {
  //#region Properties
  int Id = 0;
  int? DeptModelOrder_QualityTest_Id;
  int? ModelOrderSize_Id;
  String? Measurement;
  String? Note;
  double? Measure;
  double? Tolerance;
  int? QualityTest_Id;
  int? QualityDept_ModelOrder_Id;
  int? Size_Id;
  int? Order_id;

  double? Real_Measure;
  double? Pastal_Fark;
  int? CheckStatus = 0;

  //#endregion

  Size_Measurement_AllowanceBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.ModelOrderSize_Id = json['ModelOrderSize_Id'];
    this.Measurement = json['Measurement'];
    this.Note = json['Note'];
    this.Measure = json['Measure'];
    this.Tolerance = json['Tolerance'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.Size_Id = json['Size_Id'];
    this.Order_id = json['Order_id'];
    this.Real_Measure = json['Real_Measure'];
    this.Pastal_Fark = json['Pastal_Fark'];
    this.CheckStatus = json['CheckStatus'];
  }

  Size_Measurement_AllowanceBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        ModelOrderSize_Id = json['ModelOrderSize_Id'],
        Measurement = json['Measurement'],
        Note = json['Note'],
        Measure = json['Measure'],
        Tolerance = json['Tolerance'],
        QualityTest_Id = json['QualityTest_Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        Size_Id = json['Size_Id'],
        Order_id = json['Order_id'],
        Real_Measure = json['Real_Measure'],
        Pastal_Fark = json['Pastal_Fark'],
        CheckStatus = json['CheckStatus'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
        'ModelOrderSize_Id': ModelOrderSize_Id,
        'Measurement': Measurement,
        'Note': Note,
        'Measure': Measure,
        'Tolerance': Tolerance,
        'QualityTest_Id': QualityTest_Id,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
        'Size_Id': Size_Id,
        'Order_id': Order_id,
        'Real_Measure': Real_Measure,
        'Pastal_Fark': Pastal_Fark,
        'CheckStatus': CheckStatus,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'ModelOrderSize_Id': ModelOrderSize_Id.toString(),
        'Measurement': Measurement.toString(),
        'Note': Note.toString(),
        'Measure': Measure.toString(),
        'Tolerance': Tolerance.toString(),
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
        'Size_Id': Size_Id.toString(),
        'Order_id': Order_id.toString(),
        'Real_Measure': Real_Measure.toString(),
        'Pastal_Fark': Pastal_Fark.toString(),
        'CheckStatus': CheckStatus.toString(),
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<Size_Measurement_AllowanceBLL>?>
      Get_Size_Measurement_Allowance(
          {int? ModelOrderSize_Id,
          int? DeptModelOrder_QualityTest_Id,
          int? QualityDept_ModelOrder_Tracking_Id}) async {
    List<Size_Measurement_AllowanceBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'ModelOrderSize_Id': ModelOrderSize_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id.toString()
      };

      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_Size_Measurement_Allowance, Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Size_Measurement_AllowanceBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

/*
  Future<bool> SaveEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_CreateSize_Measurement_Allowance);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> UpdateEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_UpdateSize_Measurement_Allowance);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> DeleteEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_DeleteSize_Measurement_Allowance);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }
//#endregion
*/
}
