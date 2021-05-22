import 'package:flutter/material.dart';

class SelectList extends StatelessWidget {
  List<Widget> ListItems =<Widget>[];
  bool IsOpenFilter;
  double padding;
  double margin;

  SelectList(
      {@required this.ListItems,
      this.IsOpenFilter=false,
      this.margin = 5,
      this.padding = 5});

  FilterItem()=>Column(
    children: [


    ],
  );

  @override
  Widget build(BuildContext context) {

    if(IsOpenFilter)
      this.ListItems.insert(0, FilterItem());
    if(ListItems ==null)
      ListItems.add(Text("No Data"));
    return Container(
        padding: EdgeInsets.all(this.padding),
        margin: EdgeInsets.all(this.margin),
        child: ListView(
          children: ListItems,
        ));
  }
}


