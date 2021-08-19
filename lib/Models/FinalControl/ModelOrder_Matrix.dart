import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class ModelOrder_MatrixBLL {
  //#region Properties

  int Order_id;
  DateTime Order_DeadLine;
  String Order_Number;
  int Model_id;
  String Model_Name;
  double Analysis_Model_STD;
  int Customer_id;
  String Customer_Name;
  int OrderSizeColorDetails_Id;
  int SizeColor_QTY;
  int OrderSizeColor_QTY;
  int PlanSizeColor_QTY;
  String SizeName;
  String ColorName;
  String SizeColorNote;

  //#endregion

  ModelOrder_MatrixBLL() {}

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Order_id = json['Order_id'];
    this.Order_DeadLine = json['Order_DeadLine'] == null
        ? null
        : DateTime.parse(json['Order_DeadLine']);
    this.Order_Number = json['Order_Number'];
    this.Model_id = json['Model_id'];
    this.Model_Name = json['Model_Name'];
    this.Analysis_Model_STD = json['Analysis_Model_STD'];
    this.Customer_id = json['Customer_id'];
    this.Customer_Name = json['Customer_Name'];
    this.OrderSizeColorDetails_Id = json['OrderSizeColorDetails_Id'];
    this.SizeColor_QTY = json['SizeColor_QTY'];
    this.OrderSizeColor_QTY = json['OrderSizeColor_QTY'];
    this.PlanSizeColor_QTY = json['PlanSizeColor_QTY'];
    this.SizeName = json['SizeName'];
    this.ColorName = json['ColorName'];
    this.SizeColorNote = json['SizeColorNote'];
  }

  ModelOrder_MatrixBLL.fromJson(Map<String, dynamic> json)
      : Order_id = json['Order_id'],
        Order_DeadLine = json['Order_DeadLine'] == null
            ? null
            : DateTime.parse(json['Order_DeadLine']),
        Order_Number = json['Order_Number'],
        Model_id = json['Model_id'],
        Model_Name = json['Model_Name'],
        Analysis_Model_STD = json['Analysis_Model_STD'],
        Customer_id = json['Customer_id'],
        Customer_Name = json['Customer_Name'],
        OrderSizeColorDetails_Id = json['OrderSizeColorDetails_Id'],
        SizeColor_QTY = json['SizeColor_QTY'],
        OrderSizeColor_QTY = json['OrderSizeColor_QTY'],
        PlanSizeColor_QTY = json['PlanSizeColor_QTY'],
        SizeName = json['SizeName'],
        ColorName = json['ColorName'],
        SizeColorNote = json['SizeColorNote'];

  Map<String, dynamic> toJson() => {
    'Order_id': Order_id,
    'Order_DeadLine': Order_DeadLine,
    'Order_Number': Order_Number,
    'Model_id': Model_id,
    'Model_Name': Model_Name,
    'Analysis_Model_STD': Analysis_Model_STD,
    'Customer_id': Customer_id,
    'Customer_Name': Customer_Name,
    'OrderSizeColorDetails_Id': OrderSizeColorDetails_Id,
    'SizeColor_QTY': SizeColor_QTY,
    'OrderSizeColor_QTY': OrderSizeColor_QTY,
    'PlanSizeColor_QTY': PlanSizeColor_QTY,
    'SizeName': SizeName,
    'ColorName': ColorName,
    'SizeColorNote': SizeColorNote,
  };

  Map<String, String> toPost() => {
    'Order_id': Order_id.toString(),
    'Order_DeadLine': Order_DeadLine.toString(),
    'Order_Number': Order_Number,
    'Model_id': Model_id.toString(),
    'Model_Name': Model_Name,
    'Analysis_Model_STD': Analysis_Model_STD.toString(),
    'Customer_id': Customer_id.toString(),
    'Customer_Name': Customer_Name,
    'OrderSizeColorDetails_Id': OrderSizeColorDetails_Id.toString(),
    'SizeColor_QTY': SizeColor_QTY.toString(),
    'OrderSizeColor_QTY': OrderSizeColor_QTY.toString(),
    'PlanSizeColor_QTY': PlanSizeColor_QTY.toString(),
    'SizeName': SizeName,
    'ColorName': ColorName,
    'SizeColorNote': SizeColorNote,
  };

  //#endregion

  //#region GetWebApiUrl
  static Future<ModelOrder_MatrixBLL> Get_ModelOrder_Matrix(
      int Order_Id, int OrderSizeColorDetails_Id) async {
    List<ModelOrder_MatrixBLL> ItemList;
    try {
      Map<String, String> qParams = {
        'Order_Id': Order_Id.toString(),
        'OrderSizeColorDetails_Id': OrderSizeColorDetails_Id.toString(),
      };
      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Get_ModelOrder_Matrix, qParams));

      print(response.request);
      if (response.statusCode == 200) {
        ItemList = (json.decode(response.body) as List)
            .map((i) => ModelOrder_MatrixBLL.fromJson(i))
            .toList();
        return ItemList[0];
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return null;
  }

  Future<String> GetModelOrderImage() async {
    try {

      Map<String, String> qParams = {
        'Order_Id': Order_Id.toString(),

      };
      var response = await http.get(
          SharedPref.GetWebApiUri(WebApiMethod.Get_ModelOrder_Image,qParams));

      if (response.statusCode == 200) {
        String Image = json.decode(response.body);
        return Image;
      }
    } catch (Excpetion) {
      print(Excpetion);
    }

    return null;
  }

//#endregion

}
