import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Cutting_Kontrol_List extends StatefulWidget {
  @override
  _Cutting_Kontrol_ListState createState() => _Cutting_Kontrol_ListState();
}

class _Cutting_Kontrol_ListState extends State<Cutting_Kontrol_List> {
  @override
  int IntiteStatus = 0;

  Future<List<DeptModOrderQuality_ItemsBLL>?> LoadingCutttingControl(
      PersonalProvider PersonalCase, SubCaseProvider CaseProvider) async {
    List<DeptModOrderQuality_ItemsBLL>? Criteria =
        await DeptModOrderQuality_ItemsBLL.Get_DeptModOrderQuality_Items(
            PersonalCase.GetCurrentUser().Id,
            PersonalCase.SelectedTest!.Id,
            PersonalCase.SelectedSize!.Id,
            CaseProvider.SelectedPastal!.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      Criteria.forEach((element) {
        element.QualityDept_ModelOrder_Tracking_Id =
            PersonalCase.SelectedTracking!.Id;
        element.Employee_Id = PersonalCase.GetCurrentUser().Id;
        element.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest!.Id;
        element.ModelOrderSizes_Id = PersonalCase.SelectedSize!.Id;
      });
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget AraControlHeader(PersonalProvider PersonalCase) {
    int Percentage = 0;
    if ((PersonalCase.SelectedTracking!.Sample_Amount ?? 0) > 0)
      Percentage = ((PersonalCase.SelectedTracking!.Error_Amount! * 100) /
              PersonalCase.SelectedTracking!.Sample_Amount!)
          .ceil();
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ArgonColors.Group,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      LableTitle(PersonalCase.GetLable(ResourceKey.SizeName))),
              Expanded(
                  child: LableTitle(
                      PersonalCase.SelectedSize!.SizeParam_StringVal??'',
                      color: ArgonColors.text)),
              Expanded(
                flex: 2,
                child:
                    LableTitle(PersonalCase.GetLable(ResourceKey.TotalControl)),
              ),
              Expanded(
                child: LableTitle(
                    (PersonalCase.SelectedTracking!.Sample_Amount ?? 0)
                        .toString(),
                    color: ArgonColors.text),
              )
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            children: [
              Expanded(
                  child: LableTitle(
                      PersonalCase.GetLable(ResourceKey.ErrorAmount))),
              Expanded(
                  child: LableTitle(
                      (PersonalCase.SelectedTracking!.Error_Amount ?? 0)
                          .toString(),
                      color: ArgonColors.text)),
              Expanded(
                flex: 2,
                child: LableTitle(
                    PersonalCase.GetLable(ResourceKey.ErrorPercentage)),
              ),
              Expanded(
                child: LableTitle(Percentage.toString() + " % ",
                    color: ArgonColors.text),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget AraControlCard(DeptModOrderQuality_ItemsBLL Item, Function Execute,
      PersonalProvider PersonalCase) {
    TextEditingController InputVal = new TextEditingController();
    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
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
                        PersonalCase.GetLable(ResourceKey.ControlAxaisName))),
                Expanded(
                    flex: 2,
                    child: LableTitle(
                        PersonalCase.GetLable(ResourceKey.ControlAmount))),
                Expanded(
                    flex: 2,
                    child: LableTitle(
                        PersonalCase.GetLable(ResourceKey.ControlError)))
              ],
            ),
            SizedBox(height: ArgonSize.Padding6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 3,
                    child: Center(
                      child:
                          LableTitle(Item.Item_Name??'', color: ArgonColors.text),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: LableTitle((Item.Amount ?? 0).toString(),
                          color: ArgonColors.text),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: LableTitle((Item.Error_Amount ?? 0).toString(),
                          color: ArgonColors.text),
                    ))
              ],
            ),
            SizedBox(height: ArgonSize.Padding4),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButton(
                      value: PersonalCase.GetLable(ResourceKey.Saglim),
                      backGroundColor: ArgonColors.primary,
                      width: getScreenWidth() / 2,
                      height: ArgonSize.WidthSmall1,
                      function: () async {
                        int DelValue = int.tryParse(InputVal.text) ?? 1;
                        var NewItem =
                            await Item.CorrectSpecificAmount(DelValue);
                        if (NewItem != null) Item = NewItem;
                        PersonalCase.SelectedTracking!.Sample_Amount = PersonalCase.SelectedTracking!.Sample_Amount??0+1;

                        Execute();
                      }),
                ),
                SizedBox(width: 20),
                Expanded(
                    flex: 2,
                    child: Input_Form(
                      InputHeight: ArgonSize.WidthSmall1,
                      controller: InputVal,
                      KType: TextInputType.number,
                    )),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                      value: PersonalCase.GetLable(ResourceKey.Error),
                      backGroundColor: ArgonColors.myRed,
                      width: getScreenWidth() / 2,
                      height: ArgonSize.WidthSmall1,
                      function: () async {
                        int DelValue = int.tryParse(InputVal.text) ?? 1;
                        var NewItem = await Item.ErrorSpecificAmount(DelValue);
                        if (NewItem != null) Item = NewItem;
                        PersonalCase.SelectedTracking!.Sample_Amount = PersonalCase.SelectedTracking!.Sample_Amount??0+1;
                        PersonalCase.SelectedTracking!.Error_Amount  =  PersonalCase.SelectedTracking!.Error_Amount??0+1;
                        Execute();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget AraKontrolList(snapshot, PersonalProvider PersonalCase) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int i) {
            return AraControlCard(snapshot.data[i], () async {
              //await PersonalCase.UpdateInformation();
              setState(() {
                //  PersonalCase.SelectedTracking.
              });
            }, PersonalCase);
          }),
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
            CaseProvider.ReloadAction();
            Navigator.pop(context);
          },
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number ?? '',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(
              PersonalCase.SelectedDepartment!.Start_Date.toString() ,
              style: TextStyle(fontSize: ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingCutttingControl(PersonalCase, CaseProvider),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    AraControlHeader(PersonalCase),
                    AraKontrolList(snapshot, PersonalCase)
                  ]);
            } else if (IntiteStatus == 0)
              return Center(child: CircularProgressIndicator());
            else
              return ErrorPage(
                  ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                  MessageError:
                      PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                  DetailError: PersonalCase.GetLable(
                      ResourceKey.InvalidNetWorkConnection));
          },
        )
      ]),
    );
  }
}
