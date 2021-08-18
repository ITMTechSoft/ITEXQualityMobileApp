import 'package:itex_soft_qualityapp/Models/Language_ResourcesKey.dart';


import 'ResourceKeys.dart';

class GlobalizationBLL {
  // Class Attribute
  //static ApplicationsType ITM_Application;

  static List<Language_ResourcesKeyBLL>? GlobalResList;


  static String Get_GlobalItem(ResourceKey Key) {
    try {
      if (GlobalResList != null) {
        var Item =
            GlobalResList!.where((element) => element.ResKey == Key.toString())
                .first;
        return Item.ResourceValue;
      }
      return Key.toShortString();
    } catch (Exception) {
      print(Exception);
    }

    return '';
  }

/* static boolean ReloginAgain(Context myContx){
    SharedPreferences getPrefs = PreferenceManager.getDefaultSharedPreferences(myContx);


    try {
      /// Execute Check User Connection
      ExecuteBackGround Task = new ExecuteBackGround(WebApiMethods.CheckUserConnection.toString());
      String AndriodId = Settings.Secure.getString(myContx.getContentResolver(), Settings.Secure.ANDROID_ID);
      List<NameValuePair> params = new ArrayList<NameValuePair>();
      params.add(new BasicNameValuePair("TabletCode", AndriodId));
      params.add(new BasicNameValuePair("UserName", getPrefs.getString(MenuPrefs.P_UserName, "")));
      params.add(new BasicNameValuePair("Password", getPrefs.getString(MenuPrefs.P_Password, "")));
      params.add(new BasicNameValuePair("Program", GlobalizationBLL.ITM_Application.toString()));
      boolean ExecuteResult = Task.execute(params).get();
      if (ExecuteResult == true) {
        /// Extract the Object from User Task
        User = (EmployeesBLL) Task.GetObjectType(EmployeesBLL.class);
        return true;
      }
    }catch (Exception Ex){

    }
    return  false;
  }

  // Class Set Attribute
   static void Set_GlobalList(List<Language_ResourcesKeyBLL> p_GlobalList) {GlobalList = p_GlobalList;}

  // Class Get Attribute
   static List<Language_ResourcesKeyBLL> Get_GlobalList() {return GlobalList;}

  @SuppressLint("LongLogTag")
   static String Get_GlobalItem(ResourceKey Key) {
    try {
      if (GlobalList != null)
        for(Language_ResourcesKeyBLL Item:GlobalList)
          if (Item.Get_ResKey() !=null && Item.Get_ResKey().equals(Key.toString())==true)
            return Item.Get_ResourceValue();
    } catch (Exception ex) {
    Log.d("Get Globalization Item Values:", ex.getMessage());
    }

    return null;
  }

   static String Get_GlobalItem(String Key) {
    try {
      if (GlobalList != null)
        for(Language_ResourcesKeyBLL Item:GlobalList)
          if (Item.Get_ResKey() !=null && Item.Get_ResKey().equals(Key)==true)
            return Item.Get_ResourceValue();
    } catch (Exception ex) {
    //   Log.d("Get Globalization Item Values:", ex.getMessage());
    }

    return null;
  }

   static String Get_GlobalOnlineItem(ResourceKey Key) {
    ExecuteBackGround Task = new ExecuteBackGround(WebApiMethods.GetGlobalizationLang.toString());
    try {
      String Result = GlobalizationBLL.Get_GlobalItem(Key);
      if (Result == null) {
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("ResourcesKey", Key.toString()));
        params.add(new BasicNameValuePair("Language_Id", ExecuteBackGround.Language_Id));
        boolean ExecuteResult = Task.execute(params).get();
        if (ExecuteResult == true) {
          Language_ResourcesKeyBLL item = (Language_ResourcesKeyBLL) Task.GetObjectType(Language_ResourcesKeyBLL.class);
          GlobalList.add(item);
          return item.Get_ResourceValue();
        }
      } else
        return Result;
    } catch (Exception ex) {
    // Log.d("Error Loading Global", ex.getMessage());
    }

    return Key.toString();

  }
  // Tag Column
  static   String TAG_GlobalList() {return "GlobalList";}

  // Generate Constructor
   GlobalizationBLL() {GlobalList = new ArrayList<>();}
   GlobalizationBLL(List<Language_ResourcesKeyBLL> p_GlobalList) {
    GlobalList = p_GlobalList;	}

  // //Generate Code to Transfer data by Andriod Activity

  @Override
   int describeContents() {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
   void writeToParcel(Parcel dest, int flags) {
    // TODO Auto-generated method stub
    dest.writeList(this.GlobalList);

  }

   static final Creator<GlobalizationBLL> CREATOR = new Creator<GlobalizationBLL>() {
   GlobalizationBLL createFromParcel(Parcel in) {
  return new GlobalizationBLL(in);
  }

   GlobalizationBLL[] newArray(int size) {
    return new GlobalizationBLL[size];
  }
};

 GlobalizationBLL(Parcel in) {
in.readList(GlobalList,null);

}



@Override
 void onCreate() {
  super.onCreate();
  // ExecuteBackGround Task = new ExecuteBackGround(getApplicationContext(), WebApiMethods.GetGlobalizationLang.toString());
  ITM_Application = ApplicationsType.ITM_OperationProgram;
  /*try {
            List<NameValuePair> params = new ArrayList<NameValuePair>();
            SharedPreferences getPrefs = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
            params.add(new BasicNameValuePair("Language_Id", getPrefs.getString(MenuPrefs.P_Lang, "")));
            boolean ExecuteResult =  Task.execute(params).get();
            if (ExecuteResult ==true) {
                GlobalList = (List<Language_ResourcesKeyBLL>) Task.GetListObjectType(Language_ResourcesKeyBLL[].class);
            }
        }catch (Exception ex)
        {
          //  Log.d("Error Loading Global",ex.getMessage());
        }*/
}

class RunBackGorund extends AsyncTask<Object,Void,String>{

  @Override
  protected String doInBackground(Object... objects) {
  return null;
  }
}*/

}
