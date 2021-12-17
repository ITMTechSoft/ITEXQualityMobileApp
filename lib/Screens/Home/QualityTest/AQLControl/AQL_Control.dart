import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/HeaderPage.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/OrderSizeColorMatrix.dart';

import 'Steps/AQL_ModelOrderMatrix.dart';
import 'Steps/AQL_SampleControl.dart';

class AQL_Control extends StatefulWidget {
  @override
  _AQL_ControlState createState() => _AQL_ControlState();
}

class _AQL_ControlState extends State<AQL_Control> {
  int IntiteStatus = 0;
  DepartmentModelOrder_QualityTestBLL? DeptModOrderQualityTest;

  List<OrderSizeColorDetailsBLL>? AQLSizeColorList;

  bool showSmall = true;

  Future<List<OrderSizeColorDetailsBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    AQLSizeColorList =
        await OrderSizeColorDetailsBLL.Get_AQLOrderSizeColorDetails(
          Order_Id :  PersonalCase.SelectedOrder!.Order_Id,
          DeptModelOrder_QualityTest_Id :PersonalCase.SelectedTest!.Id );

    if (AQLSizeColorList != null) {
      IntiteStatus = 1;
      return AQLSizeColorList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  int GetDetailTotal(String SumType ) {
    int Sum = 0;
    switch(SumType){
      case "Minor":
        AQLSizeColorList!.forEach((e) => Sum += (e.AQL_Minor ?? 0));
        break;
      case "Major":
        AQLSizeColorList!.forEach((e) => Sum += (e.AQL_Major ?? 0));
        break;
      case "Sample":
        AQLSizeColorList!.forEach((e) => Sum += (e.Sample_Amount ?? 0));
        break;
    }
    return Sum;
  }

  Widget MainInformationBox(PersonalProvider PersonalCase) => InformationBox(
      function: () {
        setState(() {});
      },
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardRow(
              PersonalCase.GetLable(ResourceKey.Customer_Name),
              PersonalCase.GetLable(ResourceKey.Model_Name),
              PersonalCase.SelectedOrder!.Customer_Name ?? '',
              PersonalCase.SelectedOrder!.Model_Name ?? '',
              LabelFex: 4),
          SizedBox(height: 8),
          CardRow(
              PersonalCase.GetLable(ResourceKey.Acceptable_Level),
              PersonalCase.GetLable(ResourceKey.Inspection_Level),
              PersonalCase.SelectedTest!.Accept_Level ?? '',
              PersonalCase.SelectedTest!.Level_Code ?? '',
              LabelFex: 4),
          SizedBox(height: 8),
          CardRow(
              PersonalCase.GetLable(ResourceKey.PlanningAmount),
              PersonalCase.GetLable(ResourceKey.AQL_Sample),
              (PersonalCase.SelectedOrder!.Quantity ?? 0).toString(),
              (PersonalCase.SelectedTest!.Sample_No ?? 0).toString(),
              LabelFex: 4),
          SizedBox(height: 8),
          CardRow(
              PersonalCase.GetLable(ResourceKey.Check_Sample),
              PersonalCase.GetLable(ResourceKey.Major),
              (GetDetailTotal("Sample")).toString(),
              (GetDetailTotal("Major") ?? 0).toString(),
              LabelFex: 4),
          SizedBox(height: 8),
        ],
      ));

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
            FutureBuilder(
              future: LoadingOpenPage(PersonalCase),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainInformationBox(PersonalCase),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ArgonSize.Padding3),
                        child: AQLModelOrderList(
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

  Widget AQLModelOrderList(
      context, PersonalCase, SubCaseProvider CaseProvider, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return AQL_OrderSizeColorMatrix(PersonalCase, snapshot.data[i],
              () async {
              CaseProvider.ModelOrderMatrix = snapshot.data[i];
            var value = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AQL_SampleControl()));
            setState(() {
              print(value);
            });
          });
        });
  }

  Widget AQL_OrderSizeColorMatrix(PersonalProvider PersonalCase,
      OrderSizeColorDetailsBLL Item, Function() OnTap) {
    Widget FinishStatus = ClipOval(
      child: Icon(
        Icons.check_circle_rounded,
        color: ArgonColors.success,
      ),
    );

    Widget PendingStatus = ClipOval(
      child: Icon(
        Icons.panorama_fish_eye_rounded,
        color: ArgonColors.warning,
      ),
    );

    Widget MainRow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CardRow(
            PersonalCase.GetLable(ResourceKey.ColorName),
            PersonalCase.GetLable(ResourceKey.SizeName),
            Item.ColorParam_StringVal ?? '',
            Item.SizeParam_StringVal ?? '',
            LabelFex: 4),
        SizedBox(height: 8),
        CardRow(
            PersonalCase.GetLable(ResourceKey.Quantity),
            PersonalCase.GetLable(ResourceKey.SizeColor_QTY),
            (Item.PlanSizeColor_QTY ?? 0).toString(),
            (Item.SizeColor_QTY ?? 0).toString(),
            LabelFex: 4),
        SizedBox(height: 8),
        CardRow(
            PersonalCase.GetLable(ResourceKey.AQL_Sample),
            PersonalCase.GetLable(ResourceKey.Check_Sample),
            (Item.AQLColorSize_Sample ?? 0).toString(),
            (Item.Sample_Amount ?? 0).toString(),
            LabelFex: 4),
        SizedBox(height: 8),
        CardRow(
            PersonalCase.GetLable(ResourceKey.Major),
            PersonalCase.GetLable(ResourceKey.Minor),
            (Item.AQL_Major ?? 0).toString(),
            (Item.AQL_Minor ?? 0).toString(),
            LabelFex: 4),
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
}
