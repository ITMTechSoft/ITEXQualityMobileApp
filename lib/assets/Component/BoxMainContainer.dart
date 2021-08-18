
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class BoxMainContainer extends StatelessWidget {
  var Childrens;
  BoxMainContainer({required this.Childrens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ArgonColors.Group,
        borderRadius: BorderRadius.all(
             Radius.circular(10),
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: Childrens,
      ),
    );
  }
}


class BoxMaterialCard extends StatelessWidget {
  var Childrens;
 final Widget? topRight;
 final Widget? topLeft ;
 final Widget? bottomRight;
 final Widget? bottomLeft ;
 final double paddingHorizontal ;
 final double paddingVertical ;
  BoxMaterialCard({this.Childrens, this.topRight, this.topLeft, this.bottomRight, this.bottomLeft, this.paddingHorizontal=20,this.paddingVertical=20});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shadowColor: ArgonColors.black,
          elevation: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:paddingHorizontal,vertical:paddingVertical),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: Childrens,
            ),
          ),
        ),
        topRight != null
            ? Positioned(
          child: topRight!,
          top: 5,
          right: 5,
        )
            : Container(
          width: 5,
          height: 5,
        ),
        topLeft != null
            ? Positioned(
          child: topLeft!,
          top:5,
          left: 5,
        )
            : Container(
          width: 0,
          height: 0,
        ),
        bottomLeft != null
            ? Positioned(
          child: bottomLeft!,
          bottom: 5,
          left: 5,
        )
            : Container(width: 0, height: 0),
        bottomRight != null
            ? Positioned(
          child: bottomRight!,
          bottom: 5,
          right: 5,
        )
            : Container(
          width: 5,
          height: 5,
        ),
      ],
    );
  }
}

class BoxScrollMaterialCard extends StatelessWidget {
  var Childrens;
  BoxScrollMaterialCard({this.Childrens});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: Childrens,
          ),
        ),
      ),
    );
  }
}

