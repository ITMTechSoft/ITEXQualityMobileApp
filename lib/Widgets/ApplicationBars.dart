import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';


 MainBar(PersonalProvider PersonalCase)=>new AppBar(
   title: new Text(PersonalCase.GetLable(ResourceKey.Department)),
   actions: <Widget>[
     TextButton.icon(
         onPressed: () {
           PersonalCase.Logout();
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