import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class User_QualityTracking_DetailBLL {
  //#region Properties
  int Id;
  int QualityDept_ModelOrder_Tracking_Id;
  DateTime Create_Date;
  DateTime Update_Date;
  int Amount;
  int Quality_Items_Id;
  int Xaxis_QualityItem_Id;
  int Yaxis_QualityItem_Id;
  int Recycle_Amount;
  DateTime Recycle_Date;
  int Recycle_Employee_Id;
  int Operation_Id;
  int EmpLine_DailyMoves_Id;
  int Employee_DailyProduction_Id;
  int CheckStatus;
  String Reject_Note;
  int Correct_Amount;
  int Error_Amount;
  int Employee_Id;
  int DeptModelOrder_QualityTest_Id;
  int OrderSizeColorDetail_Id;
  int Accessory_ModelOrder_Id;
  int Plan_Daily_Production_Id;
  String Item_Name;
  int Item_Level;
  int Entity_Order;
  int Group_Id;
  String Employee_Name;
  String Inline_Employee_Name;
  int Inline_Employee_Id;
  String Operation_Name;
  bool IsRecycle;

  int AssignAmount;
  String ControlType;
  int Order_Id;

  DateTime StartDate;
  DateTime EndDate;

  //#endregion

  User_QualityTracking_DetailBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.QualityDept_ModelOrder_Tracking_Id =
    json['QualityDept_ModelOrder_Tracking_Id'];
    this.Create_Date = json['Create_Date'] == null
        ? null
        : DateTime.parse(json['Create_Date']);
    this.Update_Date = json['Update_Date'] == null
        ? null
        : DateTime.parse(json['Update_Date']);
    this.StartDate = json['StartDate'] == null
        ? null
        : DateTime.parse(json['StartDate']);
    this.EndDate = json['EndDate'] == null
        ? null
        : DateTime.parse(json['EndDate']);
    this.Amount = json['Amount'];
    this.Quality_Items_Id = json['Quality_Items_Id'];
    this.Xaxis_QualityItem_Id = json['Xaxis_QualityItem_Id'];
    this.Yaxis_QualityItem_Id = json['Yaxis_QualityItem_Id'];
    this.Recycle_Amount = json['Recycle_Amount'];
    this.Recycle_Date = json['Recycle_Date'] == null
        ? null
        : DateTime.parse(json['Recycle_Date']);
    this.Recycle_Employee_Id = json['Recycle_Employee_Id'];
    this.Operation_Id = json['Operation_Id'];
    this.EmpLine_DailyMoves_Id = json['EmpLine_DailyMoves_Id'];
    this.Employee_DailyProduction_Id = json['Employee_DailyProduction_Id'];
    this.CheckStatus = json['CheckStatus'];
    this.Reject_Note = json['Reject_Note'];
    this.Correct_Amount = json['Correct_Amount'];
    this.Error_Amount = json['Error_Amount'];
    this.Employee_Id = json['Employee_Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'];
    this.Accessory_ModelOrder_Id = json['Accessory_ModelOrder_Id'];
    this.Plan_Daily_Production_Id = json['Plan_Daily_Production_Id'];
    this.Item_Name = json['Item_Name'];
    this.Item_Level = json['Item_Level'];
    this.Entity_Order = json['Entity_Order'];
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.Group_Id = json['Group_Id'];
    this.Item_Name = json['Item_Name'];
    this.Item_Level = json['Item_Level'];
    this.Entity_Order = json['Entity_Order'];
    this.Employee_Name = json['Employee_Name'];
    this.Inline_Employee_Id = json['Inline_Employee_Id'];
    this.Inline_Employee_Name = json['Inline_Employee_Name'];
    this.Operation_Name = json['Operation_Name'];

  }

  User_QualityTracking_DetailBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        QualityDept_ModelOrder_Tracking_Id =
        json['QualityDept_ModelOrder_Tracking_Id'],
        Create_Date = json['Create_Date'] == null
            ? null
            : DateTime.parse(json['Create_Date']),
        Update_Date = json['Update_Date'] == null
            ? null
            : DateTime.parse(json['Update_Date']),
        StartDate = json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        EndDate = json['EndDate'] == null
            ? null
            : DateTime.parse(json['EndDate']),
        Amount = json['Amount'],
        Quality_Items_Id = json['Quality_Items_Id'],
        Xaxis_QualityItem_Id = json['Xaxis_QualityItem_Id'],
        Yaxis_QualityItem_Id = json['Yaxis_QualityItem_Id'],
        Recycle_Amount = json['Recycle_Amount'],
        Recycle_Date = json['Recycle_Date'] == null
            ? null
            : DateTime.parse(json['Recycle_Date']),
        Recycle_Employee_Id = json['Recycle_Employee_Id'],
        Operation_Id = json['Operation_Id'],
        EmpLine_DailyMoves_Id = json['EmpLine_DailyMoves_Id'],
        Employee_DailyProduction_Id = json['Employee_DailyProduction_Id'],
        CheckStatus = json['CheckStatus'],
        Reject_Note = json['Reject_Note'],
        Correct_Amount = json['Correct_Amount'],
        Error_Amount = json['Error_Amount'],
        Employee_Id = json['Employee_Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'],
        Accessory_ModelOrder_Id = json['Accessory_ModelOrder_Id'],
        Plan_Daily_Production_Id = json['Plan_Daily_Production_Id'],
        Item_Name = json['Item_Name'],
        Item_Level = json['Item_Level'],
        Entity_Order = json['Entity_Order'],
        Group_Id = json['Group_Id'],
        Employee_Name = json['Employee_Name'],
        Inline_Employee_Name = json['Inline_Employee_Name'],
        Inline_Employee_Id = json['Inline_Employee_Id'],
        Operation_Name = json['Operation_Name'];

  Map<String, dynamic> toJson() => {
    'Id': Id,
    'QualityDept_ModelOrder_Tracking_Id':
    QualityDept_ModelOrder_Tracking_Id,
    'Create_Date': Create_Date,
    'Update_Date': Update_Date,
    'Amount': Amount,
    'Quality_Items_Id': Quality_Items_Id,
    'Xaxis_QualityItem_Id': Xaxis_QualityItem_Id,
    'Yaxis_QualityItem_Id': Yaxis_QualityItem_Id,
    'Recycle_Amount': Recycle_Amount,
    'Recycle_Date': Recycle_Date,
    'Recycle_Employee_Id': Recycle_Employee_Id,
    'Operation_Id': Operation_Id,
    'EmpLine_DailyMoves_Id': EmpLine_DailyMoves_Id,
    'Employee_DailyProduction_Id': Employee_DailyProduction_Id,
    'CheckStatus': CheckStatus,
    'Reject_Note': Reject_Note,
    'Correct_Amount': Correct_Amount,
    'Error_Amount': Error_Amount,
    'Employee_Id': Employee_Id,
    'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
    'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id,
    'Accessory_ModelOrder_Id': Accessory_ModelOrder_Id,
    'Plan_Daily_Production_Id': Plan_Daily_Production_Id,
    'Item_Name': Item_Name,
    'Item_Level': Item_Level,
    'Entity_Order': Entity_Order,
    'Id': Id,
    'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
    'Group_Id': Group_Id,
    'Item_Name': Item_Name,
    'Item_Level': Item_Level,
    'Entity_Order': Entity_Order,
    'Employee_Name': Employee_Name,
    'Inline_Employee_Id': Inline_Employee_Id,
    'Inline_Employee_Name': Inline_Employee_Name,
    'Operation_Name': Operation_Name,
    'StartDate': StartDate,
    'EndDate': EndDate
  };

  Map<String, String> toPost() => {
    'Id': Id.toString(),
    'QualityDept_ModelOrder_Tracking_Id':
    QualityDept_ModelOrder_Tracking_Id.toString(),
    'Create_Date': Create_Date.toString(),
    'Update_Date': Update_Date.toString(),
    'StartDate': StartDate.toString(),
    'EndDate': EndDate.toString(),
    'Amount': Amount.toString(),
    'Quality_Items_Id': Quality_Items_Id.toString(),
    'Xaxis_QualityItem_Id': Xaxis_QualityItem_Id.toString(),
    'Yaxis_QualityItem_Id': Yaxis_QualityItem_Id.toString(),
    'Recycle_Amount': Recycle_Amount.toString(),
    'Recycle_Date': Recycle_Date.toString(),
    'Recycle_Employee_Id': Recycle_Employee_Id.toString(),
    'Operation_Id': Operation_Id.toString(),
    'EmpLine_DailyMoves_Id': EmpLine_DailyMoves_Id.toString(),
    'Employee_DailyProduction_Id': Employee_DailyProduction_Id.toString(),
    'CheckStatus': CheckStatus.toString(),
    'Reject_Note': Reject_Note,
    'Correct_Amount': Correct_Amount.toString(),
    'Error_Amount': Error_Amount.toString(),
    'Employee_Id': Employee_Id.toString(),
    'DeptModelOrder_QualityTest_Id':
    DeptModelOrder_QualityTest_Id.toString(),
    'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id.toString(),
    'Accessory_ModelOrder_Id': Accessory_ModelOrder_Id.toString(),
    'Plan_Daily_Production_Id': Plan_Daily_Production_Id.toString(),
    'Item_Name': Item_Name,
    'Item_Level': Item_Level.toString(),
    'Entity_Order': Entity_Order.toString(),
    'Id': Id.toString(),
    'DeptModelOrder_QualityTest_Id':
    DeptModelOrder_QualityTest_Id.toString(),
    'Group_Id': Group_Id.toString(),
    'Item_Name': Item_Name,
    'Item_Level': Item_Level.toString(),
    'Entity_Order': Entity_Order.toString(),
    'Employee_Name': Employee_Name,
    'Inline_Employee_Id': Inline_Employee_Id.toString(),
    'Inline_Employee_Name': Inline_Employee_Name,
    'AssignAmount': AssignAmount.toString(),
    'ControlType': ControlType,
    'Order_Id': Order_Id.toString(),
    'IsRecycle': IsRecycle.toString(),
  };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<User_QualityTracking_DetailBLL>>
  Get_User_QualityTracking_Detail(
      int QualityDept_ModelOrder_Tracking_Id,{int Quality_Items_Id = 0}) async {
    List<User_QualityTracking_DetailBLL> ItemList;
    try {
      var response = await http.get(SharedPref.GetWebApiUrl(
          WebApiMethod.Get_User_QualityTracking_Detail) +
          "?QualityDept_ModelOrder_Tracking_Id=" +
          QualityDept_ModelOrder_Tracking_Id.toString() +
          "&Quality_Items_Id=" +
          Quality_Items_Id.toString());

      print(response.request);
      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => User_QualityTracking_DetailBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> Set_User_QualityTracking_Detail() async {
    try {
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.Set_User_QualityTracking_Detail);

      String val = jsonEncode(this.toPost());
      print(val);
      print(url);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));

      if (response.statusCode == 200)
        return true;

      return false;

    } catch (Excpetion) {
      print(Excpetion);
    }
  }
  Future<bool> Set_User_QualityTracking_Dikim() async {
    try {
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.Set_User_QualityTracking_Dikim);

      String val = jsonEncode(this.toPost());
      print(val);
      print(url);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));

      if (response.statusCode == 200)
        return true;

      return false;

    } catch (Excpetion) {
      print(Excpetion);
    }
  }

  Future<User_QualityTracking_DetailBLL>
  GenerateInlineEmployeeOperation() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_GenerateInlineEmployeeOperation);

      String val = jsonEncode(this.toPost());
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return this;
      }
    } catch (e) {}
    return null;
  }

  Future<bool> Start_DikimInlineProcess() async {
    try {
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.Start_DikimInlineProcess);

      String val = jsonEncode(this.toPost());

      print(url);
      print(val);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> Assign_EmployeeControlAmount(
      int assignAmount, String controlType) async {
    try {
      this.AssignAmount = assignAmount;
      this.ControlType = controlType;
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.Assign_EmployeeControlAmount);

      String val = jsonEncode(this.toPost());
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> CloseEmployeeOperationControlRound() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.CloseEmployeeOperationControlRound);

      String val = jsonEncode(this.toPost());
      print(url);
      print(val);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> Delete_User_QualityTracking_Detail() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Delete_User_QualityTracking_Detail);

      String val = jsonEncode(this.toPost());
      print(url);
      print(val);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(this.toPost()));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {}
    return false;
  }



  Future<int> Set_UserQualityFinalControl() async {
    int CheckStatus = -1;
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_UserQualityFinalControl);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        CheckStatus = json.decode(response.body);
      }
    } catch (e) {}
    return CheckStatus;
  }

//#endregion

}
