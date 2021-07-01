import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Preferences/SharedPref.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Authenticate/LoginPage.dart';
import 'package:itex_soft_qualityapp/Screens/Home/MainActivity.dart';
import 'package:provider/provider.dart';

import 'Authenticate/LoginPages.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // SharedPref sharedPref = SharedPref();
  // MTM_UsersBLL userLoad = MTM_UsersBLL();

  bool IsLoading = false;

  @override
  void initState() {
    super.initState();
    // loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);




    if (!PersonalCase.GetCurrentUser().ValidUser)
    {
      return LoginPage();
    } else {
      return MainActivity();
    }

  }
}
