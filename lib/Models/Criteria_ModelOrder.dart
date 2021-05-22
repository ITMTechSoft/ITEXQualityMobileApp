import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';
import 'dart:async';

class Criteria_ModelOrderBLL {
  //#region Properties
  int Id;
  int DeptModelOrder_QualityTest_Id;
  bool IsMandatory;

  // Uint8List Criteria_Data;
  // Uint8List PDF_Data;
  String HTML_Data;
  int QualityTest_Id;
  int QualityDept_ModelOrder_Id;

  //#endregion

  Criteria_ModelOrderBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.IsMandatory = json['IsMandatory'];
    //  this.Criteria_Data = json['Criteria_Data'];
    //  this.PDF_Data = json['PDF_Data'];
    this.HTML_Data = json['HTML_Data'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
  }

  Criteria_ModelOrderBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        IsMandatory = json['IsMandatory'],
  //    Criteria_Data = json['Criteria_Data'],
  //   PDF_Data = json['PDF_Data'],
        HTML_Data = json['HTML_Data'],
        QualityTest_Id = json['QualityTest_Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];

  Map<String, dynamic> toJson() =>
      {
        'Id': Id,
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
        'IsMandatory': IsMandatory,
        //   'Criteria_Data': Criteria_Data,
        //  'PDF_Data': PDF_Data,
        'HTML_Data': HTML_Data,
        'QualityTest_Id': QualityTest_Id,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
      };

  Map<String, String> toPost() =>
      {
        'Id': Id.toString(),
        'DeptModelOrder_QualityTest_Id':
        DeptModelOrder_QualityTest_Id.toString(),
        'IsMandatory': IsMandatory.toString(),
        //   'Criteria_Data': Criteria_Data.toString(),
        //   'PDF_Data': PDF_Data.toString(),
        'HTML_Data': HTML_Data,
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<String> Get_Criteria_ModelOrder(
      int DeptModelOrder_QualityTest_Id) async {
    List<Criteria_ModelOrderBLL> ItemList;
    try {
      String URL =
          SharedPref.GetWebApiUrl(WebApiMethod.Get_Criteria_ModelOrder) +
              "?DeptModelOrder_QualityTest_Id=" +
              DeptModelOrder_QualityTest_Id.toString();
     // print(URL);
      var response = await http.get(URL);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Criteria_ModelOrderBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    if (ItemList.length > 0)
      return ItemList.first.HTML_Data;
    else
      return "";
  }
}
//#endregion
