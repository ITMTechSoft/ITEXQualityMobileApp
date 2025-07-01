import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Enum/QualityItemType.dart';
import 'package:itex_soft_qualityapp/Models/QualityTest_PartsBLL.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/BeforeWachingControl.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/MeasurControl.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/WachingImageControl.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/WachingMeasurControl.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/Utils/Loadding.dart';

import '../../../../ProviderCase/SubCaseProvider.dart';
import '../../../../SystemImports.dart';

class WachingSamleControl extends StatefulWidget {
  const WachingSamleControl({super.key});

  @override
  State<WachingSamleControl> createState() => _WachingSamleControlState();
}

class _WachingSamleControlState extends State<WachingSamleControl> {
  int IntiteStatus = 0;

  Widget MainInformationBox(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
    context,
  ) {
    return InformationBox(
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

          CardRow(
            PersonalCase.GetLable(ResourceKey.ColorName),
            PersonalCase.GetLable(ResourceKey.SizeName),
            (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? ''),
            (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? ''),
          ),

          CardRow(
            PersonalCase.GetLable(ResourceKey.WachingCount),
            PersonalCase.GetLable(ResourceKey.ControlResult),
            (CaseProvider.QualityTracking!.SampleNo.toString() ?? ''),
            (CaseProvider.QualityTracking!.ControlResult ?? ''),
          ),
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  List<QualityTest_PartsBLL>? QualityParts;

  //// loading Quality test parts
  Future<List<QualityTest_PartsBLL>?> LoadingOpenPage(
    PersonalProvider PersonalCase,
  ) async {
    QualityParts = await QualityTest_PartsBLL.getQualityTestParts(
      QualityTestsId: PersonalCase.SelectedTest!.QualityTest_Id,
    );

    if (QualityParts != null) {
      if (QualityParts!.length > 0) IntiteStatus = 1;
      return QualityParts;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget QualityTest(
    PersonalProvider PersonalCase,
    QualityTest_PartsBLL Item,
    Function() OnTap,
  ) {
    Widget MainRow = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(

          fit: FlexFit.loose,
          child: CardLabelRow(
            PersonalCase.GetLable(ResourceKey.TestPartName),
            Item.TestPartName!,
          ),
        ),
        SizedBox(width: 16), // Add spacing if needed
        Flexible(
          fit: FlexFit.tight,
          child: CardLabelRow(
            PersonalCase.GetLable(ResourceKey.QualityPartType),
            Item.ItemType == 1 ?
            PersonalCase.GetLable(ResourceKey.QualityItem) :
            PersonalCase.GetLable(ResourceKey.Measurement),
          ),
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

  Widget QualityList(
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
        return QualityTest(PersonalCase, snapshot.data[i], () async {
          CaseProvider.QualityTestPart = snapshot.data[i];
          CaseProvider.QualityPartType = CaseProvider.QualityTestPart!.ItemType;
          switch(CaseProvider.QualityTestPart!.ItemType){
            case QualityPartType.imageTest:
              var value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WachingImageControl()),
              );
              break;
            case QualityPartType.Measurement:
              var value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeasurControl()),
              );
              break;
            case QualityPartType.BeforeWachingMeasurement:
              var value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeforeWachingControl()),
              );
              break;
            case QualityPartType.AfterWachingMeasurement:
              var value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WachingMeasurControl()),
              );
              break;
          }
          setState(() {
            //  print(value);
          });
        });
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
          TableLable(
            PersonalCase.SelectedOrder!.Order_Number ?? '',
            padding: 15,
          ),
          MainInformationBox(PersonalCase, CaseProvider, context),
          FutureBuilder(
            future: LoadingOpenPage(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData && IntiteStatus != 2) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    QualityList(context, PersonalCase, CaseProvider, snapshot),
                  ],
                );
              } else
                return LoadingContainer(IntiteStatus: IntiteStatus);
            },
          ),
        ],
      ),
    );
  }
}
