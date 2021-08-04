import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/FinalControl/SewingEmployeeControl.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class EmployeeOperationList extends StatefulWidget {
  List<User_QualityTracking_DetailBLL> Items;
  Function OnClickItems;
  PersonalProvider PersonalCase;

  EmployeeOperationList(
      {@required this.PersonalCase,
      @required this.Items,
      @required this.OnClickItems});

  @override
  _EmployeeOperationListState createState() => _EmployeeOperationListState();
}

class _EmployeeOperationListState extends State<EmployeeOperationList> {
  int SelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(children: <Widget>[
            HeaderLable(widget.PersonalCase.GetLable(ResourceKey.Operation)),
            HeaderLable(widget.PersonalCase.GetLable(ResourceKey.Operator)),
            HeaderLable(widget.PersonalCase.GetLable(ResourceKey.CreateDate)),
            HeaderLable(widget.PersonalCase.GetLable(ResourceKey.Del)),
          ]),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () async {
                        if (widget.OnClickItems != null)
                          await widget.OnClickItems(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable(widget.Items[i].Operation_Name),
                        TableLable(widget.Items[i].Inline_Employee_Name),
                        LableDateTime(widget.Items[i].Create_Date),
             

                        Container(
                        child: Center(
                          child: ButtonWithNumber(
                            text: PersonalCase.GetLable(ResourceKey.Delete),
                            textColor: Colors.white,
                            buttonWidth: ArgonSize.WidthMedium,
                            buttonHegiht: ArgonSize.WidthMedium-10,
                            btnBgColor: ArgonColors.myRed,
                            textSize: 20,
                          )
                          ),
                        )

                        /*
                        )*/
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}
