import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

import 'Tasnif_NewSample.dart';
import 'Tasnsif_SampleControl.dart';

class Tasnif_Control extends StatefulWidget {
  @override
  _Tasnif_ControlState createState() => _Tasnif_ControlState();
}

class _Tasnif_ControlState extends State<Tasnif_Control> {
  int IntiteStatus = 0;

  Future<List<QualityDept_ModelOrder_TrackingBLL>> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<QualityDept_ModelOrder_TrackingBLL> Criteria =
        await QualityDept_ModelOrder_TrackingBLL
            .Get_QualityDept_ModelOrder_Tracking(
                PersonalCase.SelectedOrder.Order_Id,
                PersonalCase.SelectedTest.Id);

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetTansifControlList(
      context, PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return TansifControlList(PersonalCase, snapshot.data[i], () async {
            PersonalCase.SelectedTracking = snapshot.data[i];
            if(PersonalCase.SelectedTracking.Status == ControlStatus.TansifControlOpenStatus) {
              var value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Tasnsif_SampleControl()));
              setState(() {
                print(value);
              });
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(Title:PersonalCase.SelectedTest.Test_Name,PersonalCase: PersonalCase, OnTap:() {
        Navigator.pop(context);
      },
          context:  context
      ),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(

                  PersonalCase.SelectedOrder.Order_Number,
              color: ArgonColors.header,
              FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment.Start_Date.toString(),
              style:TextStyle(fontSize:ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        SizedBox(height:ArgonSize.Padding4),

        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding:  EdgeInsets.only(left: ArgonSize.Padding3,right:ArgonSize.Padding4),
                          child: StandardButton(
              FontSize:ArgonSize.Header5,
                              Lable:
                                  PersonalCase.GetLable(ResourceKey.CreateTasnifSample),
                              ForColor: ArgonColors.white,
                              BakColor: ArgonColors.primary,
                              OnTap: () async {
                                PersonalCase.SelectedMatrix = null;
                                var value = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tasnif_NewSample(
                                            DeptModelOrder_QualityTest_Id:
                                                PersonalCase.SelectedTest.Id)));
                                setState(() {
                                  print(value);
                                });
                              }),
                        ),
                      ),

                      Expanded(
                        flex:1,
                        child: Padding(
                          padding:  EdgeInsets.only(right: ArgonSize.Padding3,left:ArgonSize.Padding4),
                          child: StandardButton(
                              FontSize:ArgonSize.Header5,

                              Lable:
                              PersonalCase.GetLable(ResourceKey.Correction),
                              ForColor: ArgonColors.white,
                              BakColor: ArgonColors.myGreen,
                              OnTap: () async {

                              }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height:ArgonSize.Padding4),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),

                    child: GetTansifControlList(context,PersonalCase, snapshot),
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
          },
        )
      ]),
    );
  }
}
