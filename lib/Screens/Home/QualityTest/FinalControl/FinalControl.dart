import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'DikimControl.dart';
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
    var mediaQuery = MediaQuery.of(context).orientation;

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
                child: ProductDetail(),
              ),
              Container(
                height: mediaQuery == Orientation.portrait
                    ? getScreenHeight() / 3
                    : getScreenWidth() / 3,
                child: ProductStatus(
                  myColumn: Column(children: [
                    Expanded(
                      flex: 1,
                      child: Row(
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
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleShape(text: '100'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                                height: 70,
                                value: '1500',
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myGreen,
                                textSize: 30,
                                function: () {}),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: CircleShape(text: '5005'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: CustomText(
                        text: "1.Kalite",
                        size: 30,
                        color: ArgonColors.myGrey,
                      ),
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
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: "2.Kalite",
                              size: 25,
                              color: ArgonColors.myGrey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleShape(
                                text: '70',
                                width: 30,
                                height: 30,
                                fontSize: 10),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                                width: 200,
                                height: 60,
                                value: "100",
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myRed,
                                textSize: 30,
                                function: () {}),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                                width: 200,
                                height: 60,
                                value: 'Dikim',
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.Invalid,
                                textSize: 30,
                                function: () {}),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ProductStatus(
                        myColumn: Column(children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: "Tamir",
                              size: 25,
                              color: ArgonColors.myGrey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleShape(
                                text: '100',
                                width: 30,
                                height: 30,
                                fontSize: 10),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                                width: 200,
                                height: 60,
                                value: "100",
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myYellow,
                                textSize: 30,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DikimControl()),
                                  );
                                }),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                                width: 200,
                                height: 60,
                                value: 'Dikim',
                                textColor: Colors.white,
                                backGroundColor: ArgonColors.myYellow,
                                textSize: 30,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ErrorFixing()),
                                  );
                                }),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

AppBar MyAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text('ITM Tech Soft'),
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
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
