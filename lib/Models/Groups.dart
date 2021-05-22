import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class GroupsBLL {
  //#region Properties
  int Groups_id;
  int Source_Id;
  String Group_Name;
  String Group_Type;
  String Group_Description;
  String Group_Code;

  //#endregion

  GroupsBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Groups_id = json['Groups_id'];
    this.Source_Id = json['Source_Id'];
    this.Group_Name = json['Group_Name'];
    this.Group_Type = json['Group_Type'];
    this.Group_Description = json['Group_Description'];
    this.Group_Code = json['Group_Code'];

  }

  GroupsBLL.fromJson(Map<String, dynamic> json):
        Groups_id = json['Groups_id'],
        Source_Id = json['Source_Id'],
        Group_Name = json['Group_Name'],
        Group_Type = json['Group_Type'],
        Group_Description = json['Group_Description'],
        Group_Code = json['Group_Code'];


  Map<String, dynamic> toJson() => {
    'Groups_id': Groups_id,
    'Source_Id': Source_Id,
    'Group_Name': Group_Name,
    'Group_Type': Group_Type,
    'Group_Description': Group_Description,
    'Group_Code': Group_Code,

  };

  Map<String, String> toPost() => {


    'Groups_id': Groups_id.toString(),
    'Source_Id': Source_Id.toString(),
    'Group_Name': Group_Name,
    'Group_Type': Group_Type,
    'Group_Description': Group_Description,
    'Group_Code': Group_Code,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<GroupsBLL>> Get_TasnifGroups(
      int DeptModelOrder_QualityTest_Id) async {
    List<GroupsBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_TasnifControlGroups) +
              "?DeptModelOrder_QualityTest_Id=" +
              DeptModelOrder_QualityTest_Id.toString());

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => GroupsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
//#endregion



}

