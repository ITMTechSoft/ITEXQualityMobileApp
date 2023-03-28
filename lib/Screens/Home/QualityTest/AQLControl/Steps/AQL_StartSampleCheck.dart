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

import 'AQL_QuaulityItemControl.dart';

class AQL_StartSampleCheck extends StatefulWidget {
  @override
  _AQL_StartSampleCheckState createState() => _AQL_StartSampleCheckState();
}

class _AQL_StartSampleCheckState extends State<AQL_StartSampleCheck> {
  int IntiteStatus = 0;
  List<int> selectedList = [];

  bool _IsDeletedVal = false;
  bool _IsMeasurTest = false;

  bool _FilterMinor = false;
  bool _FilterMajor = false;
  String? _FilterName = null;


  Widget FilterSwitch(String lable, bool FilterValue, Function Action) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(lable),
        Switch(
            value: FilterValue,
            onChanged: (value) {
              Action(value);
            })
      ],
    );
  }


  List<Size_Measurement_AllowanceBLL>? MeasurementItemList;
  List<Quality_ItemsBLL>? QualityItems;

  //#region Loading Data
  Future<List<Quality_ItemsBLL>?> LoadingOpenPage(PersonalProvider PersonalCase,
      SubCaseProvider CaseProvider) async {
    if (QualityItems == null)
      QualityItems = await Quality_ItemsBLL.GetDeptModOrderQualityWithValue(
          "AQLT",
          PersonalCase
              .GetCurrentUser()
              .Id,
          CaseProvider.ModelOrderMatrix!.Id,
          QualityTest_Id: PersonalCase.SelectedTest!.QualityTest_Id,
          QualityDept_ModelOrder_Tracking_Id: CaseProvider.QualityTracking!.Id,
          DeptModelOrder_QualityTest_Id:
          CaseProvider.QualityTracking!.DeptModelOrder_QualityTest_Id!);

    if (QualityItems != null) {
      IntiteStatus = 1;
      if (_FilterMajor)
        QualityItems =
            QualityItems?.where((element) => element.Major == _FilterMajor)
                .toList();
      if (_FilterMinor)
        QualityItems =
            QualityItems?.where((element) => element.Minor == _FilterMinor)
                .toList();

      if (_FilterName != null)
        QualityItems = QualityItems?.where((element) =>
        element.Item_Name?.contains(_FilterName ?? "") ?? false).toList();

      return QualityItems;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Future<List<Size_Measurement_AllowanceBLL>?> LoadingMeasurement(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    if (MeasurementItemList == null)
      MeasurementItemList =
      await Size_Measurement_AllowanceBLL.Get_Size_Measurement_Allowance(
          ModelOrderSize_Id: CaseProvider.ModelOrderMatrix!.Size_Id,
          DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
          QualityDept_ModelOrder_Tracking_Id:
          CaseProvider.QualityTracking!.Id);

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

  int GetMinor() {
    int Minor = 0;
    for (int i = 0; i < QualityItems!.length; i++)
      if (QualityItems![i].Item_Level == 5)
        Minor += (QualityItems![i].Amount ?? 0);

    return Minor;
  }

  int GetMajor() {
    int Major = 0;
    for (int i = 0; i < QualityItems!.length; i++) {
      if (QualityItems![i].Item_Level != 5)
        Major += (QualityItems![i].Amount ?? 0);

      if (QualityItems![i].Item_Level == 5) if (QualityItems![i].Minor! > 0)
        Major +=
            ((QualityItems![i].Amount ?? 0) / (QualityItems![i].Minor ?? 1))
                .toInt();
    }

    return Major;
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
            _IsMeasurTest
                ? MeasurementControl(PersonalCase, CaseProvider)
                : Get_QuaulityItemControl(PersonalCase, CaseProvider)

          ],
        ));
  }

  Widget Get_QuaulityItemControl(PersonalCase, CaseProvider) {
    return FutureBuilder<List<Quality_ItemsBLL>?>(
      future: LoadingOpenPage(PersonalCase, CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return QuaulityItemControl(snapshot.data!);
        else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
              ActionName: PersonalCase.GetLable(ResourceKey.Loading),
              MessageError:
              PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
              DetailError:
              PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
      },);
  }

  /*
  Widget QuaulityItemControl(PersonalCase, CaseProvider) {
    return FutureBuilder(
      future: LoadingOpenPage(PersonalCase, CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //      GetHeaderPage(PersonalCase),
              MainInformationBox(PersonalCase, CaseProvider),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),
                child:
                    SampleList(context, PersonalCase, CaseProvider, snapshot),
              )
            ],
          );
        } else if (IntiteStatus == 0)
          return Center(child: CircularProgressIndicator());
        else
          return ErrorPage(
              ActionName: PersonalCase.GetLable(ResourceKey.Loading),
              MessageError:
                  PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
              DetailError:
                  PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
      },
    );
  }
*/
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
          } else if (IntiteStatus == 0)
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

  //#region QuaulityItem
  Widget MainInformationBox(PersonalProvider PersonalCase,
      SubCaseProvider CaseProvider) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
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
          CardRow(
              PersonalCase.GetLable(ResourceKey.Minor),
              PersonalCase.GetLable(ResourceKey.Major),
              (GetMinor()).toString(),
              (GetMajor()).toString()),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 4,
                  child: CustomButton(
                      width: getScreenWidth() / 2.5,
                      height: ArgonSize.HeightSmall1,
                      textSize: ArgonSize.Header3,

                      ///TODO : ADD Start Measuring to ResourceKey
                      value: PersonalCase.GetLable(ResourceKey.CloseControl),
                      backGroundColor: ArgonColors.success,
                      function: () async {
                        Navigator.pop(context);
                      })),
              Expanded(
                  flex: 4,
                  child: CustomButton(
                      width: getScreenWidth() / 3,
                      height: ArgonSize.HeightSmall1,
                      textSize: ArgonSize.Header3,

                      ///TODO : ADD Start Measuring to ResourceKey
                      value: PersonalCase.GetLable(ResourceKey.Measurement),
                      backGroundColor: ArgonColors.myLightBlue,
                      function: () {
                        IntiteStatus = 0;
                        setState(() {
                          _IsMeasurTest = true;
                        });
                      })),
              Expanded(
                flex: 1,
                child: RadioSwitch(
                  Lable: PersonalCase.GetLable(ResourceKey.Delete),
                  fontSize: ArgonSize.Header5,
                  SwitchValue: _IsDeletedVal,
                  OnTap: (value) {
                    setState(() {
                      _IsDeletedVal = value;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterSwitch("Minor", _FilterMinor, (value) {
                setState(() {
                  _FilterMinor = value;
                });
              }),
              FilterSwitch("Major", _FilterMajor, (value) {
                setState(() {
                  _FilterMajor = value;
                });
              }),
            ],
          ),
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }


  Widget SampleList(context, PersonalCase, SubCaseProvider CaseProvider,
      snapshot) {
    Future OnTapQualityItem(Quality_ItemsBLL item, index) async {
      var UserQuality = new User_QualityTracking_DetailBLL();
      UserQuality.Quality_Items_Id = item.Id;
      UserQuality.QualityDept_ModelOrder_Tracking_Id =
          CaseProvider.QualityTracking!.Id;

      if (_IsDeletedVal)
        UserQuality.Amount = -1;
      else
        UserQuality.Amount = 1;

      if (_IsDeletedVal == false && (item.IsTakeImage ?? false)) {
        UserQuality.Image64 = await TakeImageFromCamera();
      }

      bool CheckStatus = await UserQuality.Set_QualityAQLError();

      if (CheckStatus)
        setState(() {
          if (_IsDeletedVal) {
            if ((QualityItems![index].Amount ?? 0) > 0)
              QualityItems![index].Amount =
                  (QualityItems![index].Amount ?? 0) - 1;
          } else
            QualityItems![index].Amount =
                (QualityItems![index].Amount ?? 0) + 1;
        });
    }

    int GetMajorValue(Quality_ItemsBLL item) {
      if (item.Item_Level == 5) {
        if ((item.Minor ?? 0) > 0) {
          return ((item.Amount ?? 0) / item.Minor!).toInt();
        }
      } else
        return (item.Amount ?? 0);

      return 0;
    }

    return BoxMaterialCard(Childrens: <Widget>[

      GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: getScreenWidth() > 500 ? 3 / 2 : 7 / 6,
        crossAxisCount: 3,
        children: List.generate(snapshot.data!.length, (index) {
          return ButtonWithNumber(
              text: QualityItems![index].Item_Name!,
              buttonWidth: getScreenWidth() / 3,
              buttonHegiht: getScreenHeight() / 6,
              textColor: Color(snapshot.data![index].Font_Color ?? 2315255808),
              btnBgColor:
              Color(snapshot.data![index].Item_Hex_Color ?? -2519964),
              textSize: (snapshot.data![index].Font_Size ?? ArgonSize.Header4)
                  .toDouble(),
              topRight: CircleShape(
                  text: GetMajorValue(QualityItems![index]).toString(),
                  width: ArgonSize.WidthSmall,
                  height: ArgonSize.WidthSmall,
                  color:
                  Color(snapshot.data![index].Circle_Color ?? 4278204558),
                  fontSize: ArgonSize.Header4),
              topLeft: QualityItems![index].Item_Level == 5
                  ? CircleShape(
                  text: (QualityItems![index].Amount ?? 0).toString(),
                  width: ArgonSize.WidthSmall,
                  height: ArgonSize.WidthSmall,
                  color: ArgonColors.myYellow,
                  textColor: ArgonColors.myBlue,
                  fontSize: ArgonSize.Header4)
                  : Container(width: 0, height: 0),
              bottomRight: _IsDeletedVal == true
                  ? IconInsideCircle(
                  iconSize: getScreenWidth() > 1100
                      ? ArgonSize.Header6
                      : ArgonSize.Header6,
                  size: getScreenWidth() > 1000
                      ? ArgonSize.Padding6
                      : ArgonSize.Padding6,
                  icon: FontAwesomeIcons.minus,
                  color: Colors.white,
                  backGroundColor: Colors.red)
                  : Container(width: 0, height: 0),
              bottomLeft: QualityItems![index].IsTakeImage == true
                  ? IconInsideCircle(
                  iconSize: getScreenWidth() > 1100
                      ? ArgonSize.Padding2
                      : ArgonSize.Padding7,
                  size: getScreenWidth() > 1000
                      ? ArgonSize.Padding2
                      : ArgonSize.Padding7,
                  icon: FontAwesomeIcons.camera,
                  color: Colors.white,
                  backGroundColor: Colors.deepPurple)
                  : Container(width: 0, height: 0),
              OnTap: () async {
                await OnTapQualityItem(QualityItems![index], index);
              });
        }, growable: false),
      ),
    ]);
  }

  //#endregion

  //#region Measurements
  Widget MeasurementInfoBox(PersonalProvider PersonalCase,
      SubCaseProvider CaseProvider) {
    return InformationBox(
      MainPage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
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
          CardRow(
              PersonalCase.GetLable(ResourceKey.Minor),
              PersonalCase.GetLable(ResourceKey.Major),
              (GetMinor()).toString(),
              (GetMajor()).toString()),
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
                      _IsMeasurTest = false;
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

  Widget MeasurementList(context, PersonalCase, SubCaseProvider CaseProvider,
      snapshot) {
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
                        (Item.CheckStatus ?? 0) == 0
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

  Future<bool> InsertMeasurement(Size_Measurement_AllowanceBLL item,
      SubCaseProvider CaseProvider) async {
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
                title: LableTitle(
                    PersonalCase.GetLable(ResourceKey.Measurement),
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

                        if (IsList &&
                            (Index + 1) < MeasurementItemList!.length) {
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


