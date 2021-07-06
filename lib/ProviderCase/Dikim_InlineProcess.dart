import 'package:flutter/foundation.dart';

class SubCaseProvider with ChangeNotifier {

  SubCaseProvider(){}
  ReloadAction(){
    notifyListeners();
  }

}