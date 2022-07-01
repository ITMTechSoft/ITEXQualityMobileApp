import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';
import 'User_QualityTracking_Detail.dart';

class QualityDept_ModelOrder_TrackingBLL {
  //#region Properties
  int Id = 0;
  int? Employee_Id;
  int? DeptModelOrder_QualityTest_Id;
  int? OrderSizeColorDetail_Id;
  int? Accessory_ModelOrder_Id;
  int? Plan_Daily_Production_Id;
  DateTime? StartDate;
  DateTime? EndDate;
  DateTime? ReadDate;
  DateTime? ApprovalDate;
  int? Correct_Amount;
  int? Error_Amount;
  int? Sample_Amount;
  int? QualityItem_Group_Id;
  String? Fabric_TopNo;
  int? Status;
  int? SampleNo;
  int? ModelOrderSizes_Id;
  int? Pastal_Cutting_Parti_Id;
  String? Employee_Name;
  int? QualityTest_Id;
  int? QualityDept_ModelOrder_Id;
  int? Order_Id;
  int? Size_Id;
  int? Color_Id;
  int? PlanSizeColor_QTY;
  int? OrderSizeColor_QTY;
  int? SizeColor_QTY;
  int? Accessory_Id;
  int? Quantity;
  int? Checks_Quantity;
  bool? IsSupplierAutoEmail;
  String? Group_Name;
  String? SizeName;
  String? ColorName;
  int? AQL_Major;
  int? AQL_Minor;
  String? Tracking_Note;
  String? Country_Name;
  String? Country_Code;
  int? Group_Country_Id;
  //#endregion

  QualityDept_ModelOrder_TrackingBLL() {}

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
    this.ModelOrderSizes_Id = json['ModelOrderSizes_Id'];
    this.Pastal_Cutting_Parti_Id = json['Pastal_Cutting_Parti_Id'];
    this.AQL_Major = json['AQL_Major'];
    this.AQL_Minor = json['AQL_Minor'];
    this.Tracking_Note = json['Tracking_Note'];
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
    this.Country_Name = json['Country_Name'];
    this.Group_Country_Id = json['Group_Country_Id'];
    this.Country_Code = json['Country_Code'];
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
        ModelOrderSizes_Id = json['ModelOrderSizes_Id'],
        Pastal_Cutting_Parti_Id = json['Pastal_Cutting_Parti_Id'],
        AQL_Major = json['AQL_Major'],
        AQL_Minor = json['AQL_Minor'],
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
        ColorName = json['ColorName'],
        Country_Name = json['Country_Name'],
        Country_Code = json['Country_Code'],
        Group_Country_Id = json['Group_Country_Id'],
        Tracking_Note = json['Tracking_Note'];

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
    'ModelOrderSizes_Id': ModelOrderSizes_Id,
    'Pastal_Cutting_Parti_Id': Pastal_Cutting_Parti_Id,
    'AQL_Major': AQL_Major,
    'AQL_Minor': AQL_Minor,
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
    'Country_Name': Country_Name,
    'Country_Code': Country_Code,
    'Group_Country_Id': Group_Country_Id,
    'Tracking_Note': Tracking_Note,

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
    'Fabric_TopNo': Fabric_TopNo ?? '',
    'Status': Status.toString(),
    'SampleNo': SampleNo.toString(),
    'ModelOrderSizes_Id': ModelOrderSizes_Id.toString(),
    'Pastal_Cutting_Parti_Id': Pastal_Cutting_Parti_Id.toString(),
    'AQL_Major': AQL_Major.toString(),
    'AQL_Minor': AQL_Minor.toString(),
    'Tracking_Note': Tracking_Note ?? '',
    'Employee_Name': Employee_Name ?? '',
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
    'Group_Name': Group_Name ?? '',
    'SizeName': SizeName ?? '',
    'Country_Name': Country_Name ?? '',
    'Country_Code': Country_Code ?? '',
    'Group_Country_Id': Group_Country_Id.toString(),
    'ColorName': ColorName ?? '',
  };

  //#endregion

  //#region GetWebApiUrl
  static Future<List<QualityDept_ModelOrder_TrackingBLL>?>
  Get_QualityDept_ModelOrder_Tracking(
      int Order_Id, int DeptModelOrder_QualityTest_Id) async {
    List<QualityDept_ModelOrder_TrackingBLL>? ItemList;
    try {
      Map<String, String> qParams = {
        'Order_Id': Order_Id.toString(),
        'DeptModelOrder_QualityTest_Id':
        DeptModelOrder_QualityTest_Id.toString()
      };
      var response = await http.get(SharedPref.GetWebApiUri(
          WebApiMethod.Get_Quality_ModelOrder_Tracking, Paramters: qParams));

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

  static Future<List<QualityDept_ModelOrder_TrackingBLL>?>
  GetInlineDikim_QualityDept_ModelOrder_Tracking(
      {required int Employee_Id,
        required int DeptModelOrder_QualityTest_Id,
        required DateTime SelectDate}) async {
    List<QualityDept_ModelOrder_TrackingBLL>? ItemList;
    try {
      var Tracking = new QualityDept_ModelOrder_TrackingBLL();
      Tracking.Employee_Id = Employee_Id;
      Tracking.DeptModelOrder_QualityTest_Id = DeptModelOrder_QualityTest_Id;
      Tracking.StartDate = SelectDate;

      String val = jsonEncode(Tracking.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.GetInlineDikim_QualityDept_ModelOrder_Tracking));
      var response = await http.post(url, body: val, headers: headers);

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

  static Future<List<QualityDept_ModelOrder_TrackingBLL>?>
  Get_AQLModelOrderTracking(
      {int Employee_Id = 0, int OrderSizeColorDetail_Id = 0,int DeptModelOrder_QualityTest_Id = 0}) async {
    List<QualityDept_ModelOrder_TrackingBLL>? ItemList;
    try {
      var Tracking = new QualityDept_ModelOrder_TrackingBLL();
      Tracking.DeptModelOrder_QualityTest_Id = DeptModelOrder_QualityTest_Id;
      Tracking.Employee_Id = Employee_Id;
      Tracking.OrderSizeColorDetail_Id = OrderSizeColorDetail_Id;

      String val = jsonEncode(Tracking.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Get_AQLModelOrderTracking));
      var response = await http.post(url, body: val, headers: headers);

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

      // final String url = SharedPref.GetWebApiUrl(
      //     WebApiMethod.Set_ReadQualityCriticalQualityTest);
      //
      // String val = jsonEncode(Item.toPost());
      // var response = await http.post(url,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(Item.toPost()));

      String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Set_ReadQualityCriticalQualityTest));
      var response = await http.post(url, body: val, headers: headers);

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
      // final String url = SharedPref.GetWebApiUrl(
      //     WebApiMethod.Set_CuttingOrderSizeColorDetails);
      //
      // /*  String Url= url.toString();
      // String val = jsonEncode(toPost());
      // print(Url);
      // print(val);*/
      // var response = await http.post(url,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(toPost()));

      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Set_CuttingOrderSizeColorDetails));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> RegisterTasnifAmount() async {
    try {
      // final String url =
      //     SharedPref.GetWebApiUrl(WebApiMethod.Set_TasnifOrderSizeColorDetails);
      //
      // String Url = url.toString();
      // String val = jsonEncode(toPost());
      // print(Url);
      // print(val);
      // var response = await http.post(url,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(toPost()));

      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Set_TasnifOrderSizeColorDetails));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> RegisterAccessoryAmount() async {
    try {
      String val = jsonEncode(toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_RegisterCheckAmount));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        // Item.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  static Future<QualityDept_ModelOrder_TrackingBLL?>
  GetOrCreate_QualityDept_ModelOrder_Tracking(
      int Employee_Id, int DeptModelOrder_QualityTest_Id,
      {int OrderSizeColorDetail_Id = 0,
        int ModelOrderSizes_Id = 0,
        int Pastal_Cutting_Parti_Id = 0}) async {
    try {
      var Item = new QualityDept_ModelOrder_TrackingBLL();
      Item.Employee_Id = Employee_Id;
      Item.DeptModelOrder_QualityTest_Id = DeptModelOrder_QualityTest_Id;
      Item.OrderSizeColorDetail_Id = OrderSizeColorDetail_Id;
      Item.ModelOrderSizes_Id = ModelOrderSizes_Id;
      Item.Pastal_Cutting_Parti_Id = Pastal_Cutting_Parti_Id;

      String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.GetOrCreate_QualityDept_ModelOrder_Tracking));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        Item.LoadFromJson(json.decode(response.body));
        return Item;
      }
    } catch (e) {}
    return null;
  }

  Future<QualityDept_ModelOrder_TrackingBLL?>
  Create_QualityDept_ModelOrder_Tracking() async {
    try {
      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.Create_QualityDept_ModelOrder_Tracking));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return this;
      }
    } catch (e) {}
    return null;
  }

  Future<QualityDept_ModelOrder_TrackingBLL?>
  Generate_DikimInline_Tracking() async {
    try {
      String val = jsonEncode(toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Generate_DikimInline_Tracking));
      var response = await http.post(url, body: val, headers: headers);
      print(url);
      if (response.statusCode == 200) {
        LoadFromJson(json.decode(response.body));
        return this;
      }
    } catch (e) {}
    return null;
  }

  Future<QualityDept_ModelOrder_TrackingBLL?>
  Generate_QualityModelOrder_Tracking() async {
    try {
      String val = jsonEncode(toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Generate_QualityModelOrder_Tracking));
      var response = await http.post(url, body: val, headers: headers);
      print(url);
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
        String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(SharedPref.GetWebApiUrl(
          WebApiMethod.CuttingPastal_ApproveRejectItem));
      var response = await http.post(url, body: val, headers: headers);
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

      String val = jsonEncode(Item.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.CuttingPastal_ReOpenCheckItem));
      var response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        //RetItem.LoadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> CloseTanifSample() async {
    try {
      Map<String, String> qParams = {
        'QualityDept_ModelOrder_Tracking_Id': Id.toString()
      };

      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Set_CloseTanifSample, Paramters: qParams));

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
      Map<String, String> qParams = {
        'QualityDept_ModelOrder_Tracking_Id': Id.toString()
      };

      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.CloseDikimInlineTur, Paramters: qParams));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return false;
  }

  Future<bool> UpdateEntity() async {
    try {


      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateQualityDept_ModelOrder_Tracking));
      var response = await http.post(url, body: jsonEncode(toPost()), headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {}
    return false;
  }


//#endregion

}

class ControlStatus {
  static int TansifControlOpenStatus = 1;
  static int TansifControlCloseStatus = 2;
}

enum DikimInlineStatus { Open, Closed }

class InlineOperatorStatus {
  static int Pending = 0;
  static int Success = 1;
  static int UnderCheck = 2;
  static int Invalid = 3;
}
