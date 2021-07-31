import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class QualityDepartment_ModelOrderBLL {
  //#region Properties
  int Id;
  int Order_Id;
  int Department_Id;
  DateTime StartDate;
  DateTime EndDate;
  bool IsValidateRequired;
  bool IsAutoMail;
  int Model_id;
  int Quantity;
  String Order_Number;
  String Depart_Name;
  String Model_Name;

  //#endregion

  QualityDepartment_ModelOrderBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Order_Id = json['Order_Id'];
    this.Department_Id = json['Department_Id'];
    this.StartDate =
        json['StartDate'] == null ? null : DateTime.parse(json['StartDate']);
    this.EndDate =
        json['EndDate'] == null ? null : DateTime.parse(json['EndDate']);
    this.IsValidateRequired = json['IsValidateRequired'];
    this.IsAutoMail = json['IsAutoMail'];

    this.Model_id = json['Model_id'];
    this.Quantity = json['Quantity'];
    this.Order_Number = json['Order_Number'];
    this.Depart_Name = json['Depart_Name'];
    this.Model_Name = json['Model_Name'];
  }

  QualityDepartment_ModelOrderBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Order_Id = json['Order_Id'],
        Department_Id = json['Department_Id'],
        StartDate = json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        EndDate =
            json['EndDate'] == null ? null : DateTime.parse(json['EndDate']),
        IsValidateRequired = json['IsValidateRequired'],
        IsAutoMail = json['IsAutoMail'],

        Model_id = json['Model_id'],
        Quantity = json['Quantity'],
        Order_Number = json['Order_Number'],
        Depart_Name = json['Depart_Name'],
        Model_Name = json['Model_Name'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Order_Id': Order_Id,
        'Department_Id': Department_Id,
        'StartDate': StartDate,
        'EndDate': EndDate,
        'IsValidateRequired': IsValidateRequired,
        'IsAutoMail': IsAutoMail,

        'Model_id': Model_id,
        'Quantity': Quantity,
        'Order_Number': Order_Number,
        'Depart_Name': Depart_Name,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Order_Id': Order_Id.toString(),
        'Department_Id': Department_Id.toString(),
        'StartDate': StartDate.toString(),
        'EndDate': EndDate.toString(),
        'IsValidateRequired': IsValidateRequired.toString(),
        'IsAutoMail': IsAutoMail.toString(),

        'Model_id': Model_id.toString(),
        'Quantity': Quantity.toString(),
        'Order_Number': Order_Number,
        'Depart_Name': Depart_Name,

      };

  //#endregion

//#region Methods
  static Get_QualityDepartment_ModelOrder(int Department_Id) async {
    List<QualityDepartment_ModelOrderBLL> ItemList;
    try {
      var response = await http.get(SharedPref.GetWebApiUrl(
              WebApiMethod.Get_QualityDepartment_ModelOrder) +
          "?Department_Id=" +
          Department_Id.toString());

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => QualityDepartment_ModelOrderBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
//#endregion
  Future<String> GetModelOrderImage() async {
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_ModelOrder_Image) +
              "?Order_Id=" +
              this.Order_Id.toString());

      if (response.statusCode == 200) {
        String Image = json.decode(response.body);
        return Image;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return null;
  }
}
