import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Authenticate/LoginPages.dart';
import 'package:itex_soft_qualityapp/Screens/Home/MainActivity.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:provider/provider.dart';
import 'Preferences/SetupApplications.dart';
import 'Screens/Wrapper.dart';
import 'assets/Themes/SystemTheme.dart';

void main() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(),
        child: ITMTechSoftQuality(),
      ),
    );

class ITMTechSoftQuality extends StatefulWidget {
  @override
  _ITMTechSoftQualityState createState() => _ITMTechSoftQualityState();
}

class _ITMTechSoftQualityState extends State<ITMTechSoftQuality> {
  PersonalProvider PersonalCase = new PersonalProvider();
  SubCaseProvider CaseProvider = new SubCaseProvider();
  bool IsLoading = false;

  Future<bool> LoadingSharedPreference(PersonalProvider PersonalCase) async {
    return await PersonalCase.loadSharedPrefs();
    // IsLoading =false
    return PersonalCase.GetCurrentUser().ValidUser;
    //await PersonalCase.Login();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    Widget RetVal(bool IsSystemConfigValid) {
      Widget TargetItem;

      if (IsSystemConfigValid == false)
        TargetItem = SetupApplications();
      else
        TargetItem = Wrapper();
      return TargetItem;
    }

    return FutureBuilder(
        future: LoadingSharedPreference(PersonalCase),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: PersonalCase),
              ChangeNotifierProvider.value(value: CaseProvider)
            ],
            child: IsLoading
                ? Center(child: CircularProgressIndicator())
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: themeNotifier.GetTheme(),
                    home: RetVal(snapshot.data),
                    routes: <String, WidgetBuilder>{
                      '/login': (BuildContext context) => new LoginPages(),
                      '/main': (BuildContext context) => new MainActivity(),

                    },
                  ),
          );
        });
  }
}
