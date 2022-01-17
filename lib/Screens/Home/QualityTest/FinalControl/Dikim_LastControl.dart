import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/OrderSizeColorDetails.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/OrderSizeColorMatrix.dart';
import 'FinalControl.dart';

class Dikim_LastControl extends StatefulWidget {
  @override
  _Dikim_LastControlState createState() => _Dikim_LastControlState();
}

class _Dikim_LastControlState extends State<Dikim_LastControl> {
  int IntiteStatus = 0;

  Future<List<OrderSizeColorDetailsBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<OrderSizeColorDetailsBLL>? Critiera =
        await OrderSizeColorDetailsBLL.Get_FinalOrderSizeColorDetails(
            Order_Id :  PersonalCase.SelectedOrder!.Order_Id,
            DeptModelOrder_QualityTest_Id :PersonalCase.SelectedTest!.Id );

    if (Critiera != null) {
      IntiteStatus = 1;
      return Critiera;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: DetailBar(Title:PersonalCase.SelectedTest!.Test_Name??'',PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(

                  PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header,
              FontSize: ArgonSize.Header3),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString() ,
              style: TextStyle(fontSize:ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        SizedBox(height:ArgonSize.Padding3),

        FutureBuilder<List<OrderSizeColorDetailsBLL>?>(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return OrderSizeColorMatrix(
                PersonalCase: PersonalCase,
                Items: snapshot.data,
                OnClickItems: (int Index) async {
                  CaseProvider.ModelOrderMatrix = snapshot.data![Index];
                  CaseProvider.QualityTracking = await QualityDept_ModelOrder_TrackingBLL.GetOrCreate_QualityDept_ModelOrder_Tracking(
                      PersonalCase.GetCurrentUser().Id,
                      PersonalCase.SelectedTest!.Id,
                      OrderSizeColorDetail_Id:  CaseProvider.ModelOrderMatrix!.Id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinalControl()));
                },
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
