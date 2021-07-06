import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itex_soft_qualityapp/Preferences/SetupApplications.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  var errorMsg;

  /// CONTROLLERS
  TextEditingController UserNameController =
      new TextEditingController(text: SharedPref.UserName);
  TextEditingController PasswordController =
      new TextEditingController(text: SharedPref.UserPassword);

  //#region  SetupConfig
  SetupConfig(context) => TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SetupApplications()));
        },
        label: Text(
          'Setting ',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      );

  //#endregion SetupConfig

  // LOGIN FUNCTION
  LoginFunction(PersonalProvider PersonalCase) => () async {
        print("Login pressed");


        PersonalCase.GetCurrentUser().Employee_User = UserNameController.text;
        PersonalCase.GetCurrentUser().Employee_Password =
            PasswordController.text;

        await PersonalCase.Login();


        if (!PersonalCase.GetCurrentUser().ValidUser) {
          setState(() {
            errorMsg = PersonalCase.GetCurrentUser().LoginMessage;
          });


        }
        else {

          Navigator.popAndPushNamed(context, '/main');
        }



      };

  @override
  initStat() {
    ///TODO : HERE AT THE FIRST TIME IT WILL BE NULL
    UserNameController.text = SharedPref.UserName;
    PasswordController.text = SharedPref.UserPassword;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    //#region  Form Components

    /// TODO: PUT THIS IN ANOTHER COMPONENTS
    Widget HeaderIcon = CircleAvatar(
      radius: 100.0,
      foregroundColor: Colors.red,
      backgroundColor: Colors.white10,
      child: Image.asset(
        ImgAssets.QualityIcon,
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );

    //#endregion

    return WillPopScope(
      onWillPop:  () {
        SystemNavigator.pop();
       // exit(0);
        return Future.value(false); // if true allow back else block it
      },

      child: Scaffold(
        appBar: new AppBar(
          title: Text(
            GlobalizationBLL.Get_GlobalItem(ResourceKey.Login),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[SetupConfig(context)],
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    HeaderIcon,
                    SizedBox(height: 30.0),
                    Standard_Input(
                      suffixIcon: Icon(Icons.person),
                      controller: UserNameController,
                      placeholder: PersonalCase.GetLable(ResourceKey.User_Name),
                      errorMessage: "User Name can not be empty ",
                    ),
                    SizedBox(height: 20.0),
                    Standard_Input(
                      suffixIcon: Icon(Icons.lock),
                      controller: PasswordController,
                      placeholder:
                          PersonalCase.GetLable(ResourceKey.User_Password),
                    ),
                    SizedBox(height: 20),
                    errorMsg == null
                        ? Container()
                        : Text(
                            errorMsg,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    StretchableButton(
                      buttonColor: ArgonColors.primary,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      onPressed: LoginFunction(PersonalCase),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
