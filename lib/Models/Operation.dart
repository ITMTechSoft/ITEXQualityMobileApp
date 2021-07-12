import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class OperationBLL {
  //#region Properties
  int Operation_Id;
  String Operationl_Code;
  String Operation_Description;
  String Operation_Name;
  int Operation_Groups;
  int Machine_id;
  double OperationToplamSTD;
  String ArticalNO;
  String OperationVideo;
  Uint8List OperationImage;
  double Thread_length;
  double Bobin_Number;
  String OperationVideoFileName;
  double HandTMU;
  double HandMin;
  double HandTolerStd;
  double MachineTMU;
  double MachineMin;
  double MachineTolStd;
  double Oper_Target;
  double Machine_ErrorPossible;
  double Total_SweingLength;
  double OperTMU;
  double Hour_Target;
  double Machine_Number;
  String Model_Operation_Barcode;
  int Oper_Sequence;
  int Model_id;
  int Real_Amount;
  int StitchesUsedFrequently_Id;
  double StitchThreadLength;
  double NeedleThread;
  double LooperThread;
  int Department_Id;
  int Material_Type_Id;
  int ModelCosting_Id;
  DateTime CreateDate;
  DateTime LastUpdateDate;
  int CreatedBy;
  int LastUpdateBy;
  bool IsBulkType;
  int BulkAdet;
  int Stitch_Tool_Id;
  String Source_Id;
  bool IsCriticalControl;
  String Group_Name;
  String Machine_name;
  String Model_Name;
  String Depart_Name;
  String Material_Name;
  String Tool_Name;

  //#endregion

  OperationBLL() {

  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Operation_Id = json['Operation_Id'];
    this.Operationl_Code = json['Operationl_Code'];
    this.Operation_Description = json['Operation_Description'];
    this.Operation_Name = json['Operation_Name'];
    this.Operation_Groups = json['Operation_Groups'];
    this.Machine_id = json['Machine_id'];
    this.OperationToplamSTD = json['OperationToplamSTD'];
    this.ArticalNO = json['ArticalNO'];
    this.OperationVideo = json['OperationVideo'];
    this.OperationImage = json['OperationImage'];
    this.Thread_length = json['Thread_length'];
    this.Bobin_Number = json['Bobin_Number'];
    this.OperationVideoFileName = json['OperationVideoFileName'];
    this.HandTMU = json['HandTMU'];
    this.HandMin = json['HandMin'];
    this.HandTolerStd = json['HandTolerStd'];
    this.MachineTMU = json['MachineTMU'];
    this.MachineMin = json['MachineMin'];
    this.MachineTolStd = json['MachineTolStd'];
    this.Oper_Target = json['Oper_Target'];
    this.Machine_ErrorPossible = json['Machine_ErrorPossible'];
    this.Total_SweingLength = json['Total_SweingLength'];
    this.OperTMU = json['OperTMU'];
    this.Hour_Target = json['Hour_Target'];
    this.Machine_Number = json['Machine_Number'];
    this.Model_Operation_Barcode = json['Model_Operation_Barcode'];
    this.Oper_Sequence = json['Oper_Sequence'];
    this.Model_id = json['Model_id'];
    this.Real_Amount = json['Real_Amount'];
    this.StitchesUsedFrequently_Id = json['StitchesUsedFrequently_Id'];
    this.StitchThreadLength = json['StitchThreadLength'];
    this.NeedleThread = json['NeedleThread'];
    this.LooperThread = json['LooperThread'];
    this.Department_Id = json['Department_Id'];
    this.Material_Type_Id = json['Material_Type_Id'];
    this.ModelCosting_Id = json['ModelCosting_Id'];
    this.CreateDate = json['CreateDate']==null? null: DateTime.parse(json['CreateDate']);
    this.LastUpdateDate = json['LastUpdateDate']==null? null: DateTime.parse(json['LastUpdateDate']);
    this.CreatedBy = json['CreatedBy'];
    this.LastUpdateBy = json['LastUpdateBy'];
    this.IsBulkType = json['IsBulkType'];
    this.BulkAdet = json['BulkAdet'];
    this.Stitch_Tool_Id = json['Stitch_Tool_Id'];
    this.Source_Id = json['Source_Id'];
    this.IsCriticalControl = json['IsCriticalControl'];
    this.Group_Name = json['Group_Name'];
    this.Machine_name = json['Machine_name'];
    this.Model_Name = json['Model_Name'];
    this.Depart_Name = json['Depart_Name'];
    this.Material_Name = json['Material_Name'];
    this.Tool_Name = json['Tool_Name'];

  }

  OperationBLL.fromJson(Map<String, dynamic> json):
        Operation_Id = json['Operation_Id'],
        Operationl_Code = json['Operationl_Code'],
        Operation_Description = json['Operation_Description'],
        Operation_Name = json['Operation_Name'],
        Operation_Groups = json['Operation_Groups'],
        Machine_id = json['Machine_id'],
        OperationToplamSTD = json['OperationToplamSTD'],
        ArticalNO = json['ArticalNO'],
        OperationVideo = json['OperationVideo'],
        OperationImage = json['OperationImage'],
        Thread_length = json['Thread_length'],
        Bobin_Number = json['Bobin_Number'],
        OperationVideoFileName = json['OperationVideoFileName'],
        HandTMU = json['HandTMU'],
        HandMin = json['HandMin'],
        HandTolerStd = json['HandTolerStd'],
        MachineTMU = json['MachineTMU'],
        MachineMin = json['MachineMin'],
        MachineTolStd = json['MachineTolStd'],
        Oper_Target = json['Oper_Target'],
        Machine_ErrorPossible = json['Machine_ErrorPossible'],
        Total_SweingLength = json['Total_SweingLength'],
        OperTMU = json['OperTMU'],
        Hour_Target = json['Hour_Target'],
        Machine_Number = json['Machine_Number'],
        Model_Operation_Barcode = json['Model_Operation_Barcode'],
        Oper_Sequence = json['Oper_Sequence'],
        Model_id = json['Model_id'],
        Real_Amount = json['Real_Amount'],
        StitchesUsedFrequently_Id = json['StitchesUsedFrequently_Id'],
        StitchThreadLength = json['StitchThreadLength'],
        NeedleThread = json['NeedleThread'],
        LooperThread = json['LooperThread'],
        Department_Id = json['Department_Id'],
        Material_Type_Id = json['Material_Type_Id'],
        ModelCosting_Id = json['ModelCosting_Id'],
        CreateDate = json['CreateDate']==null? null:  DateTime.parse(json['CreateDate']),
        LastUpdateDate = json['LastUpdateDate']==null? null:  DateTime.parse(json['LastUpdateDate']),
        CreatedBy = json['CreatedBy'],
        LastUpdateBy = json['LastUpdateBy'],
        IsBulkType = json['IsBulkType'],
        BulkAdet = json['BulkAdet'],
        Stitch_Tool_Id = json['Stitch_Tool_Id'],
        Source_Id = json['Source_Id'],
        IsCriticalControl = json['IsCriticalControl'],
        Group_Name = json['Group_Name'],
        Machine_name = json['Machine_name'],
        Model_Name = json['Model_Name'],
        Depart_Name = json['Depart_Name'],
        Material_Name = json['Material_Name'],
        Tool_Name = json['Tool_Name'];


  Map<String, dynamic> toJson() => {
    'Operation_Id': Operation_Id,
    'Operationl_Code': Operationl_Code,
    'Operation_Description': Operation_Description,
    'Operation_Name': Operation_Name,
    'Operation_Groups': Operation_Groups,
    'Machine_id': Machine_id,
    'OperationToplamSTD': OperationToplamSTD,
    'ArticalNO': ArticalNO,
    'OperationVideo': OperationVideo,
    'OperationImage': OperationImage,
    'Thread_length': Thread_length,
    'Bobin_Number': Bobin_Number,
    'OperationVideoFileName': OperationVideoFileName,
    'HandTMU': HandTMU,
    'HandMin': HandMin,
    'HandTolerStd': HandTolerStd,
    'MachineTMU': MachineTMU,
    'MachineMin': MachineMin,
    'MachineTolStd': MachineTolStd,
    'Oper_Target': Oper_Target,
    'Machine_ErrorPossible': Machine_ErrorPossible,
    'Total_SweingLength': Total_SweingLength,
    'OperTMU': OperTMU,
    'Hour_Target': Hour_Target,
    'Machine_Number': Machine_Number,
    'Model_Operation_Barcode': Model_Operation_Barcode,
    'Oper_Sequence': Oper_Sequence,
    'Model_id': Model_id,
    'Real_Amount': Real_Amount,
    'StitchesUsedFrequently_Id': StitchesUsedFrequently_Id,
    'StitchThreadLength': StitchThreadLength,
    'NeedleThread': NeedleThread,
    'LooperThread': LooperThread,
    'Department_Id': Department_Id,
    'Material_Type_Id': Material_Type_Id,
    'ModelCosting_Id': ModelCosting_Id,
    'CreateDate': CreateDate,
    'LastUpdateDate': LastUpdateDate,
    'CreatedBy': CreatedBy,
    'LastUpdateBy': LastUpdateBy,
    'IsBulkType': IsBulkType,
    'BulkAdet': BulkAdet,
    'Stitch_Tool_Id': Stitch_Tool_Id,
    'Source_Id': Source_Id,
    'IsCriticalControl': IsCriticalControl,
    'Group_Name': Group_Name,
    'Machine_name': Machine_name,
    'Model_Name': Model_Name,
    'Depart_Name': Depart_Name,
    'Material_Name': Material_Name,
    'Tool_Name': Tool_Name,

  };

  Map<String, String> toPost() => {


    'Operation_Id': Operation_Id.toString(),
    'Operationl_Code': Operationl_Code,
    'Operation_Description': Operation_Description,
    'Operation_Name': Operation_Name,
    'Operation_Groups': Operation_Groups.toString(),
    'Machine_id': Machine_id.toString(),
    'OperationToplamSTD': OperationToplamSTD.toString(),
    'ArticalNO': ArticalNO,
    'OperationVideo': OperationVideo,
    'OperationImage': OperationImage.toString(),
    'Thread_length': Thread_length.toString(),
    'Bobin_Number': Bobin_Number.toString(),
    'OperationVideoFileName': OperationVideoFileName,
    'HandTMU': HandTMU.toString(),
    'HandMin': HandMin.toString(),
    'HandTolerStd': HandTolerStd.toString(),
    'MachineTMU': MachineTMU.toString(),
    'MachineMin': MachineMin.toString(),
    'MachineTolStd': MachineTolStd.toString(),
    'Oper_Target': Oper_Target.toString(),
    'Machine_ErrorPossible': Machine_ErrorPossible.toString(),
    'Total_SweingLength': Total_SweingLength.toString(),
    'OperTMU': OperTMU.toString(),
    'Hour_Target': Hour_Target.toString(),
    'Machine_Number': Machine_Number.toString(),
    'Model_Operation_Barcode': Model_Operation_Barcode,
    'Oper_Sequence': Oper_Sequence.toString(),
    'Model_id': Model_id.toString(),
    'Real_Amount': Real_Amount.toString(),
    'StitchesUsedFrequently_Id': StitchesUsedFrequently_Id.toString(),
    'StitchThreadLength': StitchThreadLength.toString(),
    'NeedleThread': NeedleThread.toString(),
    'LooperThread': LooperThread.toString(),
    'Department_Id': Department_Id.toString(),
    'Material_Type_Id': Material_Type_Id.toString(),
    'ModelCosting_Id': ModelCosting_Id.toString(),
    'CreateDate': CreateDate.toString(),
    'LastUpdateDate': LastUpdateDate.toString(),
    'CreatedBy': CreatedBy.toString(),
    'LastUpdateBy': LastUpdateBy.toString(),
    'IsBulkType': IsBulkType.toString(),
    'BulkAdet': BulkAdet.toString(),
    'Stitch_Tool_Id': Stitch_Tool_Id.toString(),
    'Source_Id': Source_Id,
    'IsCriticalControl': IsCriticalControl.toString(),
    'Group_Name': Group_Name,
    'Machine_name': Machine_name,
    'Model_Name': Model_Name,
    'Depart_Name': Depart_Name,
    'Material_Name': Material_Name,
    'Tool_Name': Tool_Name,

  };



  //#endregion

  //#region GetWebApiUrl
  static Future<List<OperationBLL>> Get_Operation(int DeptModelOrder_QualityTest_Id) async {
    List<OperationBLL> ItemList;
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_ModelOrderOperation) +
              "?DeptModelOrder_QualityTest_Id=" +
              DeptModelOrder_QualityTest_Id.toString());

      print(SharedPref.GetWebApiUrl(WebApiMethod.Get_ModelOrderOperation) +
          "?DeptModelOrder_QualityTest_Id=" +
          DeptModelOrder_QualityTest_Id.toString());

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => OperationBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }
//#endregion



}

