import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class RoundTestBLL {
  //#region Properties
  int Id = 0;
  int? QualityDept_ModelOrder_Id;
  DateTime? StartTime;
  DateTime? EndTime;
  int? RoundNo;
  String? Note;
  int? Order_Id;
  int? Department_Id;

  //#endregion

  RoundTestBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.StartTime =
        json['StartTime'] == null ? null : DateTime.parse(json['StartTime']);
    this.EndTime =
        json['EndTime'] == null ? null : DateTime.parse(json['EndTime']);
    this.RoundNo = json['RoundNo'];
    this.Note = json['Note'];
    this.Order_Id = json['Order_Id'];
    this.Department_Id = json['Department_Id'];
  }

  RoundTestBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        StartTime = json['StartTime'] == null
            ? null
            : DateTime.parse(json['StartTime']),
        EndTime =
            json['EndTime'] == null ? null : DateTime.parse(json['EndTime']),
        RoundNo = json['RoundNo'],
        Note = json['Note'],
        Order_Id = json['Order_Id'],
        Department_Id = json['Department_Id'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
        'StartTime': StartTime,
        'EndTime': EndTime,
        'RoundNo': RoundNo,
        'Note': Note,
        'Order_Id': Order_Id,
        'Department_Id': Department_Id,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
        'StartTime': StartTime.toString(),
        'EndTime': EndTime.toString(),
        'RoundNo': RoundNo.toString(),
        'Note': Note.toString(),
        'Order_Id': Order_Id.toString(),
        'Department_Id': Department_Id.toString(),
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<RoundTestBLL>?> Get_RoundTest(
      int DeptModelOrder_QualityTest_Id) async {
    List<RoundTestBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'QualityDept_ModelOrder_Id': DeptModelOrder_QualityTest_Id.toString()
      };

      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_RoundTest,
          Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => RoundTestBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Future<bool> GenerateRoundCopy(
      int QualityDepartment_ModelOrder_Id) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Set_QualityDepartment_ModelOrder)+"?QualityDepartment_ModelOrder_Id=$QualityDepartment_ModelOrder_Id");

      var response = await http.post(url, body: null, headers: headers);

      if(response.statusCode == 200){
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

//#endregion
}
