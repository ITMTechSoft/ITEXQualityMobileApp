import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Preferences/SetupApplication.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:provider/provider.dart';
import 'Screens/Wrapper.dart';
import 'assets/Themes/SystemTheme.dart';

void main() => runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: ITMTechSoftQuality(),
    ));

class ITMTechSoftQuality extends StatefulWidget {
  @override
  _ITMTechSoftQualityState createState() => _ITMTechSoftQualityState();
}

class _ITMTechSoftQualityState extends State<ITMTechSoftQuality> {
  PersonalProvider PersonalCase = new PersonalProvider();
  bool IsLoading = false;

  Future<bool> LoadingSharedPreference(PersonalCase) async {
    await PersonalCase.loadSharedPrefs();
    /*  setState(() {
      IsLoading = false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    Widget RetVal(bool IsSystemConfigValid) {
      Widget TargetItem;
      if (IsSystemConfigValid == false)
        TargetItem = SetupApplication();
      else
        TargetItem = Wrapper();
      return TargetItem;
    }

    return FutureBuilder(
        future: LoadingSharedPreference(PersonalCase),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return ChangeNotifierProvider<PersonalProvider>(
            create: (context) => PersonalCase,
            child: IsLoading
                ? Center(child: CircularProgressIndicator())
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: themeNotifier.GetTheme(),
                    home: RetVal(snapshot.data),
                  ),
          );
        });
  }
}
