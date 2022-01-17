import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';
import 'dart:async';

class Criteria_ModelOrderBLL {
  //#region Properties
  int Id;
  int DeptModelOrder_QualityTest_Id;
  bool? IsMandatory;
  String? HTML_Data;
  int? QualityTest_Id;
  int? QualityDept_ModelOrder_Id;
  int? WaitTimeSNY;

  //#endregion

  Criteria_ModelOrderBLL(
      {required this.Id, required this.DeptModelOrder_QualityTest_Id});

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.IsMandatory = json['IsMandatory'];
    this.HTML_Data = json['HTML_Data'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.WaitTimeSNY = json['WaitTimeSNY'];
  }

  Criteria_ModelOrderBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        IsMandatory = json['IsMandatory'],
        HTML_Data = json['HTML_Data'],
        QualityTest_Id = json['QualityTest_Id'],
        WaitTimeSNY = json['WaitTimeSNY'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
        'IsMandatory': IsMandatory,
        'HTML_Data': HTML_Data,
        'QualityTest_Id': QualityTest_Id,
        'WaitTimeSNY': WaitTimeSNY,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'IsMandatory': IsMandatory.toString(),
        'HTML_Data': HTML_Data.toString(),
        'WaitTimeSNY': WaitTimeSNY.toString(),
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<Criteria_ModelOrderBLL?> Get_Criteria_ModelOrder(
      int DeptModelOrder_QualityTest_Id) async {
    Criteria_ModelOrderBLL? Item =
        new Criteria_ModelOrderBLL(Id: 0, DeptModelOrder_QualityTest_Id: 0);
    try {
      Map<String, String> qParams = {
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_Criteria_ModelOrder,
          Paramters: qParams));

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        return Item;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return null;
  }
}
//#endregion
