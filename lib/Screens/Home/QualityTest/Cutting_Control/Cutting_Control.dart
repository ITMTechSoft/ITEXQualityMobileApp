import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/SystemResuableList/Pastal_Cutting_Parti_List.dart';

import 'Size_Matrix_Control.dart';

class Cutting_Control extends StatefulWidget {
  @override
  _Cutting_ControlState createState() => _Cutting_ControlState();
}

class _Cutting_ControlState extends State<Cutting_Control> {
  int IntiteStatus = 0;

  Future<List<Pastal_Cutting_PartiBLL>> LoadingCutttingControl(
      PersonalProvider PersonalCase) async {
    List<Pastal_Cutting_PartiBLL> Criteria =
        await Pastal_Cutting_PartiBLL.Get_Pastal_Cutting_Parti(
            PersonalCase.SelectedOrder!.Order_Id);

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
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    return Scaffold(
      appBar: DetailBar(
          Title: PersonalCase.SelectedTest!.Test_Name??'',
          PersonalCase: PersonalCase,
          OnTap: () {
            Navigator.pop(context);
          },
          context: context),
      body: ListView(children: [
        ListTile(
          title: HeaderTitle(PersonalCase.SelectedOrder!.Order_Number??'',
              color: ArgonColors.header, FontSize: ArgonSize.Header2),
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString()??),
          dense: true,
          selected: true,
        ),
        FutureBuilder(
          future: LoadingCutttingControl(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Pastal_Cutting_Parti_List(
                Items: snapshot.data,
                OnClickItems: (Pastal_Cutting_PartiBLL Item) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Size_Matrix_Control()));
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
