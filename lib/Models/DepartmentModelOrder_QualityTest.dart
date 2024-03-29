import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class DepartmentModelOrder_QualityTestBLL {
  //#region Properties
  int Id;
  int QualityTest_Id;
  int QualityDept_ModelOrder_Id;
  DateTime StartDate;
  DateTime EndDate;
  bool IsMandatory;
  int Entity_Order;
  String Test_Name;
  int Order_Id;
  int Department_Id;
  bool IsValidateRequired;
  bool IsAutoMail;

  //#endregion

  DepartmentModelOrder_QualityTestBLL() {}

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
    this.Order_Id = json['Order_Id'];
    this.Department_Id = json['Department_Id'];
    this.IsValidateRequired = json['IsValidateRequired'];
    this.IsAutoMail = json['IsAutoMail'];
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
        Order_Id = json['Order_Id'],
        Department_Id = json['Department_Id'],
        IsValidateRequired = json['IsValidateRequired'],
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
        'Order_Id': Order_Id,
        'Department_Id': Department_Id,
        'IsValidateRequired': IsValidateRequired,
        'IsAutoMail': IsAutoMail,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
        'StartDate': StartDate.toString(),
        'EndDate': EndDate.toString(),
        'IsMandatory': IsMandatory.toString(),
        'Entity_Order': Entity_Order.toString(),
        'Test_Name': Test_Name,
        'Order_Id': Order_Id.toString(),
        'Department_Id': Department_Id.toString(),
        'IsValidateRequired': IsValidateRequired.toString(),
        'IsAutoMail': IsAutoMail.toString(),
      };

//#endregion

  static Future<List<DepartmentModelOrder_QualityTestBLL>>
      Get_DepartmentModelOrder_QualityTest(
          int QualityDept_ModelOrder_Id) async {
    List<DepartmentModelOrder_QualityTestBLL> ItemList;
    try {
      var response = await http.get(SharedPref.GetWebApiUrl(
              WebApiMethod.Get_DepartmentModelOrder_QualityTest) +
          "?QualityDept_ModelOrder_Id=" +
          QualityDept_ModelOrder_Id.toString());

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

  Future<bool> SetValidationAction({int Employee_Id}) async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = this.Id;
      //  Item.Id = 0;
      Item.ApprovalDate = new DateTime.now();

      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_ValidatQualityCriticalQualityTest);

      String val = jsonEncode(Item.toPost());
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        if (Item.Id != 0) return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }



  Future<bool> IsUserApprovedBefore({int Employee_Id}) async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = this.Id;

      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.IsUserApprovedCriteriaBefore);

      String val = jsonEncode(Item.toPost());
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        if (Item.ApprovalDate != null)
          return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
//#endregion

}
