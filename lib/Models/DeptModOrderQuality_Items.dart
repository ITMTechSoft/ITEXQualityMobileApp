import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Models/Inline_QualityErrors.dart';
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class DeptModOrderQuality_ItemsBLL {
  //#region Properties
  int? Id;

  int? DeptModelOrder_QualityTest_Id;
  int? Group_Id;
  String? Item_Name;

  /// TODO: Quality_Items_Id THIS FIELD EXIST IN DATABSAE BUT NOT EXIT HERE
  int? Item_Level;
  int? Entity_Order;
  int? QualityTest_Id;
  int? QualityDept_ModelOrder_Id;
  bool? IsMandatory;
  bool? IsTakeImage;
  String? Group_Name;
  int? Amount;
  int? Correct_Amount;
  int? Error_Amount;
  int? Employee_Id;
  int? ModelOrderSizes_Id;
  int? QualityDept_ModelOrder_Tracking_Id;
  int? CheckStatus;
  String? Reject_Note;

  //#endregion

  DeptModOrderQuality_ItemsBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.Group_Id = json['Group_Id'];
    this.Item_Name = json['Item_Name'];
    this.Item_Level = json['Item_Level'];
    this.Entity_Order = json['Entity_Order'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.IsMandatory = json['IsMandatory'];
    this.IsTakeImage = json['IsTakeImage'];
    this.Group_Name = json['Group_Name'];
    this.Amount = json['Amount'];
    this.Correct_Amount = json['Correct_Amount'];
    this.Error_Amount = json['Error_Amount'];
    this.Employee_Id = json['Employee_Id'];
    this.ModelOrderSizes_Id = json['ModelOrderSizes_Id'];
    this.QualityDept_ModelOrder_Tracking_Id =
        json['QualityDept_ModelOrder_Tracking_Id'];
    this.CheckStatus = json['CheckStatus'];
    this.Reject_Note = json['Reject_Note'];
  }

  DeptModOrderQuality_ItemsBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        Group_Id = json['Group_Id'],
        Item_Name = json['Item_Name'],
        Item_Level = json['Item_Level'],
        Entity_Order = json['Entity_Order'],
        QualityTest_Id = json['QualityTest_Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        IsMandatory = json['IsMandatory'],
        IsTakeImage = json['IsTakeImage'],
        Group_Name = json['Group_Name'],
        Amount = json['Amount'],
        Correct_Amount = json['Correct_Amount'],
        Error_Amount = json['Error_Amount'],
        Employee_Id = json['Employee_Id'],
        ModelOrderSizes_Id = json['ModelOrderSizes_Id'],
        QualityDept_ModelOrder_Tracking_Id =
            json["QualityDept_ModelOrder_Tracking_Id"],
        CheckStatus = json['CheckStatus'],
        Reject_Note = json['Reject_Note'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
        'Group_Id': Group_Id,
        'Item_Name': Item_Name,
        'Item_Level': Item_Level,
        'Entity_Order': Entity_Order,
        'QualityTest_Id': QualityTest_Id,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
        'IsMandatory': IsMandatory,
        'IsTakeImage': IsTakeImage,
        'Group_Name': Group_Name,
        'Amount': Amount,
        'Correct_Amount': Correct_Amount,
        'Error_Amount': Error_Amount,
        'Employee_Id': Employee_Id,
        'ModelOrderSizes_Id': ModelOrderSizes_Id,
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id,
        'CheckStatus': CheckStatus,
        'Reject_Note': Reject_Note,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'Group_Id': Group_Id.toString(),
        'Item_Name': Item_Name ?? '',
        'Item_Level': Item_Level.toString(),
        'Entity_Order': Entity_Order.toString(),
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
        'IsMandatory': IsMandatory.toString(),
        'IsTakeImage' : IsTakeImage.toString(),
        'Group_Name': Group_Name ?? '',
        'Amount': Amount.toString(),
        'Correct_Amount': Correct_Amount.toString(),
        'Error_Amount': Error_Amount.toString(),
        'Employee_Id': Employee_Id.toString(),
        'ModelOrderSizes_Id': ModelOrderSizes_Id.toString(),
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id.toString(),
        'CheckStatus': CheckStatus.toString(),
        'Reject_Note': Reject_Note ?? '',
      };

//#endregion

//#region GetWebApiUrl
  static Future<List<DeptModOrderQuality_ItemsBLL>?>
      Get_DeptModOrderQuality_Items(
          int Employee_Id,
          int DeptModelOrder_QualityTest_Id,
          int ModelOrderSizes_Id,
          int Pastal_Cutting_Parti_Id) async {
    List<DeptModOrderQuality_ItemsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'Employee_Id': Employee_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'ModelOrderSizes_Id': ModelOrderSizes_Id.toString(),
        'Pastal_Cutting_Parti_Id': Pastal_Cutting_Parti_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_DeptModOrderQuality_Items, qParams));

      //  print(response.request);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DeptModOrderQuality_ItemsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Future<List<DeptModOrderQuality_ItemsBLL>?>
      Get_DeptModOrderQualityTest_Items(
          int? DeptModelOrder_QualityTest_Id) async {
    List<DeptModOrderQuality_ItemsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_DeptModOrderQualityTest_Items, qParams));

      //  print(response.request);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DeptModOrderQuality_ItemsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<DeptModOrderQuality_ItemsBLL?> CorrectSpecificAmount(
      int EnterValue) async {
    this.Correct_Amount = EnterValue;
    this.Error_Amount = 0;

    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_DeptModOrderQualityItems));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        var Item = DeptModOrderQuality_ItemsBLL.fromJson(map);
        return Item;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return null;
  }

  Future<DeptModOrderQuality_ItemsBLL?> ErrorSpecificAmount(
      int EnterValue) async {
    this.Correct_Amount = 0;
    this.Error_Amount = EnterValue;

    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_DeptModOrderQualityItems));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        var map = json.decode(response.body);
        var Item = DeptModOrderQuality_ItemsBLL.fromJson(map);
        return Item;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }
    return null;
  }

  static Future<List<DeptModOrderQuality_ItemsBLL>?>
      Get_CuttingPastalQuality_Items(
          int Employee_Id, int DeptModelOrder_QualityTest_Id) async {
    List<DeptModOrderQuality_ItemsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'Employee_Id': Employee_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_CuttingPastalQuality_Items, qParams));

      //  print(response.request);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DeptModOrderQuality_ItemsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Get_DikimInlineQuality_Items(int? DeptModelOrder_QualityTest_Id,
      int User_QualityTracking_Detail_Id) async {
    List<DeptModOrderQuality_ItemsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'User_QualityTracking_Detail_Id':
            User_QualityTracking_Detail_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_DikimInlineQuality_Items, qParams));

      //  print(response.request);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => DeptModOrderQuality_ItemsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> Set_QualityInlineError(
      int User_QualityTracking_Detail_Id, {bool IsDelete =false,String? Image}) async {
    try {
      var InlineError = new Inline_QualityErrors(
          Quality_Items_Id: this.Id,
          User_QualityTracking_Detail_Id: User_QualityTracking_Detail_Id,
          Quality_Image: Image);
      bool Check = false;
      if (IsDelete) {
        if (this.Amount! > 0) {
          Check = await InlineError.Delete_QualityInlineError();
          if (Check) this.Amount = this.Amount! - 1;
        } else
          Check = true;
      } else {
        Check = await InlineError.Set_QualityInlineError();
        if (Check) this.Amount = this.Amount! + 1;
      }

      return Check;
    } catch (Excpetion) {
      print(Excpetion);
    }
    return false;
  }
//#endregion

}

class ItemLevel {
  static int XAxis = 1;
  static int YAxis = 2;
}
