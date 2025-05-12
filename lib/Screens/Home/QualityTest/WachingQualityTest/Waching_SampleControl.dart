import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/showSampleDialog.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';

class Waching_SampleControl extends StatefulWidget {
  const Waching_SampleControl({super.key});

  @override
  State<Waching_SampleControl> createState() => _Waching_SampleControlState();
}

class _Waching_SampleControlState extends State<Waching_SampleControl> {

  int IntiteStatus = 0;
  List<QualityDept_ModelOrder_TrackingBLL>? TrakingList;

  Future<List<QualityDept_ModelOrder_TrackingBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    TrakingList =
    await QualityDept_ModelOrder_TrackingBLL.Get_AQLModelOrderTracking(
      //  Employee_Id: PersonalCase.GetCurrentUser().Id,
        DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
        OrderSizeColorDetail_Id: CaseProvider.ModelOrderMatrix!.Id);

    if (TrakingList != null) {
      IntiteStatus = 1;
      return TrakingList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget MainInformationBox(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider,context) {
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
            LabelFex: 4),

          CardRow(
              PersonalCase.GetLable(ResourceKey.ColorName),
              PersonalCase.GetLable(ResourceKey.SizeName),
              (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? ''),
              (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? '')),

          CustomButton(
            width: getScreenWidth(),
            height: ArgonSize.WidthSmall,
            textSize: ArgonSize.Header4,
            value: PersonalCase.GetLable(ResourceKey.CreateSample),
            function: () async {
              await showSampleDialog( context: context, onSave: (sampleTicket, controlResult) async {
                // Call your service with sampleTicket & controlResult
                await QualityDept_ModelOrder_TrackingBLL.GenerateWachingSample(

                  PersonalCase,
                  CaseProvider,
                  sampleTicket: sampleTicket,
                  controlResult: controlResult,
                );

                CaseProvider.ReloadAction();
                setState(() {});
              });
            },
          )

        ],
      ),
      function: () {
        setState(() {});
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
          context: context),
      body: ListView(
        children: [
          TableLable(
              PersonalCase.SelectedOrder!.Order_Number??'',
              padding: 15),
          MainInformationBox(PersonalCase, CaseProvider,context),


        ],
      ),
    );
  }
}
