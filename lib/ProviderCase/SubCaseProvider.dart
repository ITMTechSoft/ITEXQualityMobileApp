import 'package:flutter/foundation.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';

class SubCaseProvider with ChangeNotifier {
  OrderSizeColorDetailsBLL? ModelOrderMatrix;
  QualityDept_ModelOrder_TrackingBLL? QualityTracking;

  /// Paramters Used for Inline Process Test
  User_QualityTracking_DetailBLL? EmployeeOperation;
  List<DeptModOrderQuality_ItemsBLL>? QualityItemList;

  Quality_ItemsBLL? FirstQuality;

  Pastal_Cutting_PartiBLL? SelectedPastal;

  SubCaseProvider() {}

  ReloadAction() {
    notifyListeners();
  }

  int? Get_SumQualityItemList() {
    int TotalError = 0;
    QualityItemList!.forEach((element) {
      TotalError += element.Amount!;
    });
    return TotalError;
  }

  int GetTotalAmount() {
    int TotalAmount = 0;
    if (EmployeeOperation != null) {
      TotalAmount += (EmployeeOperation!.Correct_Amount != null
          ? EmployeeOperation!.Correct_Amount
          : 0)!;
      TotalAmount += (EmployeeOperation!.Error_Amount != null
          ? EmployeeOperation!.Error_Amount
          : 0)!;
    }

    return TotalAmount;
  }


}
