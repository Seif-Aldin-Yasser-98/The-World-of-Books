import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';



class africa extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<africa> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "https://firebasestorage.googleapis.com/v0/b/the-world-of-books-60b2e.appspot.com/o/History%2FNoor-Book.com%20%20%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE%20%D8%A5%D9%81%D8%B1%D9%8A%D9%82%D9%8A%D8%A7%20%D8%A7%D9%84%D8%AD%D8%AF%D9%8A%D8%AB%20%D9%88%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%B5%D8%B1%20%D8%A7%D9%84%D9%83%D8%B4%D9%88%D9%81%20%D8%A7%D9%84%D8%A7%D8%B3%D8%AA%D8%B9%D9%85%D8%A7%D8%B1%20%D8%A7%D9%84%D8%A5%D8%B3%D8%AA%D9%82%D9%84%D8%A7%D9%84%20%D9%81%D8%B1%D8%BA%D9%84%D9%8A%20%D8%B9%D9%84%D9%89%20%D8%AA%D8%B3%D9%86%20%D9%87%D8%B1%D9%8A%D8%AF%D9%8A%203%20.pdf?alt=media&token=73edbd30-ea2d-46d0-8b73-fcd100e6c102";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,centerTitle: true,title: SizedBox(
        child:  Image.asset("images/pics/logo.png"),),),
      body: Container(width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/pics/africa.jpg"),fit: BoxFit.fill,
          )
        ),
        child: Column(
          children: <Widget>[SizedBox(height: 500),
            Container( child: RaisedButton(padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 48),
              color: Colors.black,
              splashColor: Colors.grey,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.grey),
              ),
              child: Text("Enjoy",style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontStyle: FontStyle.italic,
                  color: Colors.white,fontSize: 25)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
              ),
            ),)
          ],
        )

      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(

        path: pathPDF);
  }
}