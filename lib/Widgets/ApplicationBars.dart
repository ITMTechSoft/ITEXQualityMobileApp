import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Authenticate/LoginPages.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';


 MainBar(PersonalProvider PersonalCase, BuildContext context)=>new AppBar(
   title: new Text(PersonalCase.GetLable(ResourceKey.Department)),
   actions: <Widget>[
     TextButton.icon(
         onPressed: () {
           PersonalCase.Logout();
           Route route = MaterialPageRoute(builder: (context) => LoginPages());
           Navigator.popAndPushNamed(context, '/login');
         },
         icon: Icon(
           Icons.person,
           color: Colors.white,
         ),
         label: Text(
           PersonalCase.GetLable(ResourceKey.LogOut),
           style: TextStyle(color: Colors.white),
         ))
   ],
 );

DetailBar(String Title,PersonalCase,Function OnTap)=>new AppBar(
  title: new Text(Title),
  actions: <Widget>[
    TextButton.icon(
        onPressed: OnTap,
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

class QualityTestBar extends StatelessWidget {
  String Title;
  Function OnClose;
  QualityTestBar({Key key,String Title, Function OnClose }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    new AppBar(
      title: new Text(Title??PersonalCase.SelectedTest.Test_Name),
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
