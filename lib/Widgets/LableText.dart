import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

/*
const double _kActiveFontSize = 14.0;
const double _LableFontSize = 12.0;
const double _kBottomMargin = 10.0;
const double _HeaderFontSize = 20.0;
*/

Text HeaderTitle(String? Title, {Color? color, double? FontSize}) {
  return Text(
    Title!,
    style: TextStyle(
      fontSize: FontSize == null ? ArgonSize.Header3 : FontSize,
      fontWeight: FontWeight.bold,
      color: color == null ? Colors.indigo : color,
    ),
  );
}

Widget LableTitle(String Title,
    {Color? color  , double? FontSize, bool IsCenter = false}) {
  if (IsCenter)
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Center(
        child: Text(
          Title != null ? Title.toUpperCase() : "",
          textAlign: IsCenter ?TextAlign.center: TextAlign.left,
          style: TextStyle(
            fontSize: FontSize == null ? ArgonSize.Header5 : FontSize,
            fontWeight: FontWeight.bold,
            color: color == null ? color : color,
          ),
        ),
      ),
    );
  else
    return Text(
      (Title ).toUpperCase(),
      style: TextStyle(
        fontSize: FontSize == null ? ArgonSize.Header5 : FontSize,
        fontWeight: FontWeight.bold,
        color: color == null ? ArgonColors.Title : color,
      ),
    );
}

Widget LableInteger(int? Value,
    {Color? color,
    double? FontSize,
    bool IsCenter = false,
    int Flex = 1}) {
  Widget TextValue(String TextVal) => new Text(
    TextVal,
    textAlign: TextAlign.right,
    style: TextStyle(
      fontSize: FontSize ?? ArgonSize.Header5,
      fontWeight: FontWeight.bold,
      color: color == null ? ArgonColors.Title : color,

    ),
  );

  Widget Child = TextValue((Value ?? 0).toString());
  if (IsCenter)
    Child = Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Center(
        child: TextValue((Value ?? 0).toString()),
      ),
    );

  return Expanded(flex: Flex, child: Child);
}

Widget LableDateTime(DateTime TargetDate,
    {String Format = "yyyy/MM/dd HH:mm",
    Color? color,
    double? FontSize,
    bool IsCenter = false}) {
  if (IsCenter)
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Center(
        child: Text(
          TargetDate != null ? DateFormat(Format).format(TargetDate) : "",
          style: TextStyle(
            fontSize: FontSize ?? ArgonSize.Header5,
            fontWeight: FontWeight.bold,
            color: color == null ? ArgonColors.Title : color,
          ),
        ),
      ),
    );
  else
    return Text(
      TargetDate != null ? DateFormat(Format).format(TargetDate) : "",
      style: TextStyle(
        fontSize: FontSize == null ? ArgonSize.Header5 :  ArgonSize.Header5,
        fontWeight: FontWeight.bold,
        color: color == null ? ArgonColors.Title : color,
      ),
    );
}

Widget HeaderLable(String LableText, {double fontSize = 12, int Flex = 1,bool IsCenter = true}) {
  return Expanded(
      flex: Flex,
      child: LableTitle(LableText, FontSize: ArgonSize.Header5, IsCenter: IsCenter));
}

Widget TableLable(String TableText, {int Flex = 1}) {
  return Expanded(
      flex: Flex,
      child: Center(
        child: LableTitle(TableText, color: ArgonColors.text),
      ));
}

Widget ExpandedLableTitle(String? Title,
    {Color? color, double? FontSize, bool IsCenter = false}) {
  if (IsCenter)
    return Expanded(
      child: Text(
        (Title ?? "").toUpperCase(),
        style: TextStyle(
          fontSize: FontSize ?? ArgonSize.Header5 ,
          fontWeight: FontWeight.bold,
          color: color == null ? ArgonColors.Title : color,
        ),
      ),
    );
  else
    return Container();
}

Widget FilterItem(
    {required context, required controller,required Function(String) onSearchTextChanged,required  PersonalCase}) =>
    new Container(
      height:ArgonSize.WidthMedium,
      alignment:Alignment.center,
      child: new Padding(
          padding:  EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
          child: new Card(
            elevation: 20,
            child: new ListTile(
              leading: new Icon(Icons.search,size:ArgonSize.IconSize),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: new TextField(
                  controller: controller,
                  ///TODO:change Hint style
                  decoration: new InputDecoration(
                      hintText: PersonalCase.GetLable(ResourceKey.Search),
                      border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel,size:ArgonSize.IconSize),
                onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },
              ),
            ),
          ),
        ),

    );


class LabelWithValue extends StatelessWidget {
  @required
  final String ?  label;
  @required
  final String? value;
  final double? fontSize;

  const LabelWithValue({Key? key, this.label, this.value, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle =
    TextStyle(color: ArgonColors.myVinous, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(
                color: ArgonColors.myVinous, fontWeight: FontWeight.bold,fontSize: fontSize),
          ),

          Text(
            value!,
            style: TextStyle(
                color: ArgonColors.myBlue, fontWeight: FontWeight.bold,fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
class LabelWithIntegerVal extends StatelessWidget {
  @required
  final String? label;
  @required
  final int? value;
  final double? fontSize ;

  const LabelWithIntegerVal({Key? key, this.label, this.value, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle =
    TextStyle(color: ArgonColors.myVinous, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(
                color: ArgonColors.myVinous, fontWeight: FontWeight.bold,fontSize:fontSize),
          ),

          Text(
            (value??0).toString(),
            style: TextStyle(
                color: ArgonColors.myBlue, fontWeight: FontWeight.bold,fontSize:fontSize),
          )
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String?  text;
  final double?  size;
  final Color ? color;
  final FontWeight? fontWeight;

  final TextDecoration textDecoration;
  final TextAlign textAlign;

  const CustomText({Key? key,
    this.text,
    this.size,
    this.color = ArgonColors.Title,
    this.fontWeight = FontWeight.bold,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}