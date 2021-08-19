import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Authenticate/LoginPages.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

MainBar(PersonalProvider PersonalCase, BuildContext context) => new AppBar(
  toolbarHeight: ArgonSize.WidthMedium,

  title: new Text(PersonalCase.GetLable(ResourceKey.Department),style: TextStyle(color: Colors.white,fontSize: ArgonSize.Header4),),
      actions: <Widget>[
        TextButton.icon(
            onPressed: () {
              PersonalCase.Logout();
              Route route =
                  MaterialPageRoute(builder: (context) => LoginPages());
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: ArgonSize.Header4
            ),
            label: Text(
              PersonalCase.GetLable(ResourceKey.LogOut),
              style: TextStyle(color: Colors.white,fontSize: ArgonSize.Header4),
            ))
      ],
    );

DetailBar({required String Title, PersonalCase,required Function() OnTap,required BuildContext context,bool showIcon=true}) => new AppBar(
    toolbarHeight: ArgonSize.WidthMedium,

  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,size:ArgonSize.Header3),
    onPressed: () => Navigator.of(context).pop(),
  ),
  title:Text(
    Title,
    style: TextStyle(fontSize: ArgonSize.Header4),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  ),
    actions: <Widget>[
showIcon==true  ?TextButton.icon(
    onPressed: OnTap,
    icon: Icon(
      Icons.close,
      color: Colors.white,
      size:ArgonSize.Header4
    ),
    label: Text(
      PersonalCase.GetLable(ResourceKey.Close),
      style: TextStyle(color: Colors.white,fontSize: ArgonSize.Header4),
    )) :
Container(),

],);// Set this height



class QualityTestBar extends StatelessWidget {
  String Title;
  Function() OnClose;

  QualityTestBar({Key? key,required String Title, required  VoidCallback OnClose}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    new AppBar(
      title: new Text(Title ),
      actions: <Widget>[
        TextButton.icon(
            onPressed: OnClose,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            label: Text(
              PersonalCase.GetLable(ResourceKey.Close),
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
