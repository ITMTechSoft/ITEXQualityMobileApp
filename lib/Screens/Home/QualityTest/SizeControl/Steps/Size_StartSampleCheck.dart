import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/FinalControl/Quality_Items.dart';
import 'package:itex_soft_qualityapp/Models/Size_Measurement_Allowance.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/TakeImageCamera.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/RadioSwitch.dart';
import 'package:itex_soft_qualityapp/assets/Component/BoxMainContainer.dart';

class Size_StartSampleCheck extends StatefulWidget {
  @override
  _Size_StartSampleCheckState createState() => _Size_StartSampleCheckState();
}

class _Size_StartSampleCheckState extends State<Size_StartSampleCheck> {
  int IntiteStatus = 0;
  List<int> selectedList = [];

  bool _IsDeletedVal = false;


  List<Size_Measurement_AllowanceBLL>? MeasurementItemList;

  //#region Loading Data

  Future<List<Size_Measurement_AllowanceBLL>?> LoadingMeasurement(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    if (MeasurementItemList == null)
      MeasurementItemList =
          await Size_Measurement_AllowanceBLL.Get_Size_Measurement_Allowance(
              ModelOrderSize_Id: CaseProvider.ModelOrderMatrix!.Size_Id,
              DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
              QualityDept_ModelOrder_Tracking_Id: CaseProvider.QualityTracking!.Id);

    if (MeasurementItemList != null) {
      IntiteStatus = 1;
      return MeasurementItemList;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  //#endregion

  Widget GetHeaderPage(PersonalCase) {
    return ListTile(
      title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
          color: ArgonColors.header, FontSize: ArgonSize.Header3),
      subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString(),
          style: TextStyle(fontSize: ArgonSize.Header6)),
      dense: true,
      selected: true,
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
            MeasurementControl(PersonalCase, CaseProvider)
          ],
        ));
  }



  Widget MeasurementControl(PersonalCase, CaseProvider) {
    return FutureBuilder(
        future: LoadingMeasurement(PersonalCase, CaseProvider),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                //      GetHeaderPage(PersonalCase),
                MeasurementInfoBox(PersonalCase, CaseProvider),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
                  child: MeasurementList(
                      context, PersonalCase, CaseProvider, snapshot),
                )
              ],
            );
          } else
            if (IntiteStatus == 0)
            return Center(child: CircularProgressIndicator());
          else
            return ErrorPage(
                ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                MessageError:
                    PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                DetailError: PersonalCase.GetLable(
                    ResourceKey.InvalidNetWorkConnection));
        });
  }


  //#region Measurements
  Widget MeasurementInfoBox(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardRow(
              PersonalCase.GetLable(ResourceKey.Customer_Name),
              PersonalCase.GetLable(ResourceKey.Model_Name),
              PersonalCase.SelectedOrder!.Customer_Name ?? '',
              PersonalCase.SelectedOrder!.Model_Name ?? ''),
          SizedBox(height: 8),
          CardRow(
              PersonalCase.GetLable(ResourceKey.ColorName) +
                  "-" +
                  PersonalCase.GetLable(ResourceKey.SizeName),
              PersonalCase.GetLable(ResourceKey.SampleNo),
              (CaseProvider.ModelOrderMatrix!.ColorParam_StringVal ?? '') +
                  "/" +
                  (CaseProvider.ModelOrderMatrix!.SizeParam_StringVal ?? ''),
              "Sample  " +
                  (CaseProvider.QualityTracking!.SampleNo ?? 0).toString()),
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomButton(
                  width: getScreenWidth() / 2.5,
                  height: ArgonSize.WidthSmall,
                  textSize: ArgonSize.Header4,

                  ///TODO : ADD Start Measuring to ResourceKey
                  value: PersonalCase.GetLable(ResourceKey.Close),
                  backGroundColor: ArgonColors.myLightRed,
                  function: () {
                    IntiteStatus = 0;
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
              CustomButton(
                  width: getScreenWidth() / 2.5,
                  height: ArgonSize.WidthSmall,
                  textSize: ArgonSize.Header4,

                  ///TODO : ADD Start Measuring to ResourceKey
                  value: PersonalCase.GetLable(ResourceKey.StartMeasure),
                  backGroundColor: ArgonColors.myLightBlue,
                  function: () async {
                    await MeasurementPopUp(context, PersonalCase, CaseProvider,
                        IsList: true);
                  })
            ],
          )
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  Widget MeasurementList(
      context, PersonalCase, SubCaseProvider CaseProvider, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: MeasurementItemList!.length,
        itemBuilder: (context, int index) {
          return Card(
            shadowColor: ArgonColors.black,
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: MeasurementItem(PersonalCase, MeasurementItemList![index],
                  () async {
                await MeasurementPopUp(context, PersonalCase, CaseProvider,
                    Index: index);
              }),
            ),
          );
        });
  }

  Widget MeasurementItem(PersonalProvider PersonalCase,
      Size_Measurement_AllowanceBLL? Item, Function()? OnTap) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LableTitle(PersonalCase.GetLable(ResourceKey.Measurement),
                IsCenter: false),
            LableTitle(Item!.Measurement ?? '',
                color: ArgonColors.text,
                FontSize: ArgonSize.Header4,
                IsCenter: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        LableTitle(PersonalCase.GetLable(ResourceKey.Measure)),
                        LableTitle((Item.Measure ?? 0).toString(),
                            color: ArgonColors.myBlue),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        LableTitle(
                            PersonalCase.GetLable(ResourceKey.AQL_Tolerance)),
                        LableTitle((Item.Tolerance ?? 0).toString(),
                            color: ArgonColors.myBlue),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        LableTitle(
                            PersonalCase.GetLable(ResourceKey.Real_Measure)),
                        LableTitle((Item.Real_Measure ?? 0).toString(),
                            color: ArgonColors.myBlue),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        LableTitle(
                            PersonalCase.GetLable(ResourceKey.Measure_Fark)),
                        LableTitle((Item.Pastal_Fark ?? 0).toString(),
                            color: ArgonColors.myBlue),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        LableTitle(PersonalCase.GetLable(ResourceKey.Status)),
                        (Item.CheckStatus??0) == 0
                            ? ClipOval(
                                child: Icon(Icons.cancel_outlined,
                                    color: ArgonColors.myRed,
                                    size: ArgonSize.IconSizeMedium),
                              )
                            : ClipOval(
                                child: Icon(Icons.check_circle_rounded,
                                    color: ArgonColors.success,
                                    size: ArgonSize.IconSizeMedium),
                              )
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
      onTap: OnTap,
    );
  }

//#endregion

  //#region Popup

  Future<bool> InsertMeasurement(
      Size_Measurement_AllowanceBLL item, SubCaseProvider CaseProvider) async {
    var User = new User_QualityTracking_DetailBLL();
    User.QualityDept_ModelOrder_Tracking_Id = CaseProvider.QualityTracking!.Id;
    User.Size_Measurement_Allowance_Id = item.Id;
    User.Real_Measure = item.Real_Measure;
    User.Pastal_Fark = item.Pastal_Fark;
    User.CheckStatus = item.CheckStatus;
    bool checks = await User.Set_Size_Measurement_Allowance();

    return checks;
  }

  Future<void> MeasurementPopUp(BuildContext context,
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider,
      {int Index = 0, bool IsList = false}) async {
    bool IsChanged = false;

    ValueChanged<double>? OnChangeSpain(value) {
      MeasurementItemList![Index].Real_Measure = value.toDouble();
      MeasurementItemList![Index].Pastal_Fark =
          (MeasurementItemList![Index].Measure! -
              MeasurementItemList![Index].Real_Measure!);
      if ((MeasurementItemList![Index].Tolerance! * -1) <=
              MeasurementItemList![Index].Pastal_Fark! &&
          MeasurementItemList![Index].Pastal_Fark! <=
              MeasurementItemList![Index].Tolerance!) {
        MeasurementItemList![Index].CheckStatus = 1;
      } else
        MeasurementItemList![Index].CheckStatus = 0;
    }

    return await showDialog(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            title: LableTitle(PersonalCase.GetLable(ResourceKey.Measurement),
                FontSize: ArgonSize.Header1),
            content: Container(
              margin: EdgeInsets.all(ArgonSize.normal),
              width: getScreenWidth() * 0.9,
              height: getScreenHeight() * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LableTitle(MeasurementItemList![Index].Measurement ?? '',
                      color: ArgonColors.text,
                      FontSize: ArgonSize.Header2,
                      IsCenter: false),
                  SpinBox(
                    max: 999999,
                    decimals: 2,
                    textStyle: TextStyle(fontSize: ArgonSize.Header2),
                    value: MeasurementItemList![Index].Measure ?? 0,
                    onChanged: (value) {
                      IsChanged = true;
                      OnChangeSpain(value);
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              CustomButton(
                  width: getScreenWidth() / 2.5,
                  height: ArgonSize.HeightSmall1,
                  textSize: ArgonSize.Header3,

                  ///TODO : ADD Start Measuring to ResourceKey
                  value: PersonalCase.GetLable(ResourceKey.Okay),
                  backGroundColor: ArgonColors.success,
                  function: () async {
                    /// if user doesn't choose any data then system will write same measurement as default
                    if (!IsChanged)
                      OnChangeSpain(MeasurementItemList![Index].Measure);

                    var check = await InsertMeasurement(
                        MeasurementItemList![Index], CaseProvider);

                    if (IsList && (Index + 1) < MeasurementItemList!.length) {
                      setState(() {
                        Index = Index + 1;
                        IsChanged = false;
                      });
                    } else {
                      Navigator.of(context).pop();
                      CaseProvider.ReloadAction();
                    }
                  })
            ]);
      }),
    );
  }

//#endregion
}
