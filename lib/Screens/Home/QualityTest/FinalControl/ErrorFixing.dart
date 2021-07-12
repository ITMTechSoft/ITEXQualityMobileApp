import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/FinalControl/FinalControl.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class ErrorFixing extends StatefulWidget {
  bool _switchValue = false;
  bool _activeDeleted = false;
  int clickedIndex;

  @override
  State<ErrorFixing> createState() => _ErrorFixingState();
}

class _ErrorFixingState extends State<ErrorFixing> {
  Color tileColor = ArgonColors.myOrange;
  Color textColor = Colors.black;
  int floatingNumber = 0;

  List<int> selectedList = [];

  List<String> errorList = [
    'Makine',
    'JUT',
    'LEKE',
    'Baski',
    'RENK FARKI ',
    'AKSESUAR',
    'DELIK/DEFO',
    'Makine',
  ];
  List<int> numberList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
  ];

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: MyAppBar(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: CustomText(
                  text: "Tamir Hatalar",
                  size: 30,
                  textDecoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CustomText(
                    text: 'Hatalar Tekrar Ekle',
                    color: ArgonColors.myBlue,
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
                Row(children: [
                  CustomText(
                    text: 'Silmek',
                    color: ArgonColors.myBlue,
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: widget._activeDeleted,
                      onChanged: (value) {
                        setState(() {
                          widget._activeDeleted = value;
                          print("Status ${widget._activeDeleted}");
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: ArgonColors.myBlue, width: 0.1),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white70),
            child: GridView.count(
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 3,
              children: List.generate(errorList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    print('the index is $index');
                    setState(() {
                      widget.clickedIndex = index;
                      selectedList.add(index);

                      floatingNumber = numberList[index];
                      floatingNumber = floatingNumber + 1;
                      //numberList.insert(index, floatingNumber);
                     // numberList[index] = floatingNumber;
                    });
                  },
                  child: ButtonWithNumber(
                      text: errorList[index],
                      number: numberList[index],
                      buttonWidth: getScreenWidth() / 3,
                      buttonHegiht: 120,
                      btnBgColor: selectedList.contains(index)
                          ? ArgonColors.myLightGreen
                          : ArgonColors.myOrange,
                      circleBgColor: ArgonColors.myBlue2,
                      textSize: 15,
                      anotherBubble: widget._activeDeleted),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
