import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:itex_soft_qualityapp/Models/DTO_RecycleSizeList.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Tasnif_Correction extends StatefulWidget {
  @override
  _Tasnif_CorrectionState createState() => _Tasnif_CorrectionState();
}

class _Tasnif_CorrectionState extends State<Tasnif_Correction> {
  int IntiteStatus = 0;

  int SelectSize_Id = 0;

  Future<List<DTO_RecycleSizeList>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<DTO_RecycleSizeList>? Criteria =
        await DTO_RecycleSizeList.Get_RecycleSizeList(
            PersonalCase.SelectedTest!.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget SizeMatrixList(List<DTO_RecycleSizeList>? Items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
      child: BoxMaterialCard(Childrens: <Widget>[
        GridView.count(
          crossAxisSpacing: 2,
          mainAxisSpacing: 3,
          shrinkWrap: true,
          primary: false,
          childAspectRatio: getScreenWidth() > 500 ? 3 / 1.7 : 7 / 6,
          crossAxisCount: 4,
          children: List.generate(Items!.length, (index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    this.SelectSize_Id = Items[index].Size_Id!;
                  });
                },
                child: ButtonWithNumber(
                  text: Items[index].SizeName!,
                  buttonWidth: ArgonSize.HeightVeryBig,
                  buttonHegiht: ArgonSize.WidthVeryBig,
                  btnBgColor: this.SelectSize_Id ==Items[index].Size_Id! ?ArgonColors.myLightRed : ArgonColors.myYellow,
                  textSize: ArgonSize.Header3,
                  topRight: CircleShape(
                      text: (Items[index].Error_Amount ?? 0).toString(),
                      width: ArgonSize.WidthSmall,
                      height: ArgonSize.WidthSmall,
                      fontSize: ArgonSize.Header5),
                  textColor: this.SelectSize_Id ==Items[index].Size_Id! ?ArgonColors.white : ArgonColors.myBlue,
                ));
          }),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest!.Test_Name ?? '',
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString(),
              style: TextStyle(fontSize: ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        SizedBox(height: ArgonSize.Padding4),
        FutureBuilder<List<DTO_RecycleSizeList>?>(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizeMatrixList(snapshot.data),
                  CorrectionList(SelectSize_Id)
                ],
              );
            } else
              return LoadingContainer(IntiteStatus: IntiteStatus);
          },
        )
      ]),
    );
  }
}

class CorrectionList extends StatefulWidget {
  int Size_Id;

  CorrectionList(this.Size_Id);

  @override
  _CorrectionListState createState() => _CorrectionListState();
}

class _CorrectionListState extends State<CorrectionList> {
  int IntiteStatus = 0;

  Future<List<User_QualityTracking_DetailBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<User_QualityTracking_DetailBLL>? Criteria =
        await User_QualityTracking_DetailBLL.Get_UserQualityTasnifControl(
            PersonalCase.SelectedTest!.Id, widget.Size_Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }


  Widget TasnifCorrectionList(
      BuildContext context,
      PersonalProvider PersonalCase,
      User_QualityTracking_DetailBLL Item,
      Function function) {
    int AssignAmount = 1;
    int recycleAmount = Item.Recycle_Amount == null ? 0 : Item.Recycle_Amount!;
    int val = Item.Error_Amount! - recycleAmount;

    Widget MainRow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: LableTitle(
                  '${PersonalCase.GetLable(ResourceKey.Employee)} ',
                )),
            Expanded(
                flex: 2,
                child: LableTitle(Item.Employee_Name.toString(),
                    color: ArgonColors.text, IsCenter: true)),
            Expanded(flex: 1, child: Container()),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: LableTitle(
                    '${PersonalCase.GetLable(ResourceKey.Xaxis_QualityItem)} / '
                    '${PersonalCase.GetLable(ResourceKey.Yaxis_QualityItem)}')),
            Expanded(
                flex: 2,
                child: LableTitle((Item.XAxis_Item_Name ?? 0).toString(),
                    color: ArgonColors.text, IsCenter: true)),
            Expanded(
                flex: 2,
                child: LableTitle((Item.YAxis_Item_Name ?? 0).toString(),
                    color: ArgonColors.text, IsCenter: true)),
          ],
        ),
        SizedBox(height: 8),
        Row(children: [
          Expanded(
              flex: 3,
              child: LableTitle(
                  '${PersonalCase.GetLable(ResourceKey.Error_Amount)} / '
                  '${PersonalCase.GetLable(ResourceKey.Recycle_Amount)}')),
          Expanded(
              flex: 2,
              child: LableTitle((Item.Error_Amount ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
          Expanded(
              flex: 2,
              child: LableTitle((Item.Recycle_Amount ?? 0).toString(),
                  color: ArgonColors.text, IsCenter: true)),
        ]),
        SizedBox(height: ArgonSize.Padding4),
        CustomButton(
            width: getScreenWidth() * 0.3,
            height: ArgonSize.WidthSmall,
            textSize: ArgonSize.Header5,
            value: PersonalCase.GetLable(ResourceKey.Recycle),
            backGroundColor: Item.Recycle_Amount != Item.Error_Amount
                ? ArgonColors.primary
                : ArgonColors.myGrey,
            function: () async {
              Item.Recycle_Amount != Item.Error_Amount
                  ? AlertPopupDialogWithAction(
                      context: context,
                      messageColor: Colors.black,
                      title: PersonalCase.GetLable(ResourceKey.Recycle_Amount),
                      Children: <Widget>[
                        SpinBox(
                          max: val.toDouble() < 1 ? 1 : val.toDouble(),
                          min: 1,
                          textStyle: TextStyle(fontSize: ArgonSize.Header3),
                          value: 1,
                          onChanged: (value) {
                            AssignAmount = value.toInt();
                          },
                        ),
                      ],
                      FirstActionLable: PersonalCase.GetLable(ResourceKey.Okay),
                      SecondActionLable:
                          PersonalCase.GetLable(ResourceKey.Cancel),
                      OnFirstAction: () async {
                        Item.Recycle_Amount = AssignAmount;
                        Item.Recycle_Employee_Id =
                            PersonalCase.GetCurrentUser().Id;
                        Item.Size_Id = widget.Size_Id;
                        bool? result =
                            await Item.Set_RecycleUserQualityTasnifControlRec(
                                Item);
                        if (result == true)
                          function();
                        else
                          print('some thing wrong');

                        Navigator.pop(context);
                      })
                  : print('equal');
            }),
      ],
    );

    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          child: MainRow,
        ),
      ),
    );
  }

  Widget GetTansifCorrectionList(
      context, PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return TasnifCorrectionList(context, PersonalCase, snapshot.data[i],
              () {
            setState(() {
              final snackBar = SnackBar(
                  content:
                      Text(PersonalCase.GetLable(ResourceKey.SaveMessage)));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Container(
      child: FutureBuilder(
        future: LoadingOpenPage(PersonalCase),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
              child: GetTansifCorrectionList(context, PersonalCase, snapshot),
            );
          } else
            return LoadingContainer(IntiteStatus: IntiteStatus);
        },
      ),
    );
  }
}
