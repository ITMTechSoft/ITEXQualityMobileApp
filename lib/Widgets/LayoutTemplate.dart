import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

Widget InformationBox({required Widget MainPage,required Function() function , required IconData icon}) {

  return Stack(
    children:[
      Container(

        /// TOPP : CHANGE FIXED NUMBER
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ArgonColors.Group,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: MainPage,
      ),
      Positioned(
      bottom:0,
          right:10,

        child: IconButton(
          icon: new Icon(icon,size: ArgonSize.IconSizeMedium,color: ArgonColors.primary),
          onPressed: function,
        )),
      ]
  );
    }
Widget InformationBoxSmall({required Widget MainPage ,required double height,required Function() function,required IconData icon} ) {

  return Stack(
      children:[
        Container(
        height:height,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: ArgonColors.Group,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: MainPage,
        ),
        Positioned(

            bottom:0,
            right:10,
            child: IconButton(
              icon: new Icon(icon,size: ArgonSize.IconSizeMedium,color: ArgonColors.primary,),
              onPressed: function,
            )),
      ]
  );
}

