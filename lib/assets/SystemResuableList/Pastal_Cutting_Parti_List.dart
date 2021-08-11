import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/ModelCard/Card_Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Pastal_Cutting_Parti_List extends StatefulWidget {
  List<Pastal_Cutting_PartiBLL> Items;
  Function OnClickItems;

  Pastal_Cutting_Parti_List({@required this.Items, this.OnClickItems});

  @override
  _Pastal_Cutting_Parti_ListState createState() =>
      _Pastal_Cutting_Parti_ListState();
}

class _Pastal_Cutting_Parti_ListState extends State<Pastal_Cutting_Parti_List> {
  int SelectedIndex = -1;

  Widget MainAction;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          StandardButton(
              Lable: PersonalCase.GetLable(ResourceKey.GenerateNewParti),
              ForColor: ArgonColors.white,
              BakColor: ArgonColors.primary,
              OnTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pastal_NewSample()));
              }),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return Card_Pastal_Cutting_Parti(
                        Card_Item: widget.Items[i],
                        OnTap: (Pastal_Cutting_PartiBLL Item) {
                          if(widget.OnClickItems !=null) widget.OnClickItems(Item);
                          setState(() {
                            CaseProvider.SelectedPastal = Item;

                          });
                        });
                  }))
        ]);
  }
}
