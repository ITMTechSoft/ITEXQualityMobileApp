import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Cutting_Pastal extends StatefulWidget {
  @override
  _Cutting_PastalState createState() => _Cutting_PastalState();
}

class _Cutting_PastalState extends State<Cutting_Pastal> {
  int IntiteStatus = 0;
  final TextEditingController CuttingAmountController =
      new TextEditingController();

  Future<List<DeptModOrderQuality_ItemsBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<DeptModOrderQuality_ItemsBLL> Criteria =
        await DeptModOrderQuality_ItemsBLL.Get_CuttingPastalQuality_Items(
            PersonalCase.GetCurrentUser().Id, PersonalCase.SelectedTest.Id);
    if (Criteria != null) {
      PersonalCase.SelectedTracking = await QualityDept_ModelOrder_TrackingBLL
          .GetOrCreate_QualityDept_ModelOrder_Tracking(
              PersonalCase.GetCurrentUser().Id, PersonalCase.SelectedTest.Id);
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetCuttingPastalList(PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return CuttingPastalControl(PersonalCase, snapshot.data[i], () async {
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
                PersonalCase.SelectedTracking.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
            Item.CheckStatus = 1;
            Item.Create_Date = DateTime.now();
            await QualityDept_ModelOrder_TrackingBLL
                .CuttingPastal_ApproveRejectItem(Item);

            setState(() {});
          }, () async {
            CuttingAmountController.text = "";
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
                PersonalCase.SelectedTracking.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
            Item.CheckStatus = 0;
            Item.Create_Date = DateTime.now();

            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(PersonalCase, context, Item),
            );

            setState(() {});
          }, () async {
            var Item = new User_QualityTracking_DetailBLL();
            Item.QualityDept_ModelOrder_Tracking_Id =
                PersonalCase.SelectedTracking.Id;
            Item.Xaxis_QualityItem_Id = snapshot.data[i].Id;
            await QualityDept_ModelOrder_TrackingBLL
                .CuttingPastal_ReOpenCheckItem(Item);
            setState(() {});
          });
        });
  }

  Widget _buildPopupDialog(PersonalCase, BuildContext context, Item) {
    return new AlertDialog(
      title: Text(PersonalCase.GetLable(ResourceKey.RejectNot)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Standard_Input(
            prefixIcon: Icon(Icons.event_note),
            controller: CuttingAmountController,
            Ktype: TextInputType.multiline,
            MinLines: 2,
            MaxLines: 5,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(PersonalCase.GetLable(ResourceKey.Save)),
          onPressed: () async {
            Item.Reject_Note = CuttingAmountController.text;
            await QualityDept_ModelOrder_TrackingBLL
                .CuttingPastal_ApproveRejectItem(Item);
            Navigator.of(context).pop();
            setState(() {});
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(PersonalCase.SelectedTest.Test_Name, PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(
              PersonalCase.SelectedTest.Test_Name +
                  ": " +
                  PersonalCase.SelectedOrder.Order_Number,
              color: ArgonColors.header,
              FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment.Start_Date.toString()),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GetCuttingPastalList(PersonalCase, snapshot);
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
