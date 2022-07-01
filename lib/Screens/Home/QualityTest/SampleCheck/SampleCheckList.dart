import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/OneItemList.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/OneItemDropList.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

import 'StartSampleCheck.dart';

class SampleCheckList extends StatefulWidget {
  @override
  _SampleCheckListState createState() => _SampleCheckListState();
}

class _SampleCheckListState extends State<SampleCheckList> {
  int IntiteStatus = 0;

  List<QualityDept_ModelOrder_TrackingBLL>? SampleTrackingList;
  List<OneItemList>? ItemsList;

  /// Loading Function
  Future<List<QualityDept_ModelOrder_TrackingBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    ///load country list from group bll table
    ItemsList = await OneItemList.GetCountryList();

    SampleTrackingList =
        await QualityDept_ModelOrder_TrackingBLL.Get_AQLModelOrderTracking(
            Employee_Id: PersonalCase.GetCurrentUser().Id,
            DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id);

    if (SampleTrackingList != null) {
      IntiteStatus = 1;
      return SampleTrackingList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  /// controller used to input data
  /// sample no at tracking table represent the KOLİ ADEDİ:
  final TextEditingController CartoonAmount = new TextEditingController();

  SelectCountry(PersonalProvider PersonalCase, BuildContext cntx,
      QualityDept_ModelOrder_TrackingBLL Item) {
    showDialog(
      context: cntx,
      builder: (cntx) => AlertDialog(
        title: Text(PersonalCase.GetLable(ResourceKey.Country)),
        content: new Column(
          children: [
            OneItemDropList(
              PersonalCase: PersonalCase,
              Items: ItemsList!,
              OnClickItems: (OneItemList SelectedItem) async {
                Item.Group_Country_Id = SelectedItem.Id;
                bool check = await  Item.UpdateEntity();
                if(check)
                  {
                    setState(() {
                      Item.Country_Name = SelectedItem.DisplayItem;
                      Item.Country_Code = SelectedItem.ItemKey;
                    });
                  }
                else
                  {
                    setState(() {
                      Item.Country_Name = "Hata Oldu";
                    });
                  }

              },
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text(PersonalCase.GetLable(ResourceKey.btn_Close)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }



  /// Header show order names and country list with number of sample
  Widget MainInformationBox(
          PersonalProvider PersonalCase, BuildContext context) =>
      InformationBox(
          function: () {
            setState(() {});
          },
          MainPage: Padding(
            padding: EdgeInsets.all(ArgonSize.Header7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: LableTitle(PersonalCase.GetLable(ResourceKey.Customer_Name),FontSize: ArgonSize.Header4)),
                    Expanded(child: LableTitle(PersonalCase.SelectedOrder!.Customer_Name ?? '',FontSize: ArgonSize.Header4,color: ArgonColors.myBlue)),

                  ],
                ),
                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            PersonalCase.GetLable(ResourceKey.CartoonAmount),
                            FontSize: ArgonSize.Header5)),
                    Expanded(
                      flex: 2,
                      child: SpinBox(
                        max: 999999,
                        textStyle: TextStyle(fontSize: ArgonSize.Header4),
                        value: (PersonalCase.SelectedTest!.Sample_No ?? 0)
                            .toDouble(),
                        onChanged: (value) {
                          PersonalCase.SelectedTest!.Sample_No = value.toInt();
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: LableTitle(PersonalCase.GetLable(ResourceKey.ControlAmount),FontSize: ArgonSize.Header5)),
                    Expanded(child: LableTitle((PersonalCase.SelectedTest!.ControlAmount ?? 0).toString(),FontSize: ArgonSize.Header4,color: ArgonColors.myBlue)),

                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      height: ArgonSize.WidthSmall1,
                      width: getScreenWidth() / 2.5,
                      textSize: ArgonSize.Header4,
                      backGroundColor: ArgonColors.myLightGreen,
                      value: PersonalCase.GetLable(ResourceKey.Save),
                      function: () async {
                        setState(() {
                          PersonalCase.SelectedTest!.CalcCheckSample();
                        });

                        bool Checks =
                            await PersonalCase.SelectedTest!.UpdateEntity();
                      },
                    )),
                    Expanded(
                        child: CustomButton(
                      height: ArgonSize.WidthSmall1,
                      width: getScreenWidth() / 2.5,
                      textSize: ArgonSize.Header4,
                      backGroundColor: ArgonColors.primary,
                      value: PersonalCase.GetLable(ResourceKey.CreateSample),
                      function: () async {
                        var Item = new QualityDept_ModelOrder_TrackingBLL();
                        Item.Employee_Id = PersonalCase.GetCurrentUser().Id;
                        Item.DeptModelOrder_QualityTest_Id =
                            PersonalCase.SelectedTest?.Id;
                        Item.SampleNo = (SampleTrackingList != null
                                ? SampleTrackingList!.length
                                : 0) +
                            1;
                        await Item.Generate_QualityModelOrder_Tracking();
                        setState(() {});
                      },
                    )),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ));

  Widget SampleList(
      context, PersonalCase, SubCaseProvider CaseProvider, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return SizeColorSampleList(PersonalCase, snapshot.data[i], () async {
            CaseProvider.QualityTracking = snapshot.data[i];
            var value = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => StartSampleCheck()));
            setState(() {
              print(value);
            });
          });
        });
  }

  Widget SizeColorSampleList(PersonalProvider PersonalCase,
      QualityDept_ModelOrder_TrackingBLL Item, Function() OnTap) {
    Widget MainRow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CardRow(
            PersonalCase.GetLable(ResourceKey.SampleNo),
            PersonalCase.GetLable(ResourceKey.CreateBy),
            (Item.SampleNo ?? '1').toString(),
            Item.Employee_Name ?? '',
            LabelFex: 4),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: LableTitle(PersonalCase.GetLable(ResourceKey.Country))),
            Expanded(
                flex: 3,
                child: LableTitle(
                    Item.Country_Name ??
                        PersonalCase.GetLable(ResourceKey.SelectItems),
                    color: ArgonColors.text,
                    IsCenter: true)),
            Expanded(
                flex: 2,
                child: IconInsideCircle(
                    iconSize: getScreenWidth() > 1100
                        ? ArgonSize.Padding6
                        : ArgonSize.Padding4,
                    size: getScreenWidth() > 1000
                        ? ArgonSize.Padding6
                        : ArgonSize.Padding4,
                    icon: FontAwesomeIcons.list,
                    color: Colors.white,
                    backGroundColor: Colors.green,
                    function: () {
                      SelectCountry(PersonalCase, context, Item);
                    })),
          ],
        ),
        SizedBox(height: 8),
      ],
    );

    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: OnTap,
          child: MainRow,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    CartoonAmount.text = PersonalCase.GetLable(ResourceKey.CartoonAmount);
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
                  color: ArgonColors.header, FontSize: ArgonSize.Header2),
              subtitle: Text(
                  PersonalCase.SelectedDepartment!.Start_Date.toString(),
                  style: TextStyle(fontSize: ArgonSize.Header6)),
              dense: true,
              selected: true,
            ),
            FutureBuilder(
              future: LoadingOpenPage(PersonalCase),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainInformationBox(PersonalCase, context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ArgonSize.Padding3),
                        child: SampleList(
                            context, PersonalCase, CaseProvider, snapshot),
                      )
                    ],
                  );
                } else if (IntiteStatus == 0)
                  return Center(child: CircularProgressIndicator());
                else
                  return ErrorPage(
                      ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                      MessageError: PersonalCase.GetLable(
                          ResourceKey.ErrorWhileLoadingData),
                      DetailError: PersonalCase.GetLable(
                          ResourceKey.InvalidNetWorkConnection));
              },
            ),
          ],
        ));
  }
}
