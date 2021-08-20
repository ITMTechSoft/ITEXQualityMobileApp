import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/Widgets/button.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class QualityItemsList extends StatefulWidget {
  Function ParentReCalc;
  String GroupType;
  String HeaderName;

  QualityItemsList({required this.ParentReCalc,required this.GroupType,required this.HeaderName});

  @override
  _QualityItemsListState createState() => _QualityItemsListState();
}

class _QualityItemsListState extends State<QualityItemsList> {
  int floatingNumber = 0;
  int IntiteStatus = 0;
  bool _KeepPage = false;
  bool _IsDeletedVal = false;

  Future<List<Quality_ItemsBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    List<Quality_ItemsBLL>? Critiera =
        await Quality_ItemsBLL.Get_Quality_Items_WithValue(widget.GroupType,
            PersonalCase.GetCurrentUser().Id, CaseProvider.ModelOrderMatrix!.Id);

    if (Critiera != null) {
      IntiteStatus = 1;
      return Critiera;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  List<int> selectedList = [];

  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    Future OnTapQualityItem(Quality_ItemsBLL item, index) async {
      var UserQuality = new User_QualityTracking_DetailBLL();
      UserQuality.Quality_Items_Id = item.Id;
      UserQuality.QualityDept_ModelOrder_Tracking_Id =
          CaseProvider.QualityTracking!.Id;

      if (_IsDeletedVal)
        UserQuality.Amount = -1;
      else
        UserQuality.Amount = 1;

      int CheckStatus = await UserQuality.Set_UserQualityFinalControl();
      switch (CheckStatus) {
        case 0:
          widget.ParentReCalc();
          if (_KeepPage)
            setState(() {
              selectedList.add(index);
            });
          else
            Navigator.pop(context);
          break;
        case 1:
          AlertPopupDialog(
              context,
              PersonalCase.GetLable(ResourceKey.WarrningMessage),
              PersonalCase.GetLable(ResourceKey.YouCanotExceedPlanAmount));
          break;
        case -1:
          AlertPopupDialog(
              context,
              PersonalCase.GetLable(ResourceKey.WarrningMessage),
              PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData));
          break;
      }
    }

    return Scaffold(
      appBar: DetailBar(Title:PersonalCase.SelectedTest!.Test_Name??'',PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString()??''),
          dense: true,
          selected: true,
        ),
        FutureBuilder<List<Quality_ItemsBLL>?> (
          future: LoadingOpenPage(PersonalCase, CaseProvider),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BoxMaterialCard(Childrens: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: RadioSwitch(
                          Lable: PersonalCase.GetLable(ResourceKey.KeepPageOpen),
                          fontSize: ArgonSize.Header5,
                          SwitchValue: _KeepPage,
                          OnTap: (value) {
                            setState(() {
                              _KeepPage = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: RadioSwitch(
                          Lable: PersonalCase.GetLable(ResourceKey.Delete),
                          fontSize: ArgonSize.Header5,
                          SwitchValue: _IsDeletedVal,
                          OnTap: (value) {
                            setState(() {
                              _IsDeletedVal = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:ArgonSize.Padding4),

                GridView.count(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                  shrinkWrap: true,
                  primary: false,
                  childAspectRatio:getScreenHeight() >1100?3/ 1.5 :7/ 6,
                  crossAxisCount: 3,
                  children: List.generate(snapshot.data!.length, (index) {
                    return GestureDetector(
                      onTap: () async {
                        await OnTapQualityItem(snapshot.data![index], index);
                      },
                      child: ButtonWithNumber(
                        text: snapshot.data![index].Item_Name,
                        buttonWidth: getScreenWidth()/2,
                        buttonHegiht: getScreenHeight()/6,
                        btnBgColor: selectedList.contains(index)
                            ? ArgonColors.myLightGreen
                            : ArgonColors.myOrange,
                        textSize: ArgonSize.Header4,
                        topRight: CircleShape(
                            text: (snapshot.data![index].Amount ?? 0).toString(),
                            width: ArgonSize.WidthSmall,
                            height: ArgonSize.WidthSmall,
                            fontSize: ArgonSize.Header5
                        ),
                        bottomLeft: _IsDeletedVal == true
                            ? IconInsideCircle(
                            iconSize:getScreenWidth()>1100?ArgonSize.Header6:ArgonSize.Header6,
                            size: getScreenWidth()>1000?ArgonSize.Padding6:ArgonSize.Padding6,
                            icon: FontAwesomeIcons.minus,
                            color: Colors.white,
                            backGroundColor: Colors.red)
                            : Container(width: 0, height: 0),
                      ),
                    );
                  }),
                ),
              ]);
            } else if (IntiteStatus == 0)
              return Center(child: CircularProgressIndicator());
            else
              return ErrorPage(
                  ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                  MessageError:
                      PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                  DetailError: PersonalCase.GetLable(
                      ResourceKey.InvalidNetWorkConnection));
          },
        )
      ]),
    );
  }
}
