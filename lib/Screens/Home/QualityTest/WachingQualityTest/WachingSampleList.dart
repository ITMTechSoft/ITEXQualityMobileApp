import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderColors.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/WachingQualityTest/showSampleDialog.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';

import '../../../../Models/ModelOrderSizes.dart';
import 'WachingSampleControl.dart';

class WachingSampleList extends StatefulWidget {
  const WachingSampleList({super.key});

  @override
  State<WachingSampleList> createState() => _WachingSampleListState();
}

class _WachingSampleListState extends State<WachingSampleList> {
  int IntiteStatus = 0;
  List<QualityDept_ModelOrder_TrackingBLL>? TrakingList;

  Future<List<QualityDept_ModelOrder_TrackingBLL>?> LoadingOpenPage(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
  ) async {
    TrakingList =
        await QualityDept_ModelOrder_TrackingBLL.Get_AQLModelOrderTracking(
          //  Employee_Id: PersonalCase.GetCurrentUser().Id,
          DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
          OrderSizeColorDetail_Id: CaseProvider.ModelOrderMatrix!.Id,
        );

    if (TrakingList != null) {
      IntiteStatus = 1;
      return TrakingList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

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

          CustomButton(
            width: getScreenWidth(),
            height: ArgonSize.WidthSmall,
            textSize: ArgonSize.Header4,
            value: PersonalCase.GetLable(ResourceKey.CreateSample),
            function: () async {
              await showSampleDialog(
                context: context,
                PersonalCase: PersonalCase,
                onSave: (
                  sampleTicket,
                  controlResult,
                  description,
                  approvalDate,
                  fabric_TopNo,
                  SampleNo,
                  Status,
                ) async {
                  // Call your service with sampleTicket & controlResult
                  await QualityDept_ModelOrder_TrackingBLL.GenerateWachingSample(
                    PersonalCase,
                    CaseProvider,
                    sampleTicket: sampleTicket,
                    controlResult: controlResult,
                    description: description,
                    approvalDate: approvalDate,
                    fabric_TopNo: fabric_TopNo,
                    SampleNo: SampleNo,
                    Status: Status,
                  );

                  CaseProvider.ReloadAction();
                  setState(() {});
                },
              );
            },
          ),
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  Widget SampleList(
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
        return SizeColorSampleList(
          PersonalCase,
          CaseProvider,
          snapshot.data[i],
          () async {
            if(snapshot.data[i]?.Status != 1){
              CaseProvider.QualityTracking = snapshot.data[i];
              var value = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WachingSamleControl()),
              );
            }

            setState(() {
              //  print(value);
            });
          },
        );
      },
    );
  }

  Widget SizeColorSampleList(
    PersonalProvider PersonalCase,
    CaseProvider,
    QualityDept_ModelOrder_TrackingBLL Item,
    Function() OnTap,
  ) {
    Widget MainColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // First Row with CardLabelRows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardLabelRow(
              PersonalCase.GetLable(ResourceKey.WachingCount),
              (Item.SampleNo ?? '1').toString(),
            ),
            CardLabelRow(
              PersonalCase.GetLable(ResourceKey.RafNo),
              Item.SampleTicket ?? '',
            ),
            CardLabelRow(
              PersonalCase.GetLable(ResourceKey.CreateBy),
              Item.Employee_Name ?? '',
            ),
          ],
        ),

        const SizedBox(height: 10), // Spacing between rows
        // Second Row (or just another widget below)
        Item.Status != 1 ?
        CustomButton(
          height: ArgonSize.WidthtooSmall,
          textSize: ArgonSize.Header6,
          backGroundColor: ArgonColors.myVinous,
          value: PersonalCase.GetLable(ResourceKey.Edit),
          function: () async {
            await showSampleDialog(
              context: context,
              PersonalCase: PersonalCase,
              initialControlResult: Item.ControlResult,
              initialDescription: Item.Tracking_Note,
              initialSampleTicket: Item.SampleTicket,
              initialApprovalDate: Item.ApprovalDate,
              initialFabric_TopNo: Item.Fabric_TopNo,
              initialSampleNo: Item.SampleNo,
              initialStatus: Item.Status,
              onSave: (
                sampleTicket,
                controlResult,
                description,
                approvalDate,
                fabric_TopNo,
                SampleNo,
                Status,
              ) async {
                await QualityDept_ModelOrder_TrackingBLL.GenerateWachingSample(
                  PersonalCase,
                  CaseProvider,
                  sampleTicket: sampleTicket,
                  controlResult: controlResult,
                  description: description,
                  approvalDate: approvalDate,
                  fabric_TopNo: fabric_TopNo,
                  SampleNo: SampleNo,
                  Id: Item.Id,
                  Status: Status,
                );

                CaseProvider.ReloadAction();
                setState(() {});
              },
            );
          },
        ) :
        Text(
          PersonalCase.GetLable(ResourceKey.SampleClosed),
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        )

      ],
    );

    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(onTap: OnTap, child: MainColumn),
      ),
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
            future: LoadingOpenPage(PersonalCase, CaseProvider),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ArgonSize.Padding3,
                      ),
                      child: SampleList(
                        context,
                        PersonalCase,
                        CaseProvider,
                        snapshot,
                      ),
                    ),
                  ],
                );
              } else if (IntiteStatus == 0)
                return Center(child: CircularProgressIndicator());
              else
                return ErrorPage(
                  ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                  MessageError: PersonalCase.GetLable(
                    ResourceKey.ErrorWhileLoadingData,
                  ),
                  DetailError: PersonalCase.GetLable(
                    ResourceKey.InvalidNetWorkConnection,
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
