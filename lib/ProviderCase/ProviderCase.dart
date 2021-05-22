import 'package:flutter/foundation.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/Models/Employee_Department.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/Models/Language_ResourcesKey.dart';
import 'package:itex_soft_qualityapp/Models/Languages.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDepartment_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class PersonalProvider with ChangeNotifier {
  EmployeesBLL _CurrentUser;
  Employee_DepartmentBLL SelectedDepartment;
  QualityDepartment_ModelOrderBLL SelectedOrder;
  SharedPref _UserPref;
  DepartmentModelOrder_QualityTestBLL SelectedTest;
  OrderSizeColorDetailsBLL SelectedMatrix;
  QualityDept_ModelOrder_TrackingBLL SelectedTracking;
  List<Language_ResourcesKeyBLL> GlobalKeys;
  bool IsLoading=false;

  PersonalProvider() {
    _CurrentUser = new EmployeesBLL();
    _UserPref = new SharedPref();
    if(SharedPref.SelLanguage == null)
      SharedPref.SelLanguage =new LanguagesBLL(1, "Türkçe");
  }

  EmployeesBLL GetCurrentUser() {
    return _CurrentUser;
  }

  Future<bool> loadSharedPrefs() async {
    try {
      IsLoading =true;
      bool Status = await _UserPref.initiateAppPrefernce();
      if (Status) {
        _CurrentUser.Employee_User = SharedPref.UserName;
        _CurrentUser.Employee_Password = SharedPref.UserPassword;
        await _CurrentUser.login();

        if (_CurrentUser.ValidUser) await GetGlobalization(SharedPref.SelLanguage.Id);
        IsLoading = false;
      }
      return Status;
    } catch (Excepetion) {
      print('When Try Loading loadSharedPrefs:' + Excepetion);
    }
    return false;
  }

  Login() async {
    await _CurrentUser.login();
    await GetGlobalization(SharedPref.SelLanguage.Id);
    notifyListeners();
  }

  SetupAndLogin() async {
    await SharedPref.SetupAndSave();
    _CurrentUser.Employee_User = SharedPref.UserName;
    _CurrentUser.Employee_Password = SharedPref.UserPassword;
    // await _CurrentUser.login();
    notifyListeners();
  }

  UpdateInformation() async {
    SelectedTracking = await QualityDept_ModelOrder_TrackingBLL
        .GetOrCreate_QualityDept_ModelOrder_Tracking(
            this.GetCurrentUser().Id, this.SelectedTest.Id,
            OrderSizeColorDetail_Id: this.SelectedMatrix.Id);
    notifyListeners();
  }

  void Logout() {
    _CurrentUser.Logout();
    notifyListeners();
  }

  String GetLable(ResourceKey KeyRes) {
    if(GlobalKeys !=null && GlobalKeys.length > 0) {
      var GetResournce =
      GlobalKeys.where((element) => element.ResKey == KeyRes.toShortString())
          .toList();
      if (GetResournce.length > 0)
        return GetResournce.first.ResourceValue;
    }

    return  KeyRes.toShortString();
  }

  Future<bool> GetGlobalization(int Language_Id) async {
    GlobalKeys =
        await Language_ResourcesKeyBLL.Get_Language_ResourcesKey(Language_Id);
    return true;
  }
}
