import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/Languages.dart';
import 'package:itex_soft_qualityapp/Utility/Globalization.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/Input.dart';
import 'package:itex_soft_qualityapp/assets/Resources/StaticLable.dart';

import '../SystemImports.dart';

class SetupApplications extends StatefulWidget {
  @override
  _SetupApplicationsState createState() => _SetupApplicationsState();
}

class _SetupApplicationsState extends State<SetupApplications> {
  final _formKey = GlobalKey<FormState>();

  LanguagesBLL CurrentLanguage;
  final languageList = LanguagesBLL.Get_Languages();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    /// CONTROLLERS
    TextEditingController serverIpController = new TextEditingController();
    TextEditingController portController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: new Text(
            GlobalizationBLL.Get_GlobalItem(ResourceKey.Configuration)),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Standard_Input(
                  suffixIcon: Icon(FontAwesomeIcons.server),
                  controller: serverIpController,
                  placeholder: StaticLable.ServerIp,
                  errorMessage: "Ip can't be empty ",
                  MaxLength: 15,
                  hintMessage: '192.158. 1.38',

                ),
                Standard_Input(
                  suffixIcon: Icon(FontAwesomeIcons.passport),
                  controller: portController,
                  placeholder: StaticLable.ServerPort,
                  errorMessage: "Port can't be empty ",
                    Ktype:TextInputType.number,
                    MaxLength: 4,
                  hintMessage: '3968',





                ),
                SizedBox(
                  height: 20,
                ),

                /// CHOOSE  THE LANGUAGE
                Column(
                  children: [
                    Text(
                      "Choose you language ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<LanguagesBLL>(
                      hint: Text("Select item"),
                      isExpanded: true,
                      value: CurrentLanguage,
                      isDense: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 40,
                      elevation: 40,
                      onChanged: (LanguagesBLL newValue) {
                        setState(() {
                          SharedPref.SelLanguage = CurrentLanguage = newValue;
                        });
                        // somehow set here selected 'value' above whith
                        // newValue
                        // via setState or reactive.
                      },
                      items: languageList.map((LanguagesBLL value) {
                        return DropdownMenuItem<LanguagesBLL>(
                          value: value,
                          child: Text(value.CultureName),
                        );
                      }).toList(),
                    )
                  ],
                ),


                SizedBox(
                  height: 30,
                ),
                Text(
                  SharedPref.SelLanguage.CultureName,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                StretchableButton(
                  buttonColor: ArgonColors.primary,
                  children: [
                    Text("Sign In", style: TextStyle(color: Colors.white))
                  ],
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      SharedPref.ServerIp = serverIpController.text;
                      SharedPref.ServerPort = portController.text;

                      await PersonalCase.SetupAndLogin();

                      Navigator.pop(context);
                    } else
                      print("Not Working");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
