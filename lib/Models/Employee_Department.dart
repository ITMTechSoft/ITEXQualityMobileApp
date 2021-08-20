import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Employee_DepartmentBLL {
//#region Properties
  int Id;
  int Department_Id;
  int Employee_Id;
  DateTime Start_Date;
  DateTime? End_Date;
  bool? IsValidator;
  DateTime? CreateDate;
  DateTime? LastUpdateDate;
  int? CreatedBy;
  int? LastUpdateBy;
  String? Depart_Name;
  String? Employee_Name;

  //#endregion

  Employee_DepartmentBLL(
      {required this.Id,
      required this.Employee_Id,
      required this.Department_Id,
      required this.Start_Date}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Department_Id = json['Department_Id'];
    this.Employee_Id = json['Employee_Id'];
    this.Start_Date =
        json['Start_Date'] ?? DateTime.parse(json['Start_Date']);
    this.End_Date =
        json['End_Date'] == null ? null : DateTime.parse(json['End_Date']);
    this.IsValidator = json['IsValidator'];
    this.CreateDate =
        json['CreateDate'] == null ? null : DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.Depart_Name = json['Depart_Name'];
    this.Employee_Name = json['Employee_Name'];
  }

  Employee_DepartmentBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Department_Id = json['Department_Id'],
        Employee_Id = json['Employee_Id'],
        Start_Date = json['Start_Date'] ?? DateTime.parse(json['Start_Date']),
        End_Date =
            json['End_Date'] == null ? null : DateTime.parse(json['End_Date']),
        IsValidator = json['IsValidator'],
        CreateDate = json['CreateDate'] == null
            ? null
            : DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate'] == null
            ? null
            : DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        Depart_Name = json['Depart_Name'],
        Employee_Name = json['Employee_Name'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Department_Id': Department_Id,
        'Employee_Id': Employee_Id,
        'Start_Date': Start_Date,
        'End_Date': End_Date,
        'IsValidator': IsValidator,
        'CreateDate': CreateDate,
        'LastUpdateDate': LastUpdateDate,
        'CreatedBy': CreatedBy,
        'LastUpdateBy': LastUpdateBy,
        'Depart_Name': Depart_Name,
        'Employee_Name': Employee_Name,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Department_Id': Department_Id.toString(),
        'Employee_Id': Employee_Id.toString(),
        'Start_Date': Start_Date.toString(),
        'End_Date': End_Date.toString(),
        'IsValidator': IsValidator.toString(),
        'CreateDate': CreateDate.toString(),
        'LastUpdateDate': LastUpdateDate.toString(),
        'CreatedBy': CreatedBy.toString(),
        'LastUpdateBy': LastUpdateBy.toString(),
        'Depart_Name': Depart_Name ?? '',
        'Employee_Name': Employee_Name ?? '',
      };

  //#endregion
  static Future<List<Employee_DepartmentBLL>?> Get_EmployeeDepartment(
      int Employee_Id) async {
    List<Employee_DepartmentBLL>? ItemList;
    try {
      Map<String, String> qParams = {'Employee_Id': Employee_Id.toString()};
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_EmployeeDepartment, qParams));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Employee_DepartmentBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
}
