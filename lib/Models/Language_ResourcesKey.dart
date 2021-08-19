import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Language_ResourcesKeyBLL {
  //#region Properties
  int Id;
  int Language_Id;
  int ResourcesKey_Id;
  String ResourceValue;
  DateTime CreateDate;
  DateTime LastUpdateDate;
  int CreatedBy;
  int LastUpdateBy;
  int Groups_id;
  int MoveId;
  String ResourceCode;
  String ResourceName;
  String ResourceDesc;
  String ResourceType;
  String CultureName;
  String ResKey;

  //#endregion

  Language_ResourcesKeyBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Language_Id = json['Language_Id'];
    this.ResourcesKey_Id = json['ResourcesKey_Id'];
    this.ResourceValue = json['ResourceValue'];
    this.CreateDate = json['CreateDate']==null? null: DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate']==null? null: DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.Groups_id = json['Groups_id'];
    this.MoveId = json['MoveId'];
    this.ResourceCode = json['ResourceCode'];
    this.ResourceName = json['ResourceName'];
    this.ResourceDesc = json['ResourceDesc'];
    this.ResourceType = json['ResourceType'];
    this.CultureName = json['CultureName'];
    this.ResKey = json['ResKey'];

  }

  Language_ResourcesKeyBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Language_Id = json['Language_Id'],
        ResourcesKey_Id = json['ResourcesKey_Id'],
        ResourceValue = json['ResourceValue'],
        CreateDate = json['CreateDate']==null? null:  DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate']==null? null:  DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        Groups_id = json['Groups_id'],
        MoveId = json['MoveId'],
        ResourceCode = json['ResourceCode'],
        ResourceName = json['ResourceName'],
        ResourceDesc = json['ResourceDesc'],
        ResourceType = json['ResourceType'],
        CultureName = json['CultureName'],
        ResKey = json['ResKey'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Language_Id': Language_Id,
    'ResourcesKey_Id': ResourcesKey_Id,
    'ResourceValue': ResourceValue,
    'CreateDate': CreateDate,
    'LastUpdateDate': LastUpdateDate,
    'CreatedBy': CreatedBy,
    'LastUpdateBy': LastUpdateBy,
    'Groups_id': Groups_id,
    'MoveId': MoveId,
    'ResourceCode': ResourceCode,
    'ResourceName': ResourceName,
    'ResourceDesc': ResourceDesc,
    'ResourceType': ResourceType,
    'CultureName': CultureName,
    'ResKey': ResKey,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'Language_Id': Language_Id.toString(),
    'ResourcesKey_Id': ResourcesKey_Id.toString(),
    'ResourceValue': ResourceValue,
    'CreateDate': CreateDate.toString(),
    'LastUpdateDate': LastUpdateDate.toString(),
    'CreatedBy': CreatedBy.toString(),
    'LastUpdateBy': LastUpdateBy.toString(),
    'Groups_id': Groups_id.toString(),
    'MoveId': MoveId.toString(),
    'ResourceCode': ResourceCode,
    'ResourceName': ResourceName,
    'ResourceDesc': ResourceDesc,
    'ResourceType': ResourceType,
    'CultureName': CultureName,
    'ResKey': ResKey,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<Language_ResourcesKeyBLL>?> Get_Language_ResourcesKey(
      int Language_Id) async {
    List<Language_ResourcesKeyBLL>? ItemList;
    try {


      Map<String,String> qParams = {
        'Language_Id':Language_Id.toString()
      };
      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Get_Language_ResourcesKey,qParams)
      );

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Language_ResourcesKeyBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
//#endregion



}

