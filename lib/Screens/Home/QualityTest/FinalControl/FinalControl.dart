import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import 'ErrorFixing.dart';

class FinalControl extends StatefulWidget {
  FinalControl();

  bool _switchValue = false;

  @override
  _FinalControlState createState() => _FinalControlState();
}

class _FinalControlState extends State<FinalControl> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .orientation;

    SizeConfig().init(context);
    return Scaffold(
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                    height: mediaQuery == Orientation.portrait
                        ? getScreenHeight() / 4.1
                        : getScreenWidth() / 3,
                    child: ProductDetail()),
                Container(
                  height: mediaQuery == Orientation.portrait
                      ? getScreenHeight() / 3
                      : getScreenWidth() / 3,
                  child: ProductStatus(
                    myColumn: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Text(
                              'Tekara Donen',
                              style: TextStyle(
                                  color: ArgonColors.myBlue,
                                  fontWeight: FontWeight.bold),
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
                          IconButton(
                            icon: Icon(Icons.warning_amber_sharp,
                                color: Colors.redAccent),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                          width: 300,
                          height: 70,
                          value: '1500',
                          textColor: Colors.white,
                          backGroundColor: ArgonColors.myGreen,
                          textSize: 30,
                          function: () {}),
                      SizedBox(height: 20),
                      CustomText(
                        text: "1.Kalite",
                        size: 30,
                        color: ArgonColors.myGrey,
                      ),
                    ]),
                  ),
                ),
                Container(
                  height: mediaQuery == Orientation.portrait
                      ? getScreenHeight() / 3
                      : getScreenWidth() / 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ProductStatus(
                          myColumn: Column(children: [
                            CustomText(
                              text: "2.Kalite",
                              size: 25,
                              color: ArgonColors.myGrey,
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                                width: 200,
                                height: 60,
                                value: "100",
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myRed,
                                textSize: 30,
                                function: () {}),
                            SizedBox(height: 20),
                            CustomButton(
                                width: 200,
                                height: 60,
                                value: 'Dikim',
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.Invalid,
                                textSize: 30,
                                function: () {})
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ProductStatus(
                          myColumn: Column(children: [
                            CustomText(
                              text: "Tamir",
                              size: 25,
                              color: ArgonColors.myGrey,
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                                width: 200,
                                height: 60,
                                value: '150',
                                textColor: Colors.white,
                                textSize: 30,
                                backGroundColor: ArgonColors.myYellow,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ErrorFixing()),
                                  );
                                }),
                            SizedBox(height: 20),
                            CustomButton(
                                width: 200,
                                height: 60,
                                value: 'Dikim',
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myYellow,
                                textSize: 30,
                                function: () {
                                  print('Dikim ');
                                }),
                          ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class Label extends StatelessWidget {
  @required
  final String label;
  @required
  final String value;

  const Label({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle =
    TextStyle(color: ArgonColors.myVinous, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                color: ArgonColors.myBlue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: TextStyle(
                color: ArgonColors.myVinous, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Kalite Kontrol',
                style: TextStyle(
                  fontSize: 20,
                  color: ArgonColors.text,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),

          /// TODO:SIZE SHOULD BE STANDARD
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                    'https://static.cilory.com/235901-large_default/shiva-navy-round-neck-t-shirt.jpg'),
              ),
              Expanded(
                flex: 5,
                child: Row(children: [
                  Column(
                    children: [
                      Label(label: "Customer", value: "Lacost "),
                      Label(label: "Model", value: "Model-2654"),
                      Label(label: "Plan Adet", value: "1500"),
                      Label(label: "Beden/Renk", value: "XL/ Beyaz"),
                      Label(label: "Customer", value: "Lacost"),
                    ],
                  ),
                  Column(
                    children: [
                      Label(label: "Customer", value: "Lacost"),
                      Label(label: "Customer", value: "Lacost"),
                      Label(label: "Customer", value: "Lacost"),
                      Label(label: "Customer", value: "Lacost"),
                      Label(label: "Customer", value: "Lacost"),
                    ],
                  )
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductStatus extends StatefulWidget {
  final Column myColumn;

  const ProductStatus({Key key, this.myColumn}) : super(key: key);

  @override
  State<ProductStatus> createState() => _ProductStatusState();
}

class _ProductStatusState extends State<ProductStatus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child:
        Padding(padding: const EdgeInsets.all(20), child: widget.myColumn),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.value,
    this.function,
    this.backGroundColor,
    this.width,
    this.height,
    this.textColor,
    this.textSize = 20,
  }) : super(key: key);

  final String value;

  final Function function;

  final Color backGroundColor;
  final Color textColor;
  final double width;

  final double height;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backGroundColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: function,
        child: CustomText(
          text: value,
          size: textSize,
          color: textColor,
          fontWeight: FontWeight.w800,

        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  final TextDecoration textDecoration;
  final TextAlign textAlign;

  const CustomText({Key key, this.text, this.size, this.color = ArgonColors
      .Title, this.fontWeight = FontWeight
      .bold, this.textDecoration = TextDecoration
      .none, this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,

      style: TextStyle(fontSize: size,
          color: color,
          fontWeight: fontWeight,
          decoration: textDecoration ,
      ),
    );
  }
}

AppBar MyAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text('ITM Tech Soft'),
    leading: GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.arrow_back_ios_outlined, // add custom icons also
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 20.0),
      ),
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Icon(Icons.more_vert),
        ),
      ),
    ],
  );
}
