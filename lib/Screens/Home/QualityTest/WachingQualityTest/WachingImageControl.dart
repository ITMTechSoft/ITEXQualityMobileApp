import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/Quality_NotesBLL.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/TakeImageCamera.dart';
import 'package:itex_soft_qualityapp/Widgets/CardRow.dart';
import 'package:itex_soft_qualityapp/Widgets/LayoutTemplate.dart';
import 'package:itex_soft_qualityapp/Widgets/NoteButton.dart';

class WachingImageControl extends StatefulWidget {
  const WachingImageControl({super.key});

  @override
  State<WachingImageControl> createState() => _WachingImageControlState();
}

class _WachingImageControlState extends State<WachingImageControl> {
  int IntiteStatus = 0;

  List<DeptModOrderQuality_ItemsBLL>? WachingImageList;

  Future<List<DeptModOrderQuality_ItemsBLL>?> LoadingOpenPage(
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
  ) async {
    WachingImageList =
        await DeptModOrderQuality_ItemsBLL.Get_WachingDeptModOrderQualityTest_Items(
          QualityDept_ModelOrder_Tracking_Id: CaseProvider.QualityTracking!.Id,
          QualityTestPartId: CaseProvider.QualityTestPart!.Id,
          DeptModelOrder_QualityTest_Id: PersonalCase.SelectedTest!.Id,
        );

    if (WachingImageList != null) {
      if (WachingImageList!.length > 0)
        IntiteStatus = 1;
      else
        IntiteStatus == -2;
      return WachingImageList;
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

          CardRow(
            PersonalCase.GetLable(ResourceKey.WachingCount),
            PersonalCase.GetLable(ResourceKey.ControlResult),
            (CaseProvider.QualityTracking!.SampleNo.toString() ?? ''),
            (CaseProvider.QualityTracking!.ControlResult ?? ''),
          ),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0), // Or any padding you prefer
                  child: NoteButton(
                    width: 40.0,
                    height: 40.0,
                    onNoteSaved: (noteText) async {
                      var note = Quality_NotesBLL(
                        PersonalCase.GetCurrentUser().Id,
                        noteText,
                        QualityDepartment_ModelOrder_Id:
                            PersonalCase.SelectedOrder?.Id,
                        DepartmentModelOrder_QualityTest_Id:
                            PersonalCase.SelectedTest?.Id,
                        QualityDept_ModelOrder_Tracking_Id:
                        CaseProvider.QualityTracking?.Id,
                        QualityTestPartId: CaseProvider.QualityTestPart?.Id,
                      );
                      await note.SaveEntity();
                      print('Note saved: $noteText');
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      function: () {
        setState(() {});
      },
    );
  }

  Widget MainControl(PersonalCase, CaseProvider) {
    return FutureBuilder<List<DeptModOrderQuality_ItemsBLL>?>(
      future: LoadingOpenPage(PersonalCase, CaseProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ImageControl(PersonalCase, CaseProvider, snapshot!.data);
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
          MainInformationBox(PersonalCase, CaseProvider, context),
          MainControl(PersonalCase, CaseProvider),
        ],
      ),
    );
  }

  Widget isInsertedIcon(DeptModOrderQuality_ItemsBLL items) {
    if (items.IsMandatory == true || items.IsChecked == true)
      return IconInsideCircle(
        iconSize:
            getScreenWidth() > 1100 ? ArgonSize.Padding2 : ArgonSize.Padding7,
        size: getScreenWidth() > 1000 ? ArgonSize.Padding2 : ArgonSize.Padding7,
        icon: items.IsChecked! ? FontAwesomeIcons.check : FontAwesomeIcons.bell,
        color: Colors.white,
        backGroundColor:
            items.IsChecked!
                ? ArgonColors.myLightGreen
                : ArgonColors.myLightRed,
      );
    else
      return Container(width: 0, height: 0);
  }

  Widget GetImageButton(DeptModOrderQuality_ItemsBLL items) {
    return IconInsideCircle(
      iconSize:
          getScreenWidth() > 1100 ? ArgonSize.Padding2 : ArgonSize.Padding7,
      size: getScreenWidth() > 1000 ? ArgonSize.Padding2 : ArgonSize.Padding7,
      icon: FontAwesomeIcons.camera,
      color: Colors.white,
      backGroundColor: Colors.deepPurple,
    );
  }

  Future OnTapQualityItem(
    DeptModOrderQuality_ItemsBLL item,
    PersonalProvider PersonalCase,
    SubCaseProvider CaseProvider,
  ) async {
    var UserQuality = new User_QualityTracking_DetailBLL();
    UserQuality.Xaxis_QualityItem_Id = item.Id;
    UserQuality.Quality_Items_Id = item.Quality_Items_Id;
    UserQuality.DeptModelOrder_QualityTest_Id =
        item.DeptModelOrder_QualityTest_Id;
    UserQuality.QualityDept_ModelOrder_Tracking_Id =
        CaseProvider.QualityTracking!.Id;
    UserQuality.Employee_Id = PersonalCase.GetCurrentUser().Id;
    UserQuality.Amount = 1;

    if ((item.IsTakeImage ?? false)) {
      UserQuality.Image64 = await TakeImageFromCamera();
    }
    UserQuality.CheckStatus = 1;

    bool CheckStatus = await UserQuality.Set_WachingImage_Items();

    if (CheckStatus)
      setState(() {
        UserQuality.CheckStatus = 1;
        CaseProvider.ReloadAction();
      });
  }

  /// this function is the main page actions
  Widget ImageControl(
    personalCase,
    caseProvider,
    List<DeptModOrderQuality_ItemsBLL>? data,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomButton(
          textSize: ArgonSize.Header4,
          width: getScreenWidth() * 0.5,
          height: ArgonSize.HeightSmall1,
          value: personalCase.GetLable(ResourceKey.CloseControl),
          backGroundColor: ArgonColors.primary,
          function: () async {
            //  await CloseCheckListControl(widget.Items?.first.DeptModelOrder_QualityTest_Id);
            Navigator.pop(context);
          },
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: data!.length,
          itemBuilder: (context, int index) {
            return ButtonWithNumber(
              buttonWidth: getScreenWidth(),
              textColor: Color(data[index].Font_Color ?? 2315255808),
              btnBgColor: Color(data[index].Item_Hex_Color ?? -1519964),
              textSize: (data[index].Font_Size ?? ArgonSize.Header4).toDouble(),
              text: data[index].Item_Name!,
              topRight: isInsertedIcon(data[index]),
              bottomLeft: GetImageButton(data[index]),
              OnTap: () async {
                await OnTapQualityItem(data[index], personalCase, caseProvider);
              },
            );
          },
        ),
      ],
    );
  }
}
