import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class DepartmentModelOrder_QualityTestBLL {
  //#region Properties
  int Id;
  int QualityTest_Id;
  int QualityDept_ModelOrder_Id;
  DateTime? StartDate;
  DateTime? EndDate;
  bool? IsMandatory;
  int? Entity_Order;
  String? Test_Name;
  String? QualityType;
  int? Order_Id;
  int? Department_Id;
  bool? IsValidateRequired;
  bool? IsAutoMail;
  int? Sample_No;
  String? Accept_Level;
  String? Level_Code;
  String? Depart_Name;
  int? ControlAmount;

  //#endregion

  DepartmentModelOrder_QualityTestBLL(
      {required this.Id,
        required this.QualityTest_Id,
        required this.QualityDept_ModelOrder_Id}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.StartDate =
    json['StartDate'] == null ? null : DateTime.parse(json['StartDate']);
    this.EndDate =
    json['EndDate'] == null ? null : DateTime.parse(json['EndDate']);
    this.IsMandatory = json['IsMandatory'];
    this.Entity_Order = json['Entity_Order'];
    this.Test_Name = json['Test_Name'];
    this.QualityType = json['QualityType'];
    this.Order_Id = json['Order_Id'];
    this.Sample_No = json['Sample_No'];
    this.Department_Id = json['Department_Id'];
    this.IsValidateRequired = json['IsValidateRequired'];
    this.IsAutoMail = json['IsAutoMail'];
    this.ControlAmount = json['ControlAmount'];
  }

  DepartmentModelOrder_QualityTestBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        QualityTest_Id = json['QualityTest_Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        StartDate = json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        EndDate =
        json['EndDate'] == null ? null : DateTime.parse(json['EndDate']),
        IsMandatory = json['IsMandatory'],
        Entity_Order = json['Entity_Order'],
        Test_Name = json['Test_Name'],
        QualityType = json['QualityType'],
        Accept_Level = json['Accept_Level'],
        Level_Code = json['Level_Code'],
        Depart_Name = json['Depart_Name'],
        Order_Id = json['Order_Id'],
        Sample_No = json['Sample_No'],
        Department_Id = json['Department_Id'],
        IsValidateRequired = json['IsValidateRequired'],
        ControlAmount = json['ControlAmount'],
        IsAutoMail = json['IsAutoMail'];

  Map<String, dynamic> toJson() => {
    'Id': Id,
    'QualityTest_Id': QualityTest_Id,
    'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
    'StartDate': StartDate,
    'EndDate': EndDate,
    'IsMandatory': IsMandatory,
    'Entity_Order': Entity_Order,
    'Test_Name': Test_Name,
    'QualityType': QualityType,
    'Accept_Level': Accept_Level,
    'Level_Code': Level_Code,
    'Depart_Name': Depart_Name,
    'Order_Id': Order_Id,
    'Department_Id': Department_Id,
    'IsValidateRequired': IsValidateRequired,
    'IsAutoMail': IsAutoMail,
    'Sample_No': Sample_No,
    'ControlAmount': ControlAmount,
  };

  Map<String, String> toPost() => {
    'Id': Id.toString(),
    'QualityTest_Id': QualityTest_Id.toString(),
    'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
    'StartDate': StartDate.toString(),
    'EndDate': EndDate.toString(),
    'IsMandatory': IsMandatory.toString(),
    'Entity_Order': Entity_Order.toString(),
    'Test_Name': Test_Name ?? '',
    'QualityType': QualityType ?? '',
    'Accept_Level': Accept_Level ?? '',
    'Level_Code': Level_Code ?? '',
    'Depart_Name': Depart_Name ?? '',
    'Order_Id': Order_Id.toString(),
    'Sample_No': Sample_No.toString(),
    'Department_Id': Department_Id.toString(),
    'IsValidateRequired': IsValidateRequired.toString(),
    'IsAutoMail': IsAutoMail.toString(),
    'ControlAmount': ControlAmount.toString(),
  };

//#endregion

  static Future<List<DepartmentModelOrder_QualityTestBLL>?>
  Get_DepartmentModelOrder_QualityTest(
      int QualityDept_ModelOrder_Id) async {
    List<DepartmentModelOrder_QualityTestBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_DepartmentModelOrder_QualityTest,
          Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DepartmentModelOrder_QualityTestBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SetValidationAction(int? Employee_Id) async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = this.Id;
      //  Item.Id = 0;
      Item.ApprovalDate = new DateTime.now();

      String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Set_ValidatQualityCriticalQualityTest));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        if (Item.Id != 0) return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> IsUserApprovedBefore({required int Employee_Id}) async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = this.Id;

      String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.IsUserApprovedCriteriaBefore));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        if (Item.ApprovalDate != null) return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> CloseQualityDepartmentTest() async {
    try {

      Map<String, String> qParams = {
        'DepartmentModelOrder_QualityTest_Id': Id.toString(),
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.CloseQualityDepartmentTest,
          Paramters: qParams));
      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> StartQualityDepartmentTest() async {
    try {

      Map<String, String> qParams = {
        'DepartmentModelOrder_QualityTest_Id': Id.toString(),
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.StartQualityDepartmentTest,
          Paramters: qParams));
      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> UpdateEntity() async {
    try {

      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_DepartmentModelOrder_QualityTest));
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

  void CalcCheckSample() {
    this.ControlAmount = (sqrt(this.Sample_No!.toDouble()) * 2).round();
  }

//#endregion

}
