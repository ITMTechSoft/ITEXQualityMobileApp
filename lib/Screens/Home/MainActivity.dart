import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Employee_Department.dart';
import 'package:itex_soft_qualityapp/ProviderCase/ProviderCase.dart';
import 'package:itex_soft_qualityapp/Screens/Home/OrderList.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';


import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../Wrapper.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int IntiteStatus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Employee_DepartmentBLL>> LoadDepartment(
      PersonalProvider PersonalCase) async {
    try {
      var Items = await Employee_DepartmentBLL.Get_EmployeeDepartment(
          PersonalCase.GetCurrentUser().Id);
      if(Items !=null)
        IntiteStatus = 1;
      else
        IntiteStatus = -1;
      return Items;
    } catch (Excption) {}
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    return Scaffold(
        appBar: MainBar(PersonalCase),
        body: FutureBuilder(
            future: LoadDepartment(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    margin: EdgeInsets.all(ArgonSize.MainMargin),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: HeaderTitle("Department",
                              color: ArgonColors.header,
                              FontSize: ArgonSize.Header),

                          dense: true,
                          selected: true,
                        ),

                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int i) {
                              return DepartmentCard(snapshot.data[i],
                                  () {
                                    PersonalCase.SelectedDepartment = snapshot.data[i];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OrderList()));
                                  });
                            }),
                      ],
                    ));
              } else
              if(IntiteStatus == 0)
                return Center(child: CircularProgressIndicator());
              else
                return ErrorPage(
                    ActionName: "Loading Orders",
                    MessageError:"Error While Loading",
                    DetailError:"Please Check Connections");
            }));
  }
}
