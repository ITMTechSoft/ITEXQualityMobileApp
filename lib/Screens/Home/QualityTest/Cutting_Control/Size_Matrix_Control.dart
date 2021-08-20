import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/ModelOrderSizes.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/LableText.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'Cutting_Kontrol_List.dart';

class Size_Matrix_Control extends StatefulWidget {
  @override
  _Size_Matrix_ControlState createState() => _Size_Matrix_ControlState();
}

class _Size_Matrix_ControlState extends State<Size_Matrix_Control> {
  int IntiteStatus = 0;

  Future<List<ModelOrderSizesBLL>?> LoadingOpenPage(
      PersonalProvider PersonalCase) async {
    List<ModelOrderSizesBLL>? Criteria =
        await ModelOrderSizesBLL.Get_ModelOrderSizes_CuttingControl(
            PersonalCase.SelectedTest!.Order_Id!, PersonalCase.SelectedTest!.Id);

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
          subtitle: Text(PersonalCase.SelectedDepartment!.Start_Date.toString()),
          dense: true,
          selected: true,
        ),
        FutureBuilder<List<ModelOrderSizesBLL>?>(
          future: LoadingOpenPage(PersonalCase),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Size_Matrix_List(
                      OnClickItems: (int Index) async {
                        PersonalCase.SelectedSize = snapshot.data![Index];
                        PersonalCase.SelectedTracking =
                            await QualityDept_ModelOrder_TrackingBLL
                                .GetOrCreate_QualityDept_ModelOrder_Tracking(
                                    PersonalCase.GetCurrentUser().Id,
                                    PersonalCase.SelectedTest!.Id,
                                    ModelOrderSizes_Id:
                                        PersonalCase.SelectedSize!.Id,
                                    Pastal_Cutting_Parti_Id:
                                        CaseProvider.SelectedPastal!.Id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Cutting_Kontrol_List()));
                      },
                      Items: snapshot.data!,
                      Headers: <Widget>[
                        HeaderLable(PersonalCase.GetLable(ResourceKey.SizeName),
                            Flex: 1),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Sample_Amount),
                            Flex: 1),
                        HeaderLable(
                            PersonalCase.GetLable(ResourceKey.Error_Amount),
                            Flex: 1),
                      ],

                    ),
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

class Size_Matrix_List extends StatefulWidget {
  List<ModelOrderSizesBLL> Items;
  Function OnClickItems;
  List<Widget> Headers;

  Size_Matrix_List({required this.Headers, required this.Items,required this.OnClickItems});

  @override
  _Size_Matrix_ListState createState() => _Size_Matrix_ListState();
}

class _Size_Matrix_ListState extends State<Size_Matrix_List> {
  int SelectedIndex = -1;

  Widget GetStatusIcon(int Status) {
    if (Status == 1)
      return Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.check_circle_rounded,
              color: ArgonColors.success,
            ),
          )
        ],
      );
    else
      return Row(
        children: [
          ClipOval(
            child: Icon(
              Icons.brightness_1_outlined,
              color: ArgonColors.warning,
            ),
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderColumn(
            children: widget.Headers,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.Items.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        if (widget.OnClickItems != null) widget.OnClickItems(i);
                        setState(() {
                          SelectedIndex = i;
                        });
                      },
                      child: TableColumn(children: [
                        TableLable(
                            widget.Items[i].SizeParam_StringVal.toString(),
                            Flex: 1),
                        TableLable(
                            (widget.Items[i].Sample_Amount ?? 0).toString(),
                            Flex: 1),
                        TableLable(
                            (widget.Items[i].Error_Amount ?? 0).toString(),
                            Flex: 1),
                      ], IsSelectedItem: SelectedIndex == i),
                    );
                  }))
        ]);
  }
}
