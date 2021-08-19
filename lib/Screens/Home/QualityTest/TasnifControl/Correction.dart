import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itex_soft_qualityapp/Models/User_QualityTracking_Detail.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';

class Tasnif_Correction extends StatefulWidget {
  @override
  _Tasnif_CorrectionState createState() => _Tasnif_CorrectionState();
}

class _Tasnif_CorrectionState extends State<Tasnif_Correction> {
  int IntiteStatus = 0;

  Future<List<User_QualityTracking_DetailBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<User_QualityTracking_DetailBLL> Criteria =
    await User_QualityTracking_DetailBLL
        .Get_UserQualityTasnifControl(
       PersonalCase.SelectedTest!.Id

    );

    if (Criteria != null) {
      IntiteStatus = 1;
      return Criteria;
    } else {
      IntiteStatus = -1;
    }
    return null;
  }

  Widget GetTansifCorrectionList(
      context, PersonalProvider PersonalCase, snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data.length,
        itemBuilder: (context, int i) {
          return TasnifCorrectionList(context,PersonalCase, snapshot.data[i],
              (){
                setState(() {
                  final snackBar = SnackBar(
                      content: Text("Edited Successfuly "));

                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);
                });
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

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
              FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString()??'',
              style:TextStyle(fontSize:ArgonSize.Header6)),
          dense: true,
          selected: true,
        ),
        SizedBox(height:ArgonSize.Padding4),

        FutureBuilder(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: ArgonSize.Padding3),

                child: GetTansifCorrectionList(context,PersonalCase, snapshot),
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
