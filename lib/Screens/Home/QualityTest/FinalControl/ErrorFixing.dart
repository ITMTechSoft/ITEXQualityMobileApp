import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/FinalControl/FinalControl.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class ErrorFixing extends StatefulWidget {
  bool _switchValue = true;

  @override
  State<ErrorFixing> createState() => _ErrorFixingState();
}

class _ErrorFixingState extends State<ErrorFixing> {
  List<String> errorList = [
    'Makine',
    'JUT',
    'LEKE',
    'Baski',
    'RENK FARKI ',
    'AKSESUAR',
    'DELIK/DEFO',
    'Makine',
    'AKSESUAR',
    'DELIK/DEFO',
    'Makine',
    'Makine'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomText(
                  text: "Tamir Hatalar",
                  size: 30,
                  textDecoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(
                    'Hatalar Tekrar Ekle',
                    style: TextStyle(
                        color: ArgonColors.myBlue, fontWeight: FontWeight.bold),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: widget._switchValue,
                      onChanged: (value) {
                        setState(() {
                          widget._switchValue = value;
                          print("Status ${widget._switchValue}");
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
          ErrorList(errorList: errorList),
          ControlButtons()
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: ArgonColors.info)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: ArgonColors.myGreen),
              ),
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: ArgonColors.myLightBlue,
                child: Icon(
                  Icons.add,
                  size: 23.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 0.7, color: ArgonColors.myGreen),
              ),
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: ArgonColors.myLightRed,
                child: Icon(
                  Icons.minimize,
                  size: 23.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  const ErrorList({
    Key key,
    @required this.errorList,
  }) : super(key: key);

  final List<String> errorList;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: ArgonColors.info),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getScreenHeight() / 2,
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(errorList.length, (index) {
                  return Center(
                    child: CustomeText(
                      text: errorList[index],
                    ),
                  );
                }),
              ),
            ),
          ],
        ));
  }
}

class CustomeText extends StatelessWidget {
  final String text;

  const CustomeText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: ArgonColors.myOrange),
      child: Center(
        child: CustomText(
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
