import 'package:flutter/material.dart';
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

  void print1() {
    print("testing function");
  }

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

    return Scaffold(
      appBar: AppBar(
          title: Text(
            GlobalizationBLL.Get_GlobalItem(ResourceKey.Login),
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
                'Setting ',
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
                  Text('this is my page '),
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
                          placeholder: 'password',
                          errorMessage: "User Name can not be empty ",
                        ),
                        Standard_Input(
                          suffixIcon: Icon(Icons.lock),
                          controller: PasswordController,
                          placeholder:
                              PersonalCase.GetLable(ResourceKey.User_Password),
                          errorMessage: " Password can not be empty ",
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
                        StretchableButton(
                          buttonColor: ArgonColors.primary,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                          //  onPressed:

                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await LoginFunction(PersonalCase);
                              print1();
                              print('working ');

                              //   Navigator.pop(context);
                            } else
                              print("Not Working");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
