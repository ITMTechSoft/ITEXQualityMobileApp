import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class ModelOrderColorsBLL {
  // #region Properties
  late int id;
  late int? Color_Id;
  late int? orderId;
  late double? paramVal;
  late String? ColorParam_StringVal;
  late int? modelId;
  late int? quantity;
  late String? orderNumber;
  // #endregion

  ModelOrderColorsBLL({required this.id});

  // #region Json Mapping
  void loadFromJson(Map<String, dynamic> json) {
    id = json['Id'];
    Color_Id = json['Color_Id'];
    orderId = json['Order_id'];
    ColorParam_StringVal = json['ColorParam_StringVal'];
    modelId = json['Model_id'];
    quantity = json['Quantity'];
    orderNumber = json['Order_Number'];
  }

  ModelOrderColorsBLL.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        Color_Id = json['Color_Id'],
        orderId = json['Order_id'],
        ColorParam_StringVal = json['ColorParam_StringVal'],
        modelId = json['Model_id'],
        quantity = json['Quantity'],
        orderNumber = json['Order_Number'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Color_Id': Color_Id,
    'Order_id': orderId,
    'ColorParam_StringVal': ColorParam_StringVal,
    'Model_id': modelId,
    'Quantity': quantity,
    'Order_Number': orderNumber,
  };

  Map<String, String> toPost() => {
    'Id': id.toString(),
    'Color_Id': Color_Id.toString(),
    'Order_id': orderId.toString(),
    'ColorParam_StringVal': ColorParam_StringVal!,
    'Model_id': modelId.toString(),
    'Quantity': quantity.toString(),
    'Order_Number': orderNumber!,
  };
  // #endregion

  // #region GetWebApiUrl
  static Future<List<ModelOrderColorsBLL>?> getModelOrderColors(int orderId) async {
    List<ModelOrderColorsBLL>? itemList;
    try {
      Map<String, String> qParams = {'Order_Id': orderId.toString()};
      var response = await http.get(
        SharedPref.GetWebApiUri(WebApiMethod.Get_ModelOrderColors, Paramters: qParams),
      );

      if (response.statusCode == 200) {
        itemList = (json.decode(response.body) as List)
            .map((i) => ModelOrderColorsBLL.fromJson(i))
            .toList();
      }
    } catch (exception) {
      print(exception);
    }

    return itemList;
  }
// #endregion
}
