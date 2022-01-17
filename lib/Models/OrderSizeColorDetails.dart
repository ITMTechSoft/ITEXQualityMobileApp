import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class OrderSizeColorDetailsBLL {
  //#region Properties
  int Id;
  int? Order_Id;
  int? Size_Id;
  int? Color_Id;
  int? PlanSizeColor_QTY;
  int? OrderSizeColor_QTY;
  int? SizeColor_QTY;
  DateTime? CreateDate;
  DateTime? LastUpdateDate;
  int? CreatedBy;
  int? LastUpdateBy;
  int? Source_Id;
  String? SizeColorNote;
  int? Model_id;
  int? Quantity;
  String? Order_Number;
  String? SizeParam_StringVal;
  int? SizeEntityOrder;
  String? ColorParam_StringVal;
  int? ColorEntityOrder;

  bool? IsChecked;

  int? ControlAmount;
  int? Remain_Value;

  int? AQLColorSize_Sample;
  int? Sample_No;
  int? AQL_Major;
  int? AQL_Minor;
  int? Sample_Amount;

  //#endregion

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Order_Id = json['Order_Id'];
    this.Size_Id = json['Size_Id'];
    this.Color_Id = json['Color_Id'];
    this.PlanSizeColor_QTY = json['PlanSizeColor_QTY'];
    this.OrderSizeColor_QTY = json['OrderSizeColor_QTY'];
    this.SizeColor_QTY = json['SizeColor_QTY'];
    this.CreateDate =
        json['CreateDate'] == null ? null : DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.Source_Id = json['Source_Id'];
    this.SizeColorNote = json['SizeColorNote'];
    this.Model_id = json['Model_id'];
    this.Quantity = json['Quantity'];
    this.Order_Number = json['Order_Number'];
    this.Size_Id = json['Size_Id'];
    this.Color_Id = json['Color_Id'];
    this.SizeParam_StringVal = json['SizeParam_StringVal'];
    this.SizeEntityOrder = json['SizeEntityOrder'];
    this.ColorParam_StringVal = json['ColorParam_StringVal'];
    this.ColorEntityOrder = json['ColorEntityOrder'];

    this.AQLColorSize_Sample = json['AQLColorSize_Sample'];
    this.Sample_No = json['Sample_No'];
    this.AQL_Major = json['AQL_Major'];
    this.AQL_Minor = json['AQL_Minor'];
    this.ControlAmount = json['ControlAmount'];
    this.Remain_Value = json['Remain_Value'];
    this.Sample_Amount = json['Sample_Amount'];
  }

  OrderSizeColorDetailsBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Order_Id = json['Order_Id'],
        Size_Id = json['Size_Id'],
        Color_Id = json['Color_Id'],
        PlanSizeColor_QTY = json['PlanSizeColor_QTY'],
        OrderSizeColor_QTY = json['OrderSizeColor_QTY'],
        SizeColor_QTY = json['SizeColor_QTY'],
        CreateDate = json['CreateDate'] == null
            ? null
            : DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate'] == null
            ? null
            : DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        Source_Id = json['Source_Id'],
        SizeColorNote = json['SizeColorNote'],
        Model_id = json['Model_id'],
        Quantity = json['Quantity'],
        Order_Number = json['Order_Number'],
        SizeParam_StringVal = json['SizeParam_StringVal'],
        SizeEntityOrder = json['SizeEntityOrder'],
        ColorParam_StringVal = json['ColorParam_StringVal'],
        ColorEntityOrder = json['ColorEntityOrder'],
        AQLColorSize_Sample = json['AQLColorSize_Sample'],
        Sample_No = json['Sample_No'],
        AQL_Major = json['AQL_Major'],
        AQL_Minor = json['AQL_Minor'],
        ControlAmount = json['ControlAmount'],
        Remain_Value = json['Remain_Value'],
        Sample_Amount = json['Sample_Amount'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Order_Id': Order_Id,
        'Size_Id': Size_Id,
        'Color_Id': Color_Id,
        'PlanSizeColor_QTY': PlanSizeColor_QTY,
        'OrderSizeColor_QTY': OrderSizeColor_QTY,
        'SizeColor_QTY': SizeColor_QTY,
        'CreateDate': CreateDate,
        'LastUpdateDate': LastUpdateDate,
        'CreatedBy': CreatedBy,
        'LastUpdateBy': LastUpdateBy,
        'Source_Id': Source_Id,
        'SizeColorNote': SizeColorNote,
        'Model_id': Model_id,
        'Quantity': Quantity,
        'Order_Number': Order_Number,
        'SizeParam_StringVal': SizeParam_StringVal,
        'SizeEntityOrder': SizeEntityOrder,
        'ColorParam_StringVal': ColorParam_StringVal,
        'ColorEntityOrder': ColorEntityOrder,
        'AQLColorSize_Sample': AQLColorSize_Sample,
        'Sample_No': Sample_No,
        'AQL_Major': AQL_Major,
        'AQL_Minor': AQL_Minor,
        'Sample_Amount': Sample_Amount
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Order_Id': Order_Id.toString(),
        'Size_Id': Size_Id.toString(),
        'Color_Id': Color_Id.toString(),
        'PlanSizeColor_QTY': PlanSizeColor_QTY.toString(),
        'OrderSizeColor_QTY': OrderSizeColor_QTY.toString(),
        'SizeColor_QTY': SizeColor_QTY.toString(),
        'CreateDate': CreateDate.toString(),
        'LastUpdateDate': LastUpdateDate.toString(),
        'CreatedBy': CreatedBy.toString(),
        'LastUpdateBy': LastUpdateBy.toString(),
        'Source_Id': Source_Id.toString(),
        'SizeColorNote': SizeColorNote.toString(),
        'Model_id': Model_id.toString(),
        'Quantity': Quantity.toString(),
        'Order_Number': Order_Number.toString(),
        'SizeParam_StringVal': SizeParam_StringVal.toString(),
        'SizeEntityOrder': SizeEntityOrder.toString(),
        'ColorParam_StringVal': ColorParam_StringVal.toString(),
        'ColorEntityOrder': ColorEntityOrder.toString(),
        'AQLColorSize_Sample': AQLColorSize_Sample.toString(),
        'Sample_No': Sample_No.toString(),
        'AQL_Major': AQL_Major.toString(),
        'AQL_Minor': AQL_Minor.toString(),
        'Sample_Amount': Sample_Amount.toString()
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<OrderSizeColorDetailsBLL>?> Get_OrderSizeColorDetails(
      int Order_id) async {
    List<OrderSizeColorDetailsBLL>? ItemList;
    try {
      Map<String, String> qParams = {'Order_id': Order_id.toString()};
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_OrderSizeColorDetails,
          Paramters: qParams));

      // print(response.request.toString());
      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => OrderSizeColorDetailsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Future<List<OrderSizeColorDetailsBLL>?> Get_FinalOrderSizeColorDetails(
      {int Order_Id = 0, int DeptModelOrder_QualityTest_Id = 0}) async {
    List<OrderSizeColorDetailsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'Order_id': Order_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
        DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_FinalOrderSizeColorDetails,
          Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => OrderSizeColorDetailsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Future<List<OrderSizeColorDetailsBLL>?> Get_AQLOrderSizeColorDetails(
      {int Order_Id = 0, int DeptModelOrder_QualityTest_Id = 0}) async {
    List<OrderSizeColorDetailsBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'Order_id': Order_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_AQLOrderSizeColorDetails,
          Paramters: qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => OrderSizeColorDetailsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
//#endregion

}
