import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';

import 'AQL_StartSampleCheck.dart';

class AQL_SampleControl extends StatefulWidget {

  @override
  _AQL_SampleControlState createState() => _AQL_SampleControlState();
}

class _AQL_SampleControlState extends State<AQL_SampleControl> {

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

  int GetMinorOrMajor({bool IsMinor = false}) {
    int Sum = 0;
    if (IsMinor)
      TrakingList!.forEach((e) => Sum += (e.AQL_Minor ?? 0));
    else
      TrakingList!.forEach((e) => Sum += (e.AQL_Major ?? 0));
    return Sum;
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
            FutureBuilder(
              future: LoadingOpenPage(PersonalCase, CaseProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainInformationBox(PersonalCase, CaseProvider),
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

  Widget MainInformationBox(PersonalProvider PersonalCase,
      SubCaseProvider CaseProvider) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardRow(
              PersonalCase.GetLable(ResourceKey.ColorName),
              PersonalCase.GetLable(ResourceKey.SizeName),
              (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? ''),
              (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? '')
          ),
          SizedBox(height: 8), CardRow(
              PersonalCase.GetLable(ResourceKey.Minor),
              PersonalCase.GetLable(ResourceKey.Major),
              (GetMinorOrMajor(IsMinor: true).toString()),
              (GetMinorOrMajor().toString())
          ),
          SizedBox(height: 8),
          CustomButton(
              width: getScreenWidth() / 2.5,
              height: ArgonSize.WidthSmall,
              textSize: ArgonSize.Header4,

              ///TODO : ADD Start Measuring to ResourceKey
              value: PersonalCase.GetLable(
                  ResourceKey.CreateSample),
              backGroundColor: ArgonColors.primary,
              function: () async {
                var Item = new QualityDept_ModelOrder_TrackingBLL();
                Item.Employee_Id = PersonalCase
                    .GetCurrentUser()
                    .Id;
                Item.DeptModelOrder_QualityTest_Id =
                    PersonalCase.SelectedTest?.Id;
                Item.OrderSizeColorDetail_Id =
                    CaseProvider.ModelOrderMatrix?.Id;
                Item.ModelOrderSizes_Id =
                    CaseProvider.ModelOrderMatrix?.Size_Id;
                Item.AQL_Major = 0;
                Item.AQL_Minor = 0;
                await Item.Generate_QualityModelOrder_Tracking();
                CaseProvider.ReloadAction();
                /*   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Dikim_EmployeeOperationMerge(
                              RoundItem: widget.RoundItem,
                            )));*/
              })
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  Widget SampleList(context, PersonalCase, SubCaseProvider CaseProvider,
      snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return SizeColorSampleList(PersonalCase, snapshot.data[i],
                  () async {
                CaseProvider.QualityTracking = snapshot.data[i];
                var value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AQL_StartSampleCheck()));
                setState(() {
                  print(value);
                });
              });
        });
  }

  Widget SizeColorSampleList(PersonalProvider PersonalCase,
      QualityDept_ModelOrder_TrackingBLL Item,
      Function() OnTap) {
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
        CardRow(
            PersonalCase.GetLable(ResourceKey.Minor),
            PersonalCase.GetLable(ResourceKey.Major),
            (Item.AQL_Minor ?? 0).toString(),
            (Item.AQL_Major ?? 0).toString(),

            LabelFex: 4),
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
}
