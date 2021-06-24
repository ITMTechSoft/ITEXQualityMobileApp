import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController UserNameController = new TextEditingController();
  final TextEditingController PasswordController = new TextEditingController();

  //#region  SetupConfig
  /// TODO : CHANGE IT'S TO CUSTOME TOOLBAR
  SetupConfig(context) => TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SetupApplication()));
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

  LoginFunction(PersonalProvider PersonalCase) => () async {
        print("Login pressed");
        setState(() {
          _isLoading = true;
        });

        PersonalCase.GetCurrentUser().Employee_User = UserNameController.text;
        PersonalCase.GetCurrentUser().Employee_Password =
            PasswordController.text;
        await PersonalCase.Login();

        setState(() {
          _isLoading = false;
        });
        if (!PersonalCase.GetCurrentUser().ValidUser) {
          errorMsg = PersonalCase.GetCurrentUser().LoginMessage;
          print(
              "The error message is: ${PersonalCase.GetCurrentUser().LoginMessage}");
        }
      };

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    UserNameController.text = SharedPref.UserName;
    PasswordController.text = SharedPref.UserPassword;

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
    return Scaffold(
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
                    prefixIcon: Icon(Icons.person),
                    controller: UserNameController,
                    placeholder: PersonalCase.GetLable(ResourceKey.User_Name),
                  ),
                  SizedBox(height: 30.0),
                  Standard_Input(
                      prefixIcon: Icon(Icons.lock),
                      controller: PasswordController,
                      placeholder:
                          PersonalCase.GetLable(ResourceKey.User_Password)),
                  SizedBox(height: 30),
                  StretchableButton(
                    buttonColor: ArgonColors.primary,
                    children: [
                      Text("Sign In", style: TextStyle(color: Colors.white))
                    ],
                    onPressed: LoginFunction(PersonalCase),
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
                ],
              ),
      ),
    );
  }
}
