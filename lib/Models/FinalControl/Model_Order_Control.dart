import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class GroupType {
  static String KalityItem    = "KITM";
  static String FirstQuality  = "FKAL";
  static String SecondQuality = "SKAL";
  static String TamirQuality  = "TKAL";
}

class Model_Order_ControlBLL {
  //#region Properties
  int    Quality_Items_Id = 0 ;
  String Control_Type;
  int? OrderSizeColorDetail_Id;
  int? Order_Id;
  int? Matrix_Control_Amount;
  int? Employee_Matrix_Amount;
  int QualityDept_ModelOrder_Tracking_Id;

  //#endregion

  Model_Order_ControlBLL(

      {
        required this.Control_Type,
         this.OrderSizeColorDetail_Id,
        required  this.QualityDept_ModelOrder_Tracking_Id}) {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Quality_Items_Id = json['Quality_Items_Id'];
    this.Control_Type = json['Control_Type'];
    this.OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'];
    this.Order_Id = json['Order_Id'];
    this.Matrix_Control_Amount  = json['Matrix_Control_Amount'];
    this.Employee_Matrix_Amount = json['Employee_Matrix_Amount'];
    this.QualityDept_ModelOrder_Tracking_Id =
        json['QualityDept_ModelOrder_Tracking_Id'];
  }

  Model_Order_ControlBLL.fromJson(Map<String, dynamic> json)
      : Quality_Items_Id = json['Quality_Items_Id'],
        Control_Type = json['Control_Type'],
        OrderSizeColorDetail_Id = json['OrderSizeColorDetail_Id'],
        Order_Id = json['Order_Id'],
        Matrix_Control_Amount = json['Matrix_Control_Amount'],
        Employee_Matrix_Amount = json['Employee_Matrix_Amount'],
        QualityDept_ModelOrder_Tracking_Id =
            json['QualityDept_ModelOrder_Tracking_Id'];

  Map<String, dynamic> toJson() => {
        'Quality_Items_Id': Quality_Items_Id,
        'Control_Type': Control_Type,
        'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id,
        'Order_Id': Order_Id,
        'Matrix_Control_Amount': Matrix_Control_Amount,
        'Employee_Matrix_Amount': Employee_Matrix_Amount,
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id,
      };

  Map<String, String> toPost() => {
        'Quality_Items_Id': Quality_Items_Id.toString(),
        'Control_Type': Control_Type,
        'OrderSizeColorDetail_Id': OrderSizeColorDetail_Id.toString(),
        'Order_Id': Order_Id.toString(),
        'Matrix_Control_Amount': Matrix_Control_Amount.toString(),
        'Employee_Matrix_Amount': Employee_Matrix_Amount.toString(),
        'QualityDept_ModelOrder_Tracking_Id':
            QualityDept_ModelOrder_Tracking_Id.toString(),
      };

  //#endregion

  //#region GetWebApiUrl
  Future<List<Model_Order_ControlBLL>?> Get_Model_Order_Control() async {
    List<Model_Order_ControlBLL>? ItemList;
    try {
      // final String url =
      //     SharedPref.GetWebApiUrl(WebApiMethod.Get_Model_Order_Control);
      //
      // var response = await http.post(url,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(toPost()));
      //
      // print(url);
      // print(jsonEncode(toPost()));


      String val = jsonEncode(this.toPost());
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse(
          SharedPref.GetWebApiUrl(WebApiMethod.Get_Model_Order_Control));
      var response = await http.post(url, body: val, headers: headers);
      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => Model_Order_ControlBLL.fromJson(i))
            .toList();
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return ItemList;
  }

/*Future<bool> Set_SecondQualityAmount() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_SecondQualityAmount);

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

  Future<bool> Set_TamirQualityAmount() async {
    try {
      final String url = SharedPref.GetWebApiUrl(
          WebApiMethod.Set_TamirQualityAmount);

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
  } */
//#endregion

}
