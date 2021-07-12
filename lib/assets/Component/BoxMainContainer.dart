
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';

class BoxMainContainer extends StatelessWidget {
  var Childrens;
  BoxMainContainer({this.Childrens});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: Childrens,
      ),
    );
  }
}


class BoxMaterialCard extends StatelessWidget {
  var Childrens;
  BoxMaterialCard({this.Childrens});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: Childrens,
        ),
      ),
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

