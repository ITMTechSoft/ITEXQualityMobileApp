import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class EmployeesBLL {
  //#region Properties
  int Id;
  String Employee_Name;
  String Employee_Barcode;
  int Depart_id;
  Uint8List Employee_Image;
  int Job_title_id;
  bool WorkerStatus;
  String Card_Code;
  int Emp_Type_id;
  String Employee_Password;
  String Employee_User;
  int Line_Id;
  bool ValidUser;
  String LoginMessage;

  //#endregion

  EmployeesBLL({this.Employee_User,this.Employee_Password}) {
    ValidUser = false;
  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Employee_Name = json['Employee_Name'];
    this.Employee_Barcode = json['Employee_Barcode'];
    this.Depart_id = json['Depart_id'];
   // this.Employee_Image = json['Employee_Image'];
    this.Job_title_id = json['Job_title_id'];
    this.WorkerStatus = json['WorkerStatus'];
    this.Card_Code = json['Card_Code'];
    this.Emp_Type_id = json['Emp_Type_id'];
    this.Employee_Password = json['Employee_Password'];
    this.Employee_User = json['Employee_User'];
    this.Line_Id = json['Line_Id'];
    this.ValidUser = json['ValidUser'];
    this.LoginMessage = json['LoginMessage'];

  }

  EmployeesBLL.fromJson(Map<String, dynamic> json):
        Id = json['Id'],
        Employee_Name = json['Employee_Name'],
        Employee_Barcode = json['Employee_Barcode'],
        Depart_id = json['Depart_id'],
        Employee_Image = json['Employee_Image'],
        Job_title_id = json['Job_title_id'],
        WorkerStatus = json['WorkerStatus'],
        Card_Code = json['Card_Code'],
        Emp_Type_id = json['Emp_Type_id'],
        Employee_Password = json['Employee_Password'],
        Employee_User = json['Employee_User'],
        Line_Id = json['Line_Id'],
        ValidUser = json['ValidUser'],
        LoginMessage = json['LoginMessage'];


  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Employee_Name': Employee_Name,
    'Employee_Barcode': Employee_Barcode,
    'Depart_id': Depart_id,
    'Employee_Image': Employee_Image,
    'Job_title_id': Job_title_id,
    'WorkerStatus': WorkerStatus,
    'Card_Code': Card_Code,
    'Emp_Type_id': Emp_Type_id,
    'Employee_Password': Employee_Password,
    'Employee_User': Employee_User,
    'Line_Id': Line_Id,
    'ValidUser': ValidUser,
    'LoginMessage': LoginMessage,


  };

  Map<String, String> toPost() => {


    'Id': this.Id.toString(),
    'Employee_Name': this.Employee_Name,
    'Employee_Barcode': this.Employee_Barcode,
    'Depart_id': this.Depart_id.toString(),
    'Employee_Image': this.Employee_Image.toString(),
    'Job_title_id': this.Job_title_id.toString(),
    'WorkerStatus': this.WorkerStatus.toString(),
    'Card_Code': this.Card_Code,
    'Emp_Type_id': this.Emp_Type_id.toString(),
    'Employee_Password': this.Employee_Password,
    'Employee_User': this.Employee_User,
    'Line_Id': this.Line_Id.toString(),
    'ValidUser': this.ValidUser.toString(),
    'LoginMessage': this.LoginMessage.toString(),

  };



//#endregion

  //#region login Methods
  Future<void> login() async {
    try {
      final String url =
      SharedPref.GetWebApiUrl(WebApiMethod.CheckUserConnection);
      // print ("#########--- $url");


      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

      print ("Pushing to the version 1   $url");


      print(jsonEncode(toPost()));


      if (response.statusCode == 200) {
        this.LoadFromJson(json.decode(response.body));
      }else
        {
          print(response.statusCode.toString() + ": " +response.toString());
        }
    } catch (Excpetion) {
      print(Excpetion);
    }
  }
  /// TODO: WHAT IS THE DIFFERENCE BETWEEN LOGIN AND SIGNIN
  Sign_In(String UserName, String Password) async {
    EmployeesBLL CheckUserLogin = new EmployeesBLL(Employee_User: UserName,Employee_Password: Password);
    Map data = {'User': CheckUserLogin};
    var jsonResponse = null;
    var response = await http.post(
        SharedPref.GetWebApiUrl(WebApiMethod.CheckUserConnection),
        body: data);
    if (response.statusCode == 200) {
      CheckUserLogin = EmployeesBLL.fromJson(json.decode(response.body));
    }
    return CheckUserLogin;
  }

  Logout() {
    this.ValidUser = false;
  }

//#endregion



}

