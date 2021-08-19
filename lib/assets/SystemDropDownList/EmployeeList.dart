import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Employees.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Employee_List extends StatefulWidget {
  List<EmployeesBLL> Items;
  Function(EmployeesBLL) OnClickItems;
  PersonalProvider PersonalCase;

  Employee_List(
      {
      required this.PersonalCase,
      required this.Items,
      required this.OnClickItems});

  @override
  _Employee_ListState createState() => _Employee_ListState();
}

class _Employee_ListState extends State<Employee_List> {
  final TextEditingController SearchController = new TextEditingController();
  int SelectedItem = -1;

  Widget FilterItem(Function onSearchTextChanged()) {
    return Container(
      height: ArgonSize.WidthMedium,
      child: new Card(
        shadowColor: ArgonColors.border,
        elevation: 20,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Icon(Icons.search, size: ArgonSize.IconSize),
            ),
            Expanded(
                child: TextField(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ArgonColors.Title,
                      fontSize: ArgonSize.Header4,
                      fontWeight: FontWeight.bold),
                  controller: SearchController,
                  decoration: new InputDecoration(
                      hintText:
                          widget.PersonalCase.GetLable(ResourceKey.Search),
                      border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                flex: 3),
            Expanded(
              child: IconButton(
                icon: new Icon(Icons.cancel, size: ArgonSize.IconSize),
                onPressed: () {
                  SearchController.clear();
                  onSearchTextChanged('');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FilterList() {
    var FilterListItem = widget.Items.where((r) => r.Employee_Name.toUpperCase()
        .contains(SearchController.text.toUpperCase())).toList();
    return SingleChildScrollView(
      primary: true,
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: FilterListItem.length,
          itemBuilder: (context, int i) {
            return DropDownBox(
                ItemName: FilterListItem[i].Employee_Name,
                OnTap: () {
                  widget.OnClickItems(FilterListItem[i]);
                  setState(() {
                    SelectedItem = i;
                  });
                },
                IsSelected: SelectedItem == i);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight() / 1.3,
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.only(left: 2, top: 0, right: 2, bottom: 0),
      child: Column(
        children: [
          HeaderLable(widget.PersonalCase.GetLable(ResourceKey.EmployeeList),
              fontSize: ArgonSize.Header4),
          FilterItem((String Text) {
            setState(() {});
          }),
          Container(height: getScreenHeight() / 1.3 - 100, child: FilterList()),
        ],
      ),
    );
  }
}
