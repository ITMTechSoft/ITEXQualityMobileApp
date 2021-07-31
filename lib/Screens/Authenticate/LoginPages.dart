import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itex_soft_qualityapp/Preferences/SetupApplications.dart';
import 'package:itex_soft_qualityapp/Utility/Globalization.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/Input.dart';
import 'package:itex_soft_qualityapp/assets/images/ImgAssets.dart';

import '../../SystemImports.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _isLoading = false;
  var errorMsg;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController UserNameController = new TextEditingController();
  final TextEditingController PasswordController = new TextEditingController();

  // LOGIN FUNCTION
  Future<void> LoginFunction(PersonalProvider PersonalCase) async {
    // print("Login pressed");

    PersonalCase.GetCurrentUser().Employee_User = UserNameController.text;
    PersonalCase.GetCurrentUser().Employee_Password = PasswordController.text;

    await PersonalCase.Login();

    if (!PersonalCase.GetCurrentUser().ValidUser) {
      setState(() {
        errorMsg = PersonalCase.GetCurrentUser().LoginMessage;
      });
    } else {
      Navigator.popAndPushNamed(context, '/main');
    }
  }

////
  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        // exit(0);
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              PersonalCase.GetLable(ResourceKey.btn_Logins),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SetupApplications(),
                    ),
                  );
                },
                label: Text(
                  PersonalCase.GetLable(ResourceKey.Setting),


                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )
            ]),
        body: SingleChildScrollView(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100.0,
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white10,
                      child: Image.asset(
                        ImgAssets.QualityIcon,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Standard_Input(
                            suffixIcon: Icon(Icons.person),
                            controller: UserNameController,
                            placeholder:
                                PersonalCase.GetLable(ResourceKey.User_Name),
                            errorMessage: PersonalCase.GetLable(
                                ResourceKey.MandatoryFields),
                          ),
                          Standard_Input(
                            suffixIcon: Icon(Icons.lock),
                            controller: PasswordController,
                            placeholder: PersonalCase.GetLable(
                                ResourceKey.Employee_Password),
                            errorMessage: PersonalCase.GetLable(
                                ResourceKey.MandatoryFields),
                          ),
                          errorMsg == null
                              ? Container()
                              : Text(
                                  "${errorMsg}",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: ArgonSize.Header1 * 2),
                            child: CustomButton(
                              width: double.infinity,
                              height: ArgonSize.Header1*1.5,
                              value: PersonalCase.GetLable(ResourceKey.btn_Logins),
                              function: () async {
                                if (_formKey.currentState.validate()) {
                                  await LoginFunction(PersonalCase);
                                  print('working ');

                                  //   Navigator.pop(context);
                                } else
                                  print("Not Working");
                              },
                            ),
                          ),
                          // StretchableButton(
                          //   buttonColor: ArgonColors.primary,
                          //   children: [
                          //     Text(
                          //       PersonalCase.GetLable(ResourceKey.btn_Logins),
                          //       style: TextStyle(color: Colors.white),
                          //     )
                          //   ],
                          //   //  onPressed:
                          //
                          //   onPressed: () async {
                          //     if (_formKey.currentState.validate()) {
                          //       await LoginFunction(PersonalCase);
                          //       print('working ');
                          //
                          //       //   Navigator.pop(context);
                          //     } else
                          //       print("Not Working");
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
