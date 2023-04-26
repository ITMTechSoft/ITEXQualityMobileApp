import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DepartmentModelOrder_QualityTest.dart';
import 'package:itex_soft_qualityapp/Models/Quality_NotesBLL.dart';
import 'package:itex_soft_qualityapp/Models/RoundTestBLL.dart';
import 'package:itex_soft_qualityapp/Screens/Home/QualityTest/AQLControl/AQL_Control.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/NoteButton.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/QualityTestImports.dart';
import 'QualityTest/CheckList/CheckList_Main.dart';
import 'QualityTest/Cutting_Control/Cutting_Control.dart';
import 'QualityTest/SampleCheck/SampleCheckList.dart';
import 'QualityTest/SizeControl/Size_Control.dart';

class QualityTestList extends StatefulWidget {
  @override
  _QualityTestListState createState() => _QualityTestListState();
}

class _QualityTestListState extends State<QualityTestList> {
  int IntiteStatus = 0;
  bool? IsUserApproved;

  List<RoundTestBLL>? Rounds;
  int SelectedId = 0;

  bool _filterEnabled = false;

  Future<List<DepartmentModelOrder_QualityTestBLL>?> LoadEmployeeOrders(
      PersonalProvider PersonalCase) async {
    try {
      Rounds = await RoundTestBLL.Get_RoundTest(PersonalCase.SelectedOrder!.Id);

      List<DepartmentModelOrder_QualityTestBLL>? Items =
          await DepartmentModelOrder_QualityTestBLL
              .Get_DepartmentModelOrder_QualityTest(
                  PersonalCase.SelectedOrder!.Id);

      if ((Rounds?.length ?? 0) > 0)
        SelectedId = Rounds?.where((el) => el.EndTime == null)?.first?.Id ?? 0;

      if (SelectedId != 0 && _filterEnabled != true)
        Items = Items?.where((r) => r.RoundTest_Id == SelectedId).toList();

      if (Items != null)
        IntiteStatus = 1;
      else
        IntiteStatus = -1;
      return Items;
    } catch (Excption) {}
  }

  Future<void> MappingSelectedQualityTest(
      PersonalProvider PersonalCase, DataList, Index) async {
    var Critiera = (DataList as List<DepartmentModelOrder_QualityTestBLL>)
        .where((el) => el.IsMandatory == true && el.QualityTest_Id == 1)
        .toList();

    if (Critiera.length > 0 && DataList[Index].QualityTest_Id != 1) {
      IsUserApproved = await Critiera.first
          .IsUserApprovedBefore(Employee_Id: PersonalCase.GetCurrentUser().Id);
      if (IsUserApproved!) {
        PersonalCase.SelectedTest = DataList[Index];
        if (PersonalCase.SelectedTest!.StartDate == null)
          await PersonalCase.SelectedTest!.StartQualityDepartmentTest();
        MandatoryCritieraAction(PersonalCase.SelectedTest!);
      } else {
        PersonalCase.SelectedTest = Critiera.first;
        AlertPopupDialogWithAction(
            context: context,
            title: PersonalCase.GetLable(ResourceKey.WarrningMessage),
            Children: [
              LableTitle(PersonalCase.GetLable(ResourceKey.PleaseCheckCriteria),
                  FontSize: ArgonSize.Header5),
            ],
            FirstActionLable: PersonalCase.GetLable(ResourceKey.Okay),
            SecondActionLable: PersonalCase.GetLable(ResourceKey.Cancel),
            OnFirstAction: () {
              Navigator.pop(context);
              MandatoryCritieraAction(PersonalCase.SelectedTest!);
            });
      }
    } else {
      PersonalCase.SelectedTest = DataList[Index];
      MandatoryCritieraAction(PersonalCase.SelectedTest!);
    }
  }

  void MandatoryCritieraAction(DepartmentModelOrder_QualityTestBLL TargetTest) {
    switch (TargetTest.QualityType) {
      case "Criteria":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Criteria_Test()));
        break;
      case "CutAmount":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Amount()));
        break;
      case "CutControl":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cutting_Control()));
        break;
      case "CutPastal":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cutting_Pastal()));
        break;
      case "SampleCheckList":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SampleCheckList()));
        break;
      case "Tasnif_Control":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tasnif_Control()));
        break;
      case "Tasnif_Amount":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tasnif_Amount()));
        break;
      case "Accessory_Control":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Accessory_Control()));
        break;
      case "Dikim_InlineControl":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dikim_InlineControl()));
        break;
      case "Dikim_LastControl":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dikim_LastControl()));
        break;
      case "SizeControl":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Size_Control()));
        break;
      case "AQLKontrol":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AQL_Control()));
        break;
      case "CheckList":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cutting_CheckList()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.GetLable(ResourceKey.QualityTests),
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: FutureBuilder<List<DepartmentModelOrder_QualityTestBLL>?>(
        future: LoadEmployeeOrders(PersonalCase),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(shrinkWrap: true, primary: false, children: <
                Widget>[
              Container(
                  margin: EdgeInsets.all(ArgonSize.MainMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: ListTile(
                                title: HeaderTitle(
                                    PersonalCase.SelectedOrder!.Order_Number,
                                    color: ArgonColors.header,
                                    FontSize: ArgonSize.Header3),
                                subtitle: Text(
                                    PersonalCase.SelectedOrder!.Model_Name
                                        .toString(),
                                    style:
                                        TextStyle(fontSize: ArgonSize.Header6)),
                                dense: true,
                                selected: true,
                                tileColor: ArgonColors.Title,
                              )),
                          Expanded(
                              flex: 1,
                              child: NoteButton(
                                width: 40.0,
                                height: 40.0,
                                onNoteSaved: (noteText) async {
                                   var note = new Quality_NotesBLL(PersonalCase.GetCurrentUser().Id, noteText,QualityDepartment_ModelOrder_Id: PersonalCase.SelectedOrder?.Id );
                                   await note.SaveEntity();
                                  print('Note saved: $noteText');
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          CustomButton(
                            height: ArgonSize.WidthSmall1,
                            width: getScreenWidth() / 3,
                            textSize: ArgonSize.Header4,
                            backGroundColor: ArgonColors.myVinous,
                            value: PersonalCase.GetLable(ResourceKey.RoundCopy),
                            function: () async {
                              showConfirmationDialog(
                                  context,
                                  PersonalCase.GetLable(
                                      ResourceKey.AttentionVal),
                                  PersonalCase.GetLable(
                                      ResourceKey.ConfirmNewRoundTest),
                                  () async {
                                bool check =
                                    await RoundTestBLL.GenerateRoundCopy(
                                        PersonalCase.SelectedOrder!.Id);

                                if (check) {
                                  PersonalCase.ReloadFunction();
                                }
                              });
                            },
                          ),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(PersonalCase.GetLable(
                                  ResourceKey.ShowRounds)),
                              Switch(
                                  value: _filterEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _filterEnabled = value;
                                    });
                                  })
                            ],
                          )),
                          CustomButton(
                            height: ArgonSize.WidthSmall1,
                            width: getScreenWidth() / 3,
                            textSize: ArgonSize.Header4,
                            backGroundColor: ArgonColors.primary,
                            value:
                                PersonalCase.GetLable(ResourceKey.CloseControl),
                            function: () async {
                              AlertPopupDialogWithAction(
                                  context: context,
                                  title: PersonalCase.GetLable(
                                      ResourceKey.WarrningMessage),
                                  Children: [
                                    LableTitle(
                                        PersonalCase.GetLable(ResourceKey
                                            .ConfirmCloseDepartmentControl),
                                        FontSize: ArgonSize.Header5),
                                  ],
                                  FirstActionLable:
                                      PersonalCase.GetLable(ResourceKey.Okay),
                                  SecondActionLable:
                                      PersonalCase.GetLable(ResourceKey.Cancel),
                                  OnFirstAction: () async {
                                    bool check = await PersonalCase
                                        .SelectedOrder!
                                        .CloseQualityDepartmentTest();
                                    if (check) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      PersonalCase.ReloadFunction();
                                    }
                                    ;
                                  });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: ArgonSize.Padding3),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int i) {
                            return OrderTestList(
                                Item: snapshot.data![i],
                                lable: PersonalCase.GetLable(ResourceKey.Round),
                                OnTap: () async {
                                  await MappingSelectedQualityTest(
                                      PersonalCase, snapshot.data, i);
                                });
                          }),
                    ],
                  ))
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
      ),
    );
  }
}
