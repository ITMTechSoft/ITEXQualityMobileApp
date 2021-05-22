import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/DeptModOrderQuality_Items.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/Screens/Home/Standard_List/Standard_Headers.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Cutting_Control extends StatefulWidget {
  @override
  _Cutting_ControlState createState() => _Cutting_ControlState();
}

class _Cutting_ControlState extends State<Cutting_Control> {
  int IntiteStatus = 0;

  Future<List<OrderSizeColorDetailsBLL>> LoadingCutttingControl(
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

  Widget ModelOrderList(
      BuildContext cntx, PersonalProvider PersonalCase, snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int i) {
            return CuttingModelOrderMatrix(PersonalCase, snapshot.data[i],
                () async {
              PersonalCase.SelectedMatrix = snapshot.data[i];
              PersonalCase.SelectedTracking =
                  await QualityDept_ModelOrder_TrackingBLL
                      .GetOrCreate_QualityDept_ModelOrder_Tracking(
                          PersonalCase.GetCurrentUser().Id,
                          PersonalCase.SelectedTest.Id,
                          OrderSizeColorDetail_Id:
                              PersonalCase.SelectedMatrix.Id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Matrix_Cutting_Kontrol()));
            });
          }),
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
          future: LoadingCutttingControl(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ModelOrderMatrixHeader(PersonalCase),
                    ModelOrderList(context, PersonalCase, snapshot),
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

class Matrix_Cutting_Kontrol extends StatefulWidget {
  @override
  _Matrix_Cutting_KontrolState createState() => _Matrix_Cutting_KontrolState();
}

class _Matrix_Cutting_KontrolState extends State<Matrix_Cutting_Kontrol> {
  @override
  int IntiteStatus = 0;

  Future<List<DeptModOrderQuality_ItemsBLL>> LoadingCutttingControl(
      PersonalProvider PersonalCase) async {
    List<DeptModOrderQuality_ItemsBLL> Criteria =
        await DeptModOrderQuality_ItemsBLL.Get_DeptModOrderQuality_Items(
            PersonalCase.GetCurrentUser().Id,
            PersonalCase.SelectedTest.Id,
            PersonalCase.SelectedMatrix.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      Criteria.forEach((element) {
        element.QualityDept_ModelOrder_Tracking_Id =
            PersonalCase.SelectedTracking.Id;
        element.Employee_Id = PersonalCase.GetCurrentUser().Id;
        element.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest.Id;
        element.OrderSizeColorDetail_Id = PersonalCase.SelectedMatrix.Id;
      });
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget AraControlHeader(PersonalProvider PersonalCase) {
    int Percentage = 0;
    if ((PersonalCase.SelectedTracking.Sample_Amount ?? 0) > 0)
      Percentage = ((PersonalCase.SelectedTracking.Error_Amount * 100) /
              PersonalCase.SelectedTracking.Sample_Amount)
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
                      PersonalCase.SelectedMatrix.SizeParam_StringVal,
                      color: ArgonColors.text)),
              Expanded(
                flex: 2,
                child:
                    LableTitle(PersonalCase.GetLable(ResourceKey.TotalControl)),
              ),
              Expanded(
                child: LableTitle(
                    (PersonalCase.SelectedTracking.Sample_Amount ?? 0)
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
                      (PersonalCase.SelectedTracking.Error_Amount ?? 0)
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

  Widget AraKontrolList(snapshot, PersonalCase) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int i) {
            return AraControlCard(snapshot.data[i], () async {
              await PersonalCase.UpdateInformation();
              setState(() {});
            }, PersonalCase);
          }),
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
          future: LoadingCutttingControl(PersonalCase),
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
