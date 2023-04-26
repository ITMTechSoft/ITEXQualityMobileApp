import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class Quality_NotesBLL {
  //#region Properties
  int Id = 0;
  int? DepartmentModelOrder_QualityTest_Id;
  int? QualityDept_ModelOrder_Tracking_Id;
  int? QualityDepartment_ModelOrder_Id;
  String? DescNote;
  int? Employee_Id;

  //#endregion

  Quality_NotesBLL(
    this.Employee_Id,
    this.DescNote, {
    this.DepartmentModelOrder_QualityTest_Id = 0,
    this.QualityDept_ModelOrder_Tracking_Id = 0,
    this.QualityDepartment_ModelOrder_Id = 0,
  });

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.DepartmentModelOrder_QualityTest_Id =
        json['DepartmentModelOrder_QualityTest_Id'];
    this.QualityDept_ModelOrder_Tracking_Id =
        json['QualityDept_ModelOrder_Tracking_Id'];
    this.QualityDepartment_ModelOrder_Id =
        json['QualityDepartment_ModelOrder_Id'];
    this.DescNote = json['DescNote'];
    this.Employee_Id = json['Employee_Id'];
  }

  Quality_NotesBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        DepartmentModelOrder_QualityTest_Id =
            json['DepartmentModelOrder_QualityTest_Id'],
        QualityDept_ModelOrder_Tracking_Id =
            json['QualityDept_ModelOrder_Tracking_Id'],
        QualityDepartment_ModelOrder_Id =
            json['QualityDepartment_ModelOrder_Id'],
        DescNote = json['DescNote'],
        Employee_Id = json['Employee_Id'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'DepartmentModelOrder_QualityTest_Id':
            DepartmentModelOrder_QualityTest_Id,
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id,
        'QualityDepartment_ModelOrder_Id': QualityDepartment_ModelOrder_Id,
        'DescNote': DescNote,
        'Employee_Id': Employee_Id,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'DepartmentModelOrder_QualityTest_Id':
            DepartmentModelOrder_QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id.toString(),
        'QualityDepartment_ModelOrder_Id':
            QualityDepartment_ModelOrder_Id.toString(),
        'DescNote': DescNote.toString(),
        'Employee_Id': Employee_Id.toString(),
      };

  //#endregion

  Future<bool> SaveEntity() async {
    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateQuality_Notes));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        this.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

//#endregion
}
