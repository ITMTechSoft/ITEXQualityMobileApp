import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Groups.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Screens/Home/Standard_List/Standard_Headers.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/Widgets/Dropdown.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Tasnif_NewSample extends StatefulWidget {
  int DeptModelOrder_QualityTest_Id;
  List<GroupsBLL> TansifGroup;

  Tasnif_NewSample({this.DeptModelOrder_QualityTest_Id});

  @override
  _Tasnif_NewSampleState createState() => _Tasnif_NewSampleState();
}

class _Tasnif_NewSampleState extends State<Tasnif_NewSample> {
  int IntiteStatus = 0;

  final TextEditingController SampleAmountController =
      new TextEditingController();
  final TextEditingController KumnasNoController = new TextEditingController();
  GroupsBLL SelectedItem;

  Future GetTanifGroupItem() async {
    var Items =
        await GroupsBLL.Get_TasnifGroups(widget.DeptModelOrder_QualityTest_Id);
    setState(() {
      widget.TansifGroup = Items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetTanifGroupItem();
  }

  Widget ModelOrderList(PersonalProvider PersonalCase, snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int i) {
            return TasnifModelOrderMatrix(PersonalCase, snapshot.data[i], () {
              PersonalCase.SelectedMatrix = snapshot.data[i];
              setState(() {
                snapshot.data[i].IsChecked = true;
              });
            });
          }),
    );
  }

  Future<List<OrderSizeColorDetailsBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<OrderSizeColorDetailsBLL> Criteria =
    await OrderSizeColorDetailsBLL.Get_OrderSizeColorDetails(
        PersonalCase.SelectedOrder.Order_Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);





    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        Navigator.pop(context);
      },
          context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(
              PersonalCase.GetLable(ResourceKey.CreateTasnifSample),
              color: ArgonColors.header,
              FontSize: ArgonSize.Header2),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(10),
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
                            child: LableTitle(PersonalCase.GetLable(
                                ResourceKey.Sample_Amount))),
                        Expanded(
                          flex: 2,
                          child: Standard_Input(
                            prefixIcon: Icon(Icons.countertops),
                            controller: SampleAmountController,
                            Ktype: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: LableTitle(
                                PersonalCase.GetLable(ResourceKey.ErrorGroup))),
                        Expanded(
                            flex: 2,
                            child: DropDowndList<GroupsBLL>(
                                CurrentItem: SelectedItem,
                                Items:
                                    widget.TansifGroup.map((GroupsBLL value) {
                                  return DropdownMenuItem<GroupsBLL>(
                                    value: value,
                                    child: Text(value.Group_Name),
                                  );
                                }).toList(),
                                Lable: PersonalCase.GetLable(
                                    ResourceKey.SelectItems),
                                OnChange: (GroupsBLL NewValue) {
                                  setState(() {
                                    SelectedItem = NewValue;
                                  });
                                }))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: LableTitle(PersonalCase.GetLable(
                                ResourceKey.Fabric_TopNo))),
                        Expanded(
                          flex: 2,
                          child: Standard_Input(
                            prefixIcon: Icon(Icons.text_fields),
                            controller: KumnasNoController,
                            Ktype: TextInputType.text,
                          ),
                        )
                      ],
                    ),
                    ModelOrderMatrixHeader(PersonalCase),
                    ModelOrderList(PersonalCase, snapshot),
                    StandardButton(
                        Lable: PersonalCase.GetLable(ResourceKey.NewSample),
                        ForColor: ArgonColors.white,
                        BakColor: ArgonColors.primary,
                        OnTap: () async {
                          int CheckItem = 0;
                          if (PersonalCase.SelectedMatrix == null)
                            CheckItem = 1;
                          var Sample =
                              int.tryParse(SampleAmountController.text);
                          if (Sample == 0) CheckItem = 2;

                          if (CheckItem == 0) {
                            var Item = QualityDept_ModelOrder_TrackingBLL();
                            Item.Employee_Id = PersonalCase.GetCurrentUser().Id;
                            Item.DeptModelOrder_QualityTest_Id =
                                PersonalCase.SelectedTest.Id;
                            Item.OrderSizeColorDetail_Id =
                                PersonalCase.SelectedMatrix.Id;
                            Item.StartDate = DateTime.now();
                            Item.Sample_Amount =
                                int.tryParse(SampleAmountController.text);
                            if (SelectedItem != null)
                              Item.QualityItem_Group_Id =
                                  SelectedItem.Groups_id;

                            Item.Fabric_TopNo = KumnasNoController.text;
                            Item.Status = ControlStatus.TansifControlOpenStatus;
                            PersonalCase.SelectedTracking = await Item
                                .Create_QualityDept_ModelOrder_Tracking();
                            if (PersonalCase.SelectedTracking.Id > 0)
                              Navigator.pop(context, "Okay");
                            else
                              AlertPopupDialog(
                                  context,
                                  PersonalCase.GetLable(
                                      ResourceKey.SaveMessage),
                                  PersonalCase.GetLable(
                                      ResourceKey.SaveErrorMessage),
                                  ActionLable:
                                      PersonalCase.GetLable(ResourceKey.Okay));
                          } else {
                            AlertPopupDialog(
                                context,
                                PersonalCase.GetLable(
                                    ResourceKey.SaveErrorMessage),
                                PersonalCase.GetLable(
                                    ResourceKey.MandatoryFields),
                                ActionLable:
                                    PersonalCase.GetLable(ResourceKey.Okay));
                          }
                        }),
                  ],
                ),
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
          },
        )
      ]),
    );
  }
}
