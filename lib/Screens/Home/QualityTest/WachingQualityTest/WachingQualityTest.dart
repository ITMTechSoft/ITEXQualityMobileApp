import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderColors.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderSizes.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/WachingSampleList.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';

import '../../../../Utility/SelectableItemList.dart';

class WachingQualityTest extends StatefulWidget {
  const WachingQualityTest({super.key});

  @override
  State<WachingQualityTest> createState() => _WachingQualityTestState();
}

class _WachingQualityTestState extends State<WachingQualityTest> {
  int IntiteStatus = 0;
  List<OrderSizeColorDetailsBLL>? AQLSizeColorList;

  @override
  void initState() {
    super.initState();
    AQLOrderSizeColorDetails();
  }

  Future<void> AQLOrderSizeColorDetails() async {
    final personalCase = Provider.of<PersonalProvider>(context, listen: false);
    AQLSizeColorList =
        await OrderSizeColorDetailsBLL.Get_AQLOrderSizeColorDetails(
          Order_Id: personalCase.SelectedOrder!.Order_Id,
          DeptModelOrder_QualityTest_Id: personalCase.SelectedTest!.Id,
        );
  }

  List<ModelOrderSizesBLL>? SizeList;
  ModelOrderSizesBLL? SelSize;

  Future<List<ModelOrderSizesBLL>?> LoadingSizeList(
    PersonalProvider PersonalCase,
  ) async {
    List<ModelOrderSizesBLL>? Criteria =
        await ModelOrderSizesBLL.Get_ModelOrderSizes(
          PersonalCase.SelectedTest!.Order_Id!,
        );

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  List<ModelOrderColorsBLL>? ColorList;
  ModelOrderColorsBLL? SelColor;

  Future<List<ModelOrderColorsBLL>?> LoadingColorList(
    PersonalProvider PersonalCase,
  ) async {
    List<ModelOrderColorsBLL>? Criteria =
        await ModelOrderColorsBLL.getModelOrderColors(
          PersonalCase.SelectedTest!.Order_Id!,
        );

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget MainInformationBox(PersonalProvider PersonalCase) {
    final totalSampleAmount =
        AQLSizeColorList?.fold<int>(
          0,
          (sum, item) => sum + (item.Sample_Amount ?? 0),
        ) ??
        0;

    return InformationBox(
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
            LabelFex: 4,
          ),
          SizedBox(height: 8),
          CardRow(
            PersonalCase.GetLable(ResourceKey.PlanningAmount),
            PersonalCase.GetLable(ResourceKey.Check_Sample),
            (PersonalCase.SelectedOrder!.Quantity ?? 0).toString(),
            totalSampleAmount.toString(),
            LabelFex: 4,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget AQLModelOrderList(
    context,
    PersonalCase,
    SubCaseProvider CaseProvider,
    snapshot,
  ) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data.length,
      itemBuilder: (context, int i) {
        return AQL_OrderSizeColorMatrix(
          PersonalCase,
          snapshot.data[i],
          () async {
            CaseProvider.ModelOrderMatrix = snapshot.data[i];
            var value = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WachingSampleList()),
            );
            setState(() {
              print(value);
            });
          },
        );
      },
    );
  }



  Widget GetSelectedMatrix(PersonalProvider personalCase, SubCaseProvider caseProvider) {
    if (SelColor == null || SelSize == null || AQLSizeColorList == null) {
      return const SizedBox(); // Nothing to render
    }
    final item = AQLSizeColorList!.firstWhere(
          (element) =>
      element.Color_Id == SelColor!.id &&
          element.Size_Id == SelSize!.Id,
      orElse: () => OrderSizeColorDetailsBLL(Id: -1),
    );

    return AQL_OrderSizeColorMatrix(
      personalCase,
      item,
          () async {
        caseProvider.ModelOrderMatrix = item;

        var value = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WachingSampleList()),
        );

        setState(() {
          print(value);
        });
      },
    );
  }



  Widget AQL_OrderSizeColorMatrix(
    PersonalProvider PersonalCase,
    OrderSizeColorDetailsBLL Item,
    Function() OnTap,
  ) {
    Widget FinishStatus = ClipOval(
      child: Icon(Icons.check_circle_rounded, color: ArgonColors.success),
    );

    Widget PendingStatus = ClipOval(
      child: Icon(Icons.panorama_fish_eye_rounded, color: ArgonColors.warning),
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
          LabelFex: 4,
        ),
        SizedBox(height: 8),
        CardRow(
          PersonalCase.GetLable(ResourceKey.SizeColor_QTY),
          PersonalCase.GetLable(ResourceKey.Check_Sample),
          (Item.SizeColor_QTY ?? 0).toString(),
          (Item.Sample_Amount ?? 0).toString(),
          LabelFex: 4,
        ),
      ],
    );

    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(onTap: OnTap, child: MainRow),
      ),
    );
  }

  Widget buildOrderSize(PersonalProvider personalCase) {
    return SelectableItemList<ModelOrderColorsBLL>(
      future: LoadingColorList(personalCase),
      title: 'Color List',
      selectedItem: SelColor,
      getTitle: (item) => item.ColorParam_StringVal ?? '',
      isSelected: (item) => SelColor?.id == item.id,
      onItemSelected:
          (item) => {
            setState(() {
              SelColor = item;
            }),
          },
    );
  }

  Widget buildOrderColors(PersonalProvider personalCase) {
    return SelectableItemList<ModelOrderSizesBLL>(
      future: LoadingSizeList(personalCase),
      title: 'Size List',
      selectedItem: SelSize,
      getTitle: (item) => item.SizeParam_StringVal ?? '',
      isSelected: (item) => SelSize?.Id == item.Id,
      onItemSelected:
          (item) => {
        setState(() {
          SelSize = item;
        }),
      },
    );
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
        context: context,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TableLable(
                PersonalCase.SelectedOrder!.Order_Number ?? '',
                padding: 15,
              ),
            ],
          ),
          MainInformationBox(PersonalCase),

          /// Row with two FutureBuilders
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildOrderColors(PersonalCase)),
              SizedBox(width: 10),
              Expanded(child: buildOrderSize(PersonalCase)),
            ],
          ),
          GetSelectedMatrix(PersonalCase,CaseProvider)
        ],
      ),
    );
  }
}
