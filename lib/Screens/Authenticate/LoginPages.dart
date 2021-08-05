import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool obscure = true;
  IconData passwordSuffixIcon = Icons.lock;
  String name ;

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
  // void initState() {
  //   super.initState();
  //   if ( ResourceKey.btn_Logins == PersonalCase.GetLable(ResourceKey.btn_Logins))
  //   {
  //     print('${ResourceKey.btn_Logins}' '${PersonalCase.GetLable(ResourceKey.btn_Logins)}');
  //     print('Loaded');
  //   }
  //   else{
  //     print('${ResourceKey.btn_Logins} ' '${PersonalCase.GetLable(ResourceKey.btn_Logins)}');
  //
  //     print('Loadded ');
  //   }
  // }
////
  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    SizeConfig().init(context);

    if ( ResourceKey.btn_Logins == PersonalCase.GetLable(ResourceKey.btn_Logins))
        {
          print('${ResourceKey.btn_Logins}' '${PersonalCase.GetLable(ResourceKey.btn_Logins)}');
          print('not loaded');
        }
        else{
          print('${ResourceKey.btn_Logins} ' '${PersonalCase.GetLable(ResourceKey.btn_Logins)}');

          print('Loadded ');
        }

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        // exit(0);
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: ArgonSize.WidthMedium,

            title: Text(
              PersonalCase.GetLable(ResourceKey.btn_Logins),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontSize:ArgonSize.Header4),

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


                  style: TextStyle(color: Colors.white,fontSize:ArgonSize.Header4),
                ),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                    size:ArgonSize.Header3
                ),
              )
            ]),
        body: SingleChildScrollView(
          child:  Column(
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
                            suffixIcon: Icon(FontAwesomeIcons.user,size: ArgonSize.IconSize),
                            controller: UserNameController,
                            placeholder:
                                PersonalCase.GetLable(ResourceKey.User_Name),
                            errorMessage: PersonalCase.GetLable(
                                ResourceKey.MandatoryFields),
                          ),
                         Standard_Input(
                            suffixIcon: IconButton(icon: Icon(passwordSuffixIcon,size: ArgonSize.IconSize) ,onPressed:() =>
                                setState(() {
                                  obscure=!obscure;
                                  obscure==true? passwordSuffixIcon = passwordSuffixIcon = FontAwesomeIcons.eye: passwordSuffixIcon = FontAwesomeIcons.eyeSlash;

                          }),),
                            onChanged: (name){

                              setState(() {
                                if(PasswordController.text.length>0)
                                {
                                 obscure==true? passwordSuffixIcon = FontAwesomeIcons.eye: passwordSuffixIcon = FontAwesomeIcons.eyeSlash;
                                }
                                else{
                                  passwordSuffixIcon =  FontAwesomeIcons.lock;

                                }
                              });
                            },
                            controller: PasswordController,
                            placeholder: PersonalCase.GetLable(
                                ResourceKey.Employee_Password),
                            errorMessage: PersonalCase.GetLable(
                                ResourceKey.MandatoryFields),
                              obscureText:obscure,
                          ),
                          SizedBox(height: ArgonSize.Padding3),
                          _isLoading==true?  CircularProgressIndicator():Container(),

                          errorMsg == null
                              ? Container()
                              : Text(
                                  "${errorMsg}",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ArgonSize.Header4
                                  ),
                                ),

                          SizedBox(height: ArgonSize.Padding3),

                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: ArgonSize.Header1 * 2),
                            child: CustomButton(
                              width: double.infinity,
                              height: ArgonSize.Header1*1.5,
                              value: PersonalCase.GetLable(ResourceKey.btn_Logins),
                              textSize: ArgonSize.Header3,
                              function: () async {
                                if (_formKey.currentState.validate()) {
                                  await LoginFunction(PersonalCase);
                                  print('working ');
                                  setState(() {
                                    _isLoading=true;
                                  });
                                  //   Navigator.pop(context);
                                } else
                                  print("Not Working");
                                setState(() {
                                  _isLoading=false;
                                });
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
