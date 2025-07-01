import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/WebApi/WebServiceApi.dart';

class QualityTest_PartsBLL {
  //#region Properties
  int Id;
  int? QualityTestsId;
  String? TestPartName;
  int? EntityOrder;
  int? ItemType;
  String? Test_Name;
  bool? IsFinish;
  //#endregion

  //#region Constructors
  QualityTest_PartsBLL({
    required this.Id,
    this.QualityTestsId,
    this.TestPartName,
    this.EntityOrder,
    this.ItemType,
    this.Test_Name,
    this.IsFinish
  });

  factory QualityTest_PartsBLL.fromJson(Map<String, dynamic> json) {
    return QualityTest_PartsBLL(
      Id: json['Id'],
      QualityTestsId: json['QualityTestsId'],
      TestPartName: json['TestPartName'],
      EntityOrder: json['EntityOrder'],
      ItemType: json['ItemType'],
      Test_Name: json['Test_Name'],
    );
  }

  void loadFromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    QualityTestsId = json['QualityTestsId'];
    TestPartName = json['TestPartName'];
    EntityOrder = json['EntityOrder'];
    ItemType = json['ItemType'];
    Test_Name = json['Test_Name'];
  }
  //#endregion

  //#region JSON Serializing
  Map<String, dynamic> toJson() => {
    'Id': Id,
    'QualityTestsId': QualityTestsId,
    'TestPartName': TestPartName,
    'EntityOrder': EntityOrder,
    'ItemType': ItemType,
    'Test_Name': Test_Name,
  };

  Map<String, String> toPost() => {
    'Id': Id.toString(),
    'QualityTestsId': QualityTestsId?.toString() ?? '',
    'TestPartName': TestPartName ?? '',
    'EntityOrder': EntityOrder?.toString() ?? '',
    'ItemType': ItemType?.toString() ?? '',
    'Test_Name': Test_Name ?? '',
  };
  //#endregion

  //#region API Methods
  static Future<List<QualityTest_PartsBLL>?> getQualityTestParts({int QualityTestsId = 0}) async {
    try {
      final qParams = {'QualityTestsId': QualityTestsId.toString()};

      final response = await http.get(
        SharedPref.GetWebApiUri(
          WebApiMethod.Get_QualityTest_Parts,
          Paramters: qParams,
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((i) => QualityTest_PartsBLL.fromJson(i)).toList();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getQualityTestParts: $e');
    }

    return null;
  }

  Future<bool> saveEntity() async {
    try {
      final val = jsonEncode(toPost());
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};

      final url = Uri.parse(SharedPref.GetWebApiUrl(WebApiMethod.Set_CreateQualityTest_Parts));
      final response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Exception in saveEntity: $e');
    }
    return false;
  }

  Future<bool> updateEntity() async {
    try {
      final val = jsonEncode(toPost());
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};

      final url = Uri.parse(SharedPref.GetWebApiUrl(WebApiMethod.Set_UpdateQualityTest_Parts));
      final response = await http.post(url, body: val, headers: headers);

      if (response.statusCode == 200) {
        loadFromJson(json.decode(response.body));
        return true;
      }
    } catch (e) {
      print('Exception in updateEntity: $e');
    }
    return false;
  }
//#endregion
}
