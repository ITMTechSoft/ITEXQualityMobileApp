import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Accessory_ModelOrderBLL {
  //#region Properties
  int Id =0;
  int? DeptModelOrder_QualityTest_Id;
  int Accessory_Id =0;
  int Quantity =0;
  int? Checks_Quantity;
  bool? IsSupplierAutoEmail;
  int? Entity_Order;
  int? QualityDept_ModelOrder_Id;
  String? Accessory;
  String? Group_Name;
  //#endregion

  Accessory_ModelOrderBLL() {
    this.Id = 0;
    this.Accessory_Id = 0;
    this.Quantity = 0;

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.Accessory_Id = json['Accessory_Id'];
    this.Quantity = json['Quantity'];
    this.Checks_Quantity = json['Checks_Quantity'];
    this.IsSupplierAutoEmail = json['IsSupplierAutoEmail'];
    this.Entity_Order = json['Entity_Order'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.Accessory = json['Accessory'];
    this.Group_Name = json['Group_Name'];
  }

  Accessory_ModelOrderBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        Accessory_Id = json['Accessory_Id'],
        Quantity = json['Quantity'],
        Checks_Quantity = json['Checks_Quantity'],
        IsSupplierAutoEmail = json['IsSupplierAutoEmail'],
        Entity_Order = json['Entity_Order'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        Accessory = json['Accessory'],
        Group_Name = json['Group_Name'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
    'Accessory_Id': Accessory_Id,
    'Quantity': Quantity,
    'Checks_Quantity': Checks_Quantity,
    'IsSupplierAutoEmail': IsSupplierAutoEmail,
    'Entity_Order': Entity_Order,
    'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
    'Accessory': Accessory,
    'Group_Name': Group_Name,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id.toString(),
    'Accessory_Id': Accessory_Id.toString(),
    'Quantity': Quantity.toString(),
    'Checks_Quantity': Checks_Quantity.toString(),
    'IsSupplierAutoEmail': IsSupplierAutoEmail.toString(),
    'Entity_Order': Entity_Order.toString(),
    'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
    'Accessory': Accessory,
    'Group_Name': Group_Name,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<Accessory_ModelOrderBLL>> Get_Accessory_ModelOrder({int DeptModelOrder_QualityTest_Id = 0}) async {
    List<Accessory_ModelOrderBLL>? ItemList;
    try {

      Map<String, String> qParams = {
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id.toString(),
      };

      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Get_Accessory_ModelOrder,qParams) );

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Accessory_ModelOrderBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }




//#endregion



}

