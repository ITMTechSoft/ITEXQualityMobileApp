import 'dart:core';
import 'package:itex_soft_qualityapp/Models/Groups.dart';

class OneItemList {
  int? Id;
  String? DisplayItem;
  String? ItemKey;

  OneItemList(this.Id, this.DisplayItem, this.ItemKey);

  static Future<List<OneItemList>?> GetCountryList() async {
    List<OneItemList>? ItemList = [];

    try{
      List<GroupsBLL>? GroupList = await GroupsBLL.Get_GroupList("COUN");
      if (GroupList == null || GroupList.length == 0)
        ItemList.add(new OneItemList(0, "No Items Found", ""));
      else
        for (var grp in GroupList!)
          ItemList.add(
              new OneItemList(grp.Groups_id, grp.Group_Name, grp.Group_Code));

    }catch(e){
      String x = e.toString();

    }

    return ItemList;
  }
}
