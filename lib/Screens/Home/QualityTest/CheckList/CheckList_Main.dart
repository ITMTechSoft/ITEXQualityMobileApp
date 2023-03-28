import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';

import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Utility/TakeImageCamera.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Cutting_CheckList extends StatefulWidget {
  @override
  State<Cutting_CheckList> createState() => _Cutting_CheckListState();
}

class _Cutting_CheckListState extends State<Cutting_CheckList> {
  int IntiteStatus = 0;
  List<DeptModOrderQuality_ItemsBLL>? ItemsList;

  Future<List<DeptModOrderQuality_ItemsBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    ItemsList =
        await DeptModOrderQuality_ItemsBLL.Get_DeptModOrderQualityTest_Items(
            PersonalCase.SelectedTest!.Id);

    if (ItemsList != null) {
      IntiteStatus = 1;
      return ItemsList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest!.Test_Name ?? '',
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
                color: ArgonColors.header, FontSize: ArgonSize.Header3),
            subtitle: Text(
                PersonalCase.SelectedDepartment!.Start_Date.toString(),
                style: TextStyle(fontSize: ArgonSize.Header6)),
            dense: true,
            selected: true,
          ),
          SizedBox(height: ArgonSize.Padding4),
          FutureBuilder<List<DeptModOrderQuality_ItemsBLL>?>(
              future: LoadingOpenPage(PersonalCase),
              builder: (context, snapshot) {
                if (snapshot.hasData && IntiteStatus == 1) {
                  return CheckList_Items(snapshot.data);
                } else
                  return LoadingContainer(IntiteStatus: IntiteStatus);
              })
        ],
      ),
    );
  }
}

class CheckList_Items extends StatefulWidget {
  List<DeptModOrderQuality_ItemsBLL>? Items;
  Function? OnClickItems;

  CheckList_Items(@required this.Items, {this.OnClickItems});

  @override
  State<CheckList_Items> createState() => _CheckList_ItemsState();
}

class _CheckList_ItemsState extends State<CheckList_Items> {

  Future<bool> CloseCheckListControl(int? DeptModelOrder_QualityTest_Id) async {
    await DepartmentModelOrder_QualityTestBLL.CloseCheckListControl(
        DeptModelOrder_QualityTest_Id);
    return true;
  }

  Future OnTapQualityItem(DeptModOrderQuality_ItemsBLL item,
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    var UserQuality = new User_QualityTracking_DetailBLL();
    UserQuality.Xaxis_QualityItem_Id = item.Id;
    UserQuality.Quality_Items_Id = item.Quality_Items_Id;
    UserQuality.DeptModelOrder_QualityTest_Id =
        item.DeptModelOrder_QualityTest_Id;
    UserQuality.Employee_Id = PersonalCase.GetCurrentUser().Id;

    if ((item.IsTakeImage ?? false)) {
      UserQuality.Image64 = await TakeImageFromCamera();
    }
    UserQuality.CheckStatus = 1;

    bool CheckStatus = await UserQuality.Set_CheckList_Items();

    if (CheckStatus)
      setState(() {
        UserQuality.CheckStatus = 1;
        CaseProvider.ReloadAction();
      });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    Widget GetMandatory(DeptModOrderQuality_ItemsBLL items) {
      if (items.IsMandatory == true || items.IsChecked == true)
        return IconInsideCircle(
            iconSize: getScreenWidth() > 1100
                ? ArgonSize.Padding2
                : ArgonSize.Padding7,
            size: getScreenWidth() > 1000
                ? ArgonSize.Padding2
                : ArgonSize.Padding7,
            icon: items.IsChecked!
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.bell,
            color: Colors.white,
            backGroundColor: items.IsChecked!
                ? ArgonColors.myLightGreen
                : ArgonColors.myLightRed);
      else
        return Container(width: 0, height: 0);
    }

    Widget GetImageButton(DeptModOrderQuality_ItemsBLL items) {
      if (items.IsTakeImage == true)
        return IconInsideCircle(
            iconSize: getScreenWidth() > 1100
                ? ArgonSize.Padding2
                : ArgonSize.Padding7,
            size: getScreenWidth() > 1000
                ? ArgonSize.Padding2
                : ArgonSize.Padding7,
            icon: FontAwesomeIcons.camera,
            color: Colors.white,
            backGroundColor: Colors.deepPurple);
      else
        return Container(width: 0, height: 0);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomButton(
            textSize: ArgonSize.Header4,
            width: getScreenWidth() * 0.5,
            height: ArgonSize.HeightSmall1,
            value: PersonalCase.GetLable(ResourceKey.CloseControl),
            backGroundColor: ArgonColors.primary,
            function: () async {
            //  await CloseCheckListControl(widget.Items?.first.DeptModelOrder_QualityTest_Id);
              Navigator.pop(context);
            }),
        ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            itemCount: widget.Items!.length,
            itemBuilder: (context, int index) {
              return ButtonWithNumber(
                  buttonWidth: getScreenWidth(),
                  textColor:
                      Color(widget.Items![index].Font_Color ?? 2315255808),
                  btnBgColor:
                      Color(widget.Items![index].Item_Hex_Color ?? -2519964),
                  textSize:
                      (widget.Items![index].Font_Size ?? ArgonSize.Header4)
                          .toDouble(),
                  text: widget.Items![index].Item_Name!,
                  topRight: GetMandatory(widget.Items![index]),
                  bottomLeft: GetImageButton(widget.Items![index]),
                  OnTap: () async {
                    await OnTapQualityItem(
                        widget.Items![index], PersonalCase, CaseProvider);
                  });
            })
      ],
    );
  }
}
