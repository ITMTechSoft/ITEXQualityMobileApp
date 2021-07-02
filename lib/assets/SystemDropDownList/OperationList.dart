import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Operation.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Operation_List extends StatefulWidget {
  List<OperationBLL> Items;
  Function OnClickItems;
  PersonalProvider PersonalCase;

  Operation_List({this.PersonalCase, this.Items, this.OnClickItems});

  @override
  _Operation_ListState createState() => _Operation_ListState();
}

class _Operation_ListState extends State<Operation_List> {

  final TextEditingController SearchController = new TextEditingController();

  Widget FilterItem(Function onSearchTextChanged) =>
      new Container(
        color: ArgonColors.inputSuccess,
        child: new Padding(
          padding: const EdgeInsets.all(1.0),
          child: new Card(
            child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: SearchController,
                decoration: new InputDecoration(
                    hintText: widget.PersonalCase.GetLable(ResourceKey.Search),
                    border: InputBorder.none),
                onChanged: onSearchTextChanged,
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  SearchController.clear();
                  onSearchTextChanged('');
                },
              ),
            ),
          ),
        ),
      );

  Widget FilterList() {
    var FilterEmployee = widget.Items.where((r) =>
        r.Operation_Name.toUpperCase().contains(SearchController.text.toUpperCase())).toList();
    return SingleChildScrollView(
      primary: true,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: FilterEmployee.length,
          itemBuilder: (context, int i) {
            return DropDownBox(ItemName: FilterEmployee[i].Operation_Name,
                OnTap: widget.OnClickItems(FilterEmployee[i]));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
      child: ListView(
        children: [
          HeaderLable(
              widget.PersonalCase.GetLable(ResourceKey.Operation),fontSize: 15),
          FilterItem((String Text) {
            setState(() {

            });
          }),
          FilterList()
        ],
      ),
    );
  }
}
