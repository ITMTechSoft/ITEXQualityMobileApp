import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';


class Pastal_Cutting_PartiBLL {
  //#region Properties
  int Id;
  int Order_id;
  String Fabric_Type;
  DateTime CuttingDate;
  DateTime Pastel_Laying;
  String FabricRestingTime;
  int Create_Employee_Id;
  String Order_Number;
  String Employee_Name;

  //#endregion

  Pastal_Cutting_PartiBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Order_id = json['Order_id'];
    this.Fabric_Type = json['Fabric_Type'];
    this.CuttingDate = json['CuttingDate']==null? null: DateTime.parse(json['CuttingDate']);
    this.Pastel_Laying = json['Pastel_Laying']==null? null: DateTime.parse(json['Pastel_Laying']);
    this.FabricRestingTime = json['FabricRestingTime'];
    this.Create_Employee_Id = json['Create_Employee_Id'];
    this.Order_Number = json['Order_Number'];
    this.Employee_Name = json['Employee_Name'];

  }

  Pastal_Cutting_PartiBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Order_id = json['Order_id'],
        Fabric_Type = json['Fabric_Type'],
        CuttingDate = json['CuttingDate']==null? null:  DateTime.parse(json['CuttingDate']),
        Pastel_Laying = json['Pastel_Laying']==null? null:  DateTime.parse(json['Pastel_Laying']),
        FabricRestingTime = json['FabricRestingTime'],
        Create_Employee_Id = json['Create_Employee_Id'],
        Order_Number = json['Order_Number'],
        Employee_Name = json['Employee_Name'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Order_id': Order_id,
    'Fabric_Type': Fabric_Type,
    'CuttingDate': CuttingDate,
    'Pastel_Laying': Pastel_Laying,
    'FabricRestingTime': FabricRestingTime,
    'Create_Employee_Id': Create_Employee_Id,
    'Order_Number': Order_Number,
    'Employee_Name': Employee_Name,

  };

  Map<String, String> toPost() => {


    'Id': Id.toString(),
    'Order_id': Order_id.toString(),
    'Fabric_Type': Fabric_Type,
    'CuttingDate': CuttingDate.toString(),
    'Pastel_Laying': Pastel_Laying.toString(),
    'FabricRestingTime': FabricRestingTime,
    'Create_Employee_Id': Create_Employee_Id.toString(),
    'Order_Number': Order_Number,
    'Employee_Name': Employee_Name,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<Pastal_Cutting_PartiBLL>> Get_Pastal_Cutting_Parti(int Order_Id) async {
    List<Pastal_Cutting_PartiBLL> ItemList;
    try {


      Map<String,String> qParams = {
        'Order_Id':Order_Id.toString()
      };
      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Get_Pastal_Cutting_Parti, qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Pastal_Cutting_PartiBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
  Future<bool> SaveEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_CreatePastal_Cutting_Parti);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        this.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }



  Future<bool> DeleteEntity() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.DeletePastal_Cutting_Parti);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }
//#endregion



}

