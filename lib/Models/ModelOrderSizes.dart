import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';


class ModelOrderSizesBLL {
  //#region Properties
  int Id;
  int Size_Id;
  int Order_id;
  DateTime CreateDate;
  DateTime LastUpdateDate;
  int CreatedBy;
  int LastUpdateBy;
  String Param_StringVal;
  int Model_id;
  String Order_Number;

  //#endregion

  ModelOrderSizesBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Size_Id = json['Size_Id'];
    this.Order_id = json['Order_id'];
    this.CreateDate = json['CreateDate']==null? null: DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate']==null? null: DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.Param_StringVal = json['Param_StringVal'];
    this.Model_id = json['Model_id'];
    this.Order_Number = json['Order_Number'];

  }

  ModelOrderSizesBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Size_Id = json['Size_Id'],
        Order_id = json['Order_id'],
        CreateDate = json['CreateDate']==null? null:  DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate']==null? null:  DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        Param_StringVal = json['Param_StringVal'],
        Model_id = json['Model_id'],
        Order_Number = json['Order_Number'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Size_Id': Size_Id,
    'Order_id': Order_id,
    'CreateDate': CreateDate,
    'LastUpdateDate': LastUpdateDate,
    'CreatedBy': CreatedBy,
    'LastUpdateBy': LastUpdateBy,
    'Param_StringVal': Param_StringVal,
    'Model_id': Model_id,
    'Order_Number': Order_Number,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'Size_Id': Size_Id.toString(),
    'Order_id': Order_id.toString(),
    'CreateDate': CreateDate.toString(),
    'LastUpdateDate': LastUpdateDate.toString(),
    'CreatedBy': CreatedBy.toString(),
    'LastUpdateBy': LastUpdateBy.toString(),
    'Param_StringVal': Param_StringVal,
    'Model_id': Model_id.toString(),
    'Order_Number': Order_Number,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<ModelOrderSizesBLL>> Get_ModelOrderSizes(int Order_Id) async {
    List<ModelOrderSizesBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_ModelOrderSizes) +
              "?Order_Id=" +
              Order_Id.toString());

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => ModelOrderSizesBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

//#endregion



}

