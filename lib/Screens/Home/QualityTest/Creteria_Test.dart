import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';

import 'package:itex_soft_qualityapp/Models/Criteria_ModelOrder.dart';
import 'package:itex_soft_qualityapp/Models/QualityDept_ModelOrder_Tracking.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';


class Criteria_Test extends StatefulWidget {
  @override
  _Criteria_TestState createState() => _Criteria_TestState();
}

class _Criteria_TestState extends State<Criteria_Test> {
  int IntiteStatus = 0;

  //PDFViewController _pdfViewController;

  Future<String> LoginFunction(PersonalProvider PersonalCase) async {
    var Critiera = await Criteria_ModelOrderBLL.Get_Criteria_ModelOrder(
        PersonalCase.SelectedTest.Id);
    String data = "";

    var Item = new QualityDept_ModelOrder_TrackingBLL();
    Item.Employee_Id = PersonalCase.GetCurrentUser().Id;
    Item.DeptModelOrder_QualityTest_Id = PersonalCase.SelectedTest.Id;
    bool IsReading = await Item.SetReadValidationAction();

    if (Critiera != null) {
      IntiteStatus = 1;
      data = Critiera;
    } else {
      IntiteStatus = -1;
    }
    return data;
  }
  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);



    return Scaffold(
        appBar:DetailBar(Title:PersonalCase.SelectedTest.Test_Name,PersonalCase: PersonalCase, OnTap:() {
          Navigator.pop(context);
        },
            context:  context
        ),
        body: ListView(
          children: [
            ListTile(
              title: HeaderTitle(
                  PersonalCase.SelectedTest.Test_Name + ": " + PersonalCase.SelectedOrder.Order_Number,
                  color: ArgonColors.header,
                  FontSize: ArgonSize.Header),
              subtitle: Text(PersonalCase
                  .SelectedDepartment.Start_Date
                  .toString()),
              dense: true,
              selected: true,
            ),
            FutureBuilder(
            future: LoginFunction(PersonalCase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HTMLViewPage(snapshot.data);
              } else if (IntiteStatus == 0)
                return Center(child: CircularProgressIndicator());
              else
                return ErrorPage(
                    ActionName: PersonalCase.GetLable(ResourceKey.Loading),
                    MessageError: PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
                    DetailError: PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));
            },
          )],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ArgonColors.success,
          label: Text(PersonalCase.GetLable(ResourceKey.Validation)),
          onPressed: () async{
            bool IsValidated  = await PersonalCase.SelectedTest.SetValidationAction(
                Employee_Id: PersonalCase.GetCurrentUser().Id
            );
            if(IsValidated)
              Navigator.pop(context);
          },
        ));
  }
}

HTMLViewPage(htmlData) {
  return SingleChildScrollView(
    child: Html(
      data: htmlData,
//Optional parameters:
      customImageRenders: {
        networkSourceMatcher(domains: ["flutter.dev"]):
            (context, attributes, element) {
          return FlutterLogo(size: 36);
        },
        networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
          headers: {"Custom-Header": "some-value"},
          altWidget: (alt) => Text(alt),
          loadingWidget: () => Text("Loading..."),
        ),
// On relative paths starting with /wiki, prefix with a base url
        (attr, _) => attr["src"] != null && attr["src"].startsWith("/wiki"):
            networkImageRender(
                mapUrl: (url) => "https://upload.wikimedia.org" + url),
// Custom placeholder image for broken links
        networkSourceMatcher():
            networkImageRender(altWidget: (_) => FlutterLogo()),
      },
    /*  onLinkTap: (url) {
        print("Opening $url...");
      },
      onImageTap: (src) {
        print(src);
      },*/
      onImageError: (exception, stackTrace) {
        print(exception);
      },
    ),
  );
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
