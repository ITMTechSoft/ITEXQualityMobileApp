import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';


class Quality_ItemsBLL {
  //#region Properties
  int Id;
  int QualityTest_Id;
  int Group_Id;
  String Item_Name;
  int Item_Level;
  int Entity_Order;
  DateTime CreateDate;
  DateTime LastUpdateDate;
  int CreatedBy;
  int LastUpdateBy;
  String Group_Name;
  String Group_Type;

  //#endregion

  Quality_ItemsBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.Group_Id = json['Group_Id'];
    this.Item_Name = json['Item_Name'];
    this.Item_Level = json['Item_Level'];
    this.Entity_Order = json['Entity_Order'];
    this.CreateDate = json['CreateDate']==null? null: DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate']==null? null: DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.Group_Name = json['Group_Name'];
    this.Group_Type = json['Group_Type'];

  }

  Quality_ItemsBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        QualityTest_Id = json['QualityTest_Id'],
        Group_Id = json['Group_Id'],
        Item_Name = json['Item_Name'],
        Item_Level = json['Item_Level'],
        Entity_Order = json['Entity_Order'],
        CreateDate = json['CreateDate']==null? null:  DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate']==null? null:  DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        Group_Name = json['Group_Name'],
        Group_Type = json['Group_Type'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'QualityTest_Id': QualityTest_Id,
    'Group_Id': Group_Id,
    'Item_Name': Item_Name,
    'Item_Level': Item_Level,
    'Entity_Order': Entity_Order,
    'CreateDate': CreateDate,
    'LastUpdateDate': LastUpdateDate,
    'CreatedBy': CreatedBy,
    'LastUpdateBy': LastUpdateBy,
    'Group_Name': Group_Name,
    'Group_Type': Group_Type,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'QualityTest_Id': QualityTest_Id.toString(),
    'Group_Id': Group_Id.toString(),
    'Item_Name': Item_Name,
    'Item_Level': Item_Level.toString(),
    'Entity_Order': Entity_Order.toString(),
    'CreateDate': CreateDate.toString(),
    'LastUpdateDate': LastUpdateDate.toString(),
    'CreatedBy': CreatedBy.toString(),
    'LastUpdateBy': LastUpdateBy.toString(),
    'Group_Name': Group_Name,
    'Group_Type': Group_Type,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<Quality_ItemsBLL>> Get_Quality_Items(
      String GroupType
      ) async {
    List<Quality_ItemsBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_Quality_Items) +
              "?GroupType=" +
              GroupType);

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Quality_ItemsBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }



//#endregion



}

