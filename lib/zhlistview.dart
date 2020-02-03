import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zerohedge/zhitem.dart';
import 'package:zerohedge/API.dart';
import 'package:zerohedge/zhitemview.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:zerohedge/zhsingleitem.dart';

class ZHListView extends StatefulWidget {
  @override
  createState() => _ZHListScreenState();
}

class _ZHListScreenState extends State {
  var zhitems = new List<ZHItem>();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();


  _getitems() {
    API.getItems().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        zhitems = list.map((model) => ZHItem.fromJson(model)).toList();
      });
    });
  }

  _getitem(reference) {
    debugPrint('666666' + reference);
    API.getStory(reference).then((response) {
      debugPrint('777777' + response.body);
      Map<String, dynamic> zhitem = json.decode(response.body)[0];
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZHItemView(
        body: zhitem['body'],
        title: zhitem['title'],
        updated: zhitem['updated'],
      ))
      );
    });
  }

  initState() {
    super.initState();
    _getitems();
  }

  dispose() {
    super.dispose();
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zero Hedge"),
        ),
        body: ListView.builder(
          itemCount: zhitems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: Html(
                    data: ("<div class=\"row\"><div class=\"col-xs-4\"><img src=" + zhitems[index].picture + "></div><div class=\"col-xs-4\">" +
                    zhitems[index].title + "</div></div>")
                  ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZHItemView(
                    reference: "https://zh.eliz.club/story?url=" + zhitems[index].reference,
                    title: zhitems[index].title,
                    updated: zhitems[index].updated,
                    body: ''
                  ))
                  );
                },
            );
          },
        ));
  }
}