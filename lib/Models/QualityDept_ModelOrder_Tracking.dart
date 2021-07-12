import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';
import 'User_QualityTracking_Detail.dart';


class QualityDept_ModelOrder_TrackingBLL {
  //#region Properties
  int Id;
  int Employee_Id;
  int DeptModelOrder_QualityTest_Id;
  int OrderSizeColorDetail_Id;
  int Accessory_ModelOrder_Id;
  int Plan_Daily_Production_Id;
  DateTime StartDate;
  DateTime EndDate;
  DateTime ReadDate;
  DateTime ApprovalDate;
  int Correct_Amount;
  int Error_Amount;
  int Sample_Amount;
  int QualityItem_Group_Id;
  String Fabric_TopNo;
  int Status;
  int SampleNo;
  String Employee_Name;
  int QualityTest_Id;
  int QualityDept_ModelOrder_Id;
  int Order_Id;
  int Size_Id;
  int Color_Id;
  int PlanSizeColor_QTY;
  int OrderSizeColor_QTY;
  int SizeColor_QTY;
  int Accessory_Id;
  int Quantity;
  int Checks_Quantity;
  bool IsSupplierAutoEmail;
  String Group_Name;
  String SizeName;
  String ColorName;

  //#endregion

  QualityDept_ModelOrder_TrackingBLL() {
    this.Id = 0;
  }

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.Employee_Id = json['Employee_Id'];
    this.DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'];
    this.OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'];
    this.Accessory_ModelOrder_Id = json['Accessory_ModelOrder_Id'];
    this.Plan_Daily_Production_Id = json['Plan_Daily_Production_Id'];
    this.StartDate =
        json['StartDate'] == null ? null : DateTime.parse(json['StartDate']);
    this.EndDate =
        json['EndDate'] == null ? null : DateTime.parse(json['EndDate']);
    this.ReadDate =
        json['ReadDate'] == null ? null : DateTime.parse(json['ReadDate']);
    this.ApprovalDate = json['ApprovalDate'] == null
        ? null
        : DateTime.parse(json['ApprovalDate']);
    this.Correct_Amount = json['Correct_Amount'];
    this.Error_Amount = json['Error_Amount'];
    this.Sample_Amount = json['Sample_Amount'];
    this.QualityItem_Group_Id = json['QualityItem_Group_Id'];
    this.Fabric_TopNo = json['Fabric_TopNo'];
    this.Status = json['Status'];
    this.SampleNo = json['SampleNo'];
    this.Employee_Name = json['Employee_Name'];
    this.QualityTest_Id = json['QualityTest_Id'];
    this.QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'];
    this.Order_Id = json['Order_Id'];
    this.Size_Id = json['Size_Id'];
    this.Color_Id = json['Color_Id'];
    this.PlanSizeColor_QTY = json['PlanSizeColor_QTY'];
    this.OrderSizeColor_QTY = json['OrderSizeColor_QTY'];
    this.SizeColor_QTY = json['SizeColor_QTY'];
    this.Accessory_Id = json['Accessory_Id'];
    this.Quantity = json['Quantity'];
    this.Checks_Quantity = json['Checks_Quantity'];
    this.IsSupplierAutoEmail = json['IsSupplierAutoEmail'];
    this.Group_Name = json['Group_Name'];
    this.SizeName = json['SizeName'];
    this.ColorName = json['ColorName'];
  }

  QualityDept_ModelOrder_TrackingBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Employee_Id = json['Employee_Id'],
        DeptModelOrder_QualityTest_Id = json['DeptModelOrder_QualityTest_Id'],
        OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'],
        Accessory_ModelOrder_Id = json['Accessory_ModelOrder_Id'],
        Plan_Daily_Production_Id = json['Plan_Daily_Production_Id'],
        StartDate = json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        EndDate =
            json['EndDate'] == null ? null : DateTime.parse(json['EndDate']),
        ReadDate =
            json['ReadDate'] == null ? null : DateTime.parse(json['ReadDate']),
        ApprovalDate = json['ApprovalDate'] == null
            ? null
            : DateTime.parse(json['ApprovalDate']),
        Correct_Amount = json['Correct_Amount'],
        Error_Amount = json['Error_Amount'],
        Sample_Amount = json['Sample_Amount'],
        QualityItem_Group_Id = json['QualityItem_Group_Id'],
        Fabric_TopNo = json['Fabric_TopNo'],
        Status = json['Status'],
        SampleNo = json['SampleNo'],
        Employee_Name = json['Employee_Name'],
        QualityTest_Id = json['QualityTest_Id'],
        QualityDept_ModelOrder_Id = json['QualityDept_ModelOrder_Id'],
        Order_Id = json['Order_Id'],
        Size_Id = json['Size_Id'],
        Color_Id = json['Color_Id'],
        PlanSizeColor_QTY = json['PlanSizeColor_QTY'],
        OrderSizeColor_QTY = json['OrderSizeColor_QTY'],
        SizeColor_QTY = json['SizeColor_QTY'],
        Accessory_Id = json['Accessory_Id'],
        Quantity = json['Quantity'],
        Checks_Quantity = json['Checks_Quantity'],
        IsSupplierAutoEmail = json['IsSupplierAutoEmail'],
        Group_Name = json['Group_Name'],
        SizeName = json['SizeName'],
        ColorName = json['ColorName'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Employee_Id': Employee_Id,
        'DeptModelOrder_QualityTest_Id': DeptModelOrder_QualityTest_Id,
        'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id,
        'Accessory_ModelOrder_Id': Accessory_ModelOrder_Id,
        'Plan_Daily_Production_Id': Plan_Daily_Production_Id,
        'StartDate': StartDate,
        'EndDate': EndDate,
        'ReadDate': ReadDate,
        'ApprovalDate': ApprovalDate,
        'Correct_Amount': Correct_Amount,
        'Error_Amount': Error_Amount,
        'Sample_Amount': Sample_Amount,
        'QualityItem_Group_Id': QualityItem_Group_Id,
        'Fabric_TopNo': Fabric_TopNo,
        'Status': Status,
        'SampleNo': SampleNo,
        'Employee_Name': Employee_Name,
        'QualityTest_Id': QualityTest_Id,
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id,
        'Order_Id': Order_Id,
        'Size_Id': Size_Id,
        'Color_Id': Color_Id,
        'PlanSizeColor_QTY': PlanSizeColor_QTY,
        'OrderSizeColor_QTY': OrderSizeColor_QTY,
        'SizeColor_QTY': SizeColor_QTY,
        'Accessory_Id': Accessory_Id,
        'Quantity': Quantity,
        'Checks_Quantity': Checks_Quantity,
        'IsSupplierAutoEmail': IsSupplierAutoEmail,
        'Group_Name': Group_Name,
        'SizeName': SizeName,
        'ColorName': ColorName,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'Employee_Id': Employee_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
            DeptModelOrder_QualityTest_Id.toString(),
        'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id.toString(),
        'Accessory_ModelOrder_Id': Accessory_ModelOrder_Id.toString(),
        'Plan_Daily_Production_Id': Plan_Daily_Production_Id.toString(),
        'StartDate': StartDate.toString(),
        'EndDate': EndDate.toString(),
        'ReadDate': ReadDate.toString(),
        'ApprovalDate': ApprovalDate.toString(),
        'Correct_Amount': Correct_Amount.toString(),
        'Error_Amount': Error_Amount.toString(),
        'Sample_Amount': Sample_Amount.toString(),
        'QualityItem_Group_Id': QualityItem_Group_Id.toString(),
        'Fabric_TopNo': Fabric_TopNo,
        'Status': Status.toString(),
        'SampleNo': SampleNo.toString(),
        'Employee_Name': Employee_Name,
        'QualityTest_Id': QualityTest_Id.toString(),
        'QualityDept_ModelOrder_Id': QualityDept_ModelOrder_Id.toString(),
        'Order_Id': Order_Id.toString(),
        'Size_Id': Size_Id.toString(),
        'Color_Id': Color_Id.toString(),
        'PlanSizeColor_QTY': PlanSizeColor_QTY.toString(),
        'OrderSizeColor_QTY': OrderSizeColor_QTY.toString(),
        'SizeColor_QTY': SizeColor_QTY.toString(),
        'Accessory_Id': Accessory_Id.toString(),
        'Quantity': Quantity.toString(),
        'Checks_Quantity': Checks_Quantity.toString(),
        'IsSupplierAutoEmail': IsSupplierAutoEmail.toString(),
        'Group_Name': Group_Name,
        'SizeName': SizeName,
        'ColorName': ColorName,
      };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<QualityDept_ModelOrder_TrackingBLL>>
      Get_QualityDept_ModelOrder_Tracking(
          int Order_Id, int DeptModelOrder_QualityTest_Id) async {
    List<QualityDept_ModelOrder_TrackingBLL> ItemList;
    try {
      var response = await http.get(SharedPref.GetWebApiUrl(
              WebApiMethod.Get_Quality_ModelOrder_Tracking) +
          "?Order_Id=" +
          Order_Id.toString() +
          "&DeptModelOrder_QualityTest_Id=" +
          DeptModelOrder_QualityTest_Id.toString());

     // print(response.request);
      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => QualityDept_ModelOrder_TrackingBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  static Future<List<QualityDept_ModelOrder_TrackingBLL>>
  GetInlineDikim_QualityDept_ModelOrder_Tracking(
      {int Employee_Id, int DeptModelOrder_QualityTest_Id,DateTime SelectDate}) async {
    List<QualityDept_ModelOrder_TrackingBLL> ItemList;
    try {
      var Tracking = new QualityDept_ModelOrder_TrackingBLL();
      Tracking.Employee_Id = Employee_Id;
      Tracking.DeptModelOrder_QualityTest_Id = DeptModelOrder_QualityTest_Id;
      Tracking.StartDate = SelectDate;

      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.GetInlineDikim_QualityDept_ModelOrder_Tracking);

      print(url);
      print(jsonEncode(Tracking.toPost()));
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Tracking.toPost()));

      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => QualityDept_ModelOrder_TrackingBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

  Future<bool> SetReadValidationAction() async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = this.Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = this.DeptModelOrder_QualityTest_Id;

      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_ReadQualityCriticalQualityTest);

      String val = jsonEncode(Item.toPost());
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        if (Item.Id != 0) return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> RegisterCuttingAmount() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_CuttingOrderSizeColorDetails);

      /*  String Url= url.toString();
      String val = jsonEncode(toPost());
      print(Url);
      print(val);*/
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

  Future<bool> RegisterTasnifAmount() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_TasnifOrderSizeColorDetails);

      String Url= url.toString();
      String val = jsonEncode(toPost());
      print(Url);
      print(val);
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

  Future<bool> RegisterAccessoryAmount() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_RegisterCheckAmount);

      String Url= url.toString();
      String val = jsonEncode(toPost());
      print(Url);
      print(val);
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

  static Future<QualityDept_ModelOrder_TrackingBLL>
      GetOrCreate_QualityDept_ModelOrder_Tracking(
          int Employee_Id, int DeptModelOrder_QualityTest_Id,
          {int OrderSizeColorDetail_Id = 0}) async {
    var Item = new QualityDept_ModelOrder_TrackingBLL();
    Item.Employee_Id = Employee_Id;
    Item.DeptModelOrder_QualityTest_Id = DeptModelOrder_QualityTest_Id;
    Item.OrderSizeColorDetail_Id = OrderSizeColorDetail_Id;

    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.GetOrCreate_QualityDept_ModelOrder_Tracking);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

  //    String Val = jsonEncode(Item.toPost());
    //  print(Val);

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        return Item;
      }
    } catch (e) {}
    return null;
  }



  Future<QualityDept_ModelOrder_TrackingBLL>
      Create_QualityDept_ModelOrder_Tracking() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Create_QualityDept_ModelOrder_Tracking);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));

     // String Val = jsonEncode(toPost());
     // print(Val);

      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return this;
      }
    } catch (e) {}
    return null;
  }

  Future<QualityDept_ModelOrder_TrackingBLL>
  Generate_DikimInline_Tracking() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Generate_DikimInline_Tracking);

      String Val = jsonEncode(toPost());
      print(Val);
      print(url);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(toPost()));



      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return this;
      }
    } catch (e) {}
    return null;
  }

  static Future<bool> CuttingPastal_ApproveRejectItem(
      User_QualityTracking_DetailBLL Item) async {
    try {
      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.CuttingPastal_ApproveRejectItem);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

      // String Val = jsonEncode(Item.toPost());
      // print(Val);

      //   var RetItem = new DeptModOrderQuality_ItemsBLL();

      if (response.statusCode == 200) {
        //RetItem.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  static Future<bool> CuttingPastal_ReOpenCheckItem(
      User_QualityTracking_DetailBLL Item) async {
    try {
      final String url =
          SharedPref.GetWebApiUrl(WebApiMethod.CuttingPastal_ReOpenCheckItem);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(Item.toPost()));

      // String Val = jsonEncode(Item.toPost());
      // print(url);

      //   var RetItem = new DeptModOrderQuality_ItemsBLL();

      if (response.statusCode == 200) {
        //RetItem.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> CloseTanifSample() async {
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_CloseTanifSample) +
              "?QualityDept_ModelOrder_Tracking_Id=" +
              Id.toString());

      if (response.statusCode == 200) {
        return true;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return false;
  }

  Future<bool> CloseDikimInlineTur() async {
    try {
      var response = await http.get(
          SharedPref.GetWebApiUrl(WebApiMethod.CloseDikimInlineTur) +
              "?QualityDept_ModelOrder_Tracking_Id=" +
              Id.toString());

      if (response.statusCode == 200) {
        return true;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return false;
  }
//#endregion

}

class ControlStatus {
  static int TansifControlOpenStatus = 1;
  static int TansifControlCloseStatus = 2;
}

enum DikimInlineStatus{
  Open ,
  Closed
}

class InlineOperatorStatus {
  static int Pending = 0;
  static int Success = 1;
  static int UnderCheck = 2;
  static int Invalid = 3;

}

