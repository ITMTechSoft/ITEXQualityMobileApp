import 'package:flutter/foundation.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';

class SubCaseProvider with ChangeNotifier {

  OrderSizeColorDetailsBLL ModelOrderMatrix;
  QualityDept_ModelOrder_TrackingBLL QualityTracking;

  Quality_ItemsBLL FirstQuality;
  SubCaseProvider(){}
  ReloadAction(){
    notifyListeners();
  }

}