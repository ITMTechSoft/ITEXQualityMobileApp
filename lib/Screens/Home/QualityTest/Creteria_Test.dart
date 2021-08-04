import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';

import 'package:itex_soft_qualityapp/Models/Criteria_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:timer_button/timer_button.dart';

class Criteria_Test extends StatefulWidget {
  @override
  _Criteria_TestState createState() => _Criteria_TestState();
}

class _Criteria_TestState extends State<Criteria_Test> {
  int IntiteStatus = 0;
  bool IsUserApproved;
  int WaitSYC = 1;

  //PDFViewController _pdfViewController;

  Future<Criteria_ModelOrderBLL> LoginFunction(
      PersonalProvider PersonalCase) async {
    var Critiera = await Criteria_ModelOrderBLL.Get_Criteria_ModelOrder(
        PersonalCase.SelectedTest.Id);

    IsUserApproved = await PersonalCase.SelectedTest.IsUserApprovedBefore(
        Employee_Id: PersonalCase.GetCurrentUser().Id);
    if (Critiera != null) WaitSYC = (Critiera.WaitTimeSNY ?? 0 / 100).toInt();

    var Item = new QualityDept_ModelOrder_TrackingBLL();
    Item.Employee_Id = PersonalCase.GetCurrentUser().Id;
    Item.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest.Id;
    bool IsReading = await Item.SetReadValidationAction();

    if (Critiera != null) {
      IntiteStatus = 1;
    } else {
      IntiteStatus = -1;
    }
    return Critiera;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);

    return Scaffold(
      appBar: DetailBar(
          PersonalCase.GetLable(ResourceKey.CriteriaTest), PersonalCase, () {
        Navigator.pop(context);
      }),
      body: ListView(
        children: [
          ListTile(
            title: HeaderTitle(PersonalCase.SelectedOrder.Order_Number,
                color: ArgonColors.header, FontSize: ArgonSize.Header),
            subtitle:
                Text(PersonalCase.SelectedDepartment.Start_Date.toString()),
            dense: true,
            selected: true,
          ),
          FutureBuilder(
            future: LoginFunction(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      !IsUserApproved
                          ? TimerButton(
                              label:
                                  PersonalCase.GetLable(ResourceKey.Validation),
                              activeTextStyle: TextStyle(
                                fontSize: ArgonSize.WidthSmall,
                                color: ArgonColors.initial,
                              ),
                              disabledTextStyle: TextStyle(
                                  fontSize: ArgonSize.WidthSmall,
                                  color: ArgonColors.Title),
                              timeOutInSeconds: WaitSYC > 0 ? WaitSYC : 1,
                              onPressed: () async {
                                bool IsValidated = await PersonalCase
                                        .SelectedTest
                                    .SetValidationAction(
                                        Employee_Id:
                                            PersonalCase.GetCurrentUser().Id);
                                if (IsValidated) Navigator.pop(context);
                              },
                              buttonType: ButtonType.FlatButton,
                              disabledColor: Colors.deepOrange,
                              color: ArgonColors.success,
                            )
                          : Container(),
                      Html(
                        data: snapshot.data.HTML_Data ?? "",
                      ),
                    ],
                  ),
                );
              } else if (IntiteStatus == 0)
                return Center(child: CircularProgressIndicator());
              else
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                    MessageError: PersonalCase.GetLable(
                        ResourceKey.ErrorWhileLoadingData),
                    DetailError: PersonalCase.GetLable(
                        ResourceKey.InvalidNetWorkConnection));
            },
          )
        ],
      ),
    );
  }
}

/*
class MyPDFViewr extends StatefulWidget {
  Uint8List data;

  MyPDFViewr({this.data});

  @override
  _MyPDFViewrState createState() => _MyPDFViewrState();
}

class _MyPDFViewrState extends State<MyPDFViewr> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              title: const Text('Pdf_render example app'),
            ),
            backgroundColor: Colors.grey,
            // You can use either PdfViewer.openFile, PdfViewer.openAsset, or PdfViewer.openData
            body: PdfViewer.openFile(
              "http://www.orimi.com/pdf-test.pdf",
              params: PdfViewerParams(pageNumber: 0), // show the page
            )));
  }
}
*/
/*

class MyPDFViewr extends StatefulWidget {
  Uint8List data;

  MyPDFViewr({this.data});

  @override
  _MyPDFViewrState createState() => _MyPDFViewrState();
}


class _MyPDFViewrState extends State<MyPDFViewr> {
  int IntiteStatus = 0;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      new AppBar(
        title: new Text('View PDF'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),


      body: PDFView(
        pdfData: widget.data,
        //   autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        onError: (e) {
          print(e);
        },
        onRender: (_pages) {
          setState(() {
            _totalPages = _pages;
            pdfReady = true;
          });
        },
        onViewCreated: (PDFViewController vc) {
          _pdfViewController = vc;
        },
        onPageChanged: (int page, int total) {
          setState(() {});
        },
        onPageError: (page, e) {},
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: ArgonColors.warning,
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                  label: Text("Go To ${_currentPage - 1}"))
              : Offstage(),
          _currentPage < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: ArgonColors.success,
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                  label: Text("Go To ${_currentPage + 1}"))
              : Offstage()
        ],
      ),
    );
  }
}
*/
