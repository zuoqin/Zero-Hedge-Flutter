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


  _getitems(page) {
    API.getItems(page).then((response) {
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
    _getitems("0");
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

  Widget _buildStoryTitle(zhitem) => Row(
    children: [
      GestureDetector(
          child: Html(
            data: zhitem.title,
            backgroundColor: Colors.blueAccent,
            defaultTextStyle: TextStyle(color: Colors.white),
          ),

          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZHItemView(
                reference: "https://zh.eliz.club/story?url=" + zhitem.reference,
                title: zhitem.title,
                updated: zhitem.updated,
                body: ''
            ))
            );
          })
    ],
  );

  Widget _buildStoryIntroduction(zhitem) => Row(
    children: [
      Column(
          children: [
            Image.network(zhitem.picture)
          ]
      ),
      Column(
        children: [
          GestureDetector(
              child: Html(
                data: zhitem.introduction,
              ),

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZHItemView(
                    reference: "https://zh.eliz.club/story?url=" + zhitem.reference,
                    title: zhitem.title,
                    updated: zhitem.updated,
                    body: ''
                ))
                );
              })
        ]
      )

    ],
  );

  
  Widget _buildStoryUpdate(zhitem) => Row(
    children: [
      Html(
        data: zhitem.updated,
      ),
    ],
  );

  
  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ZH"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {_getitems("0");},
              child: Text("Home"),
            ),
            FlatButton(
              textColor: Colors.white,
              onPressed: () {_getitems("1");},
              child: Text("Page 1"),
            ),
            FlatButton(
              textColor: Colors.white,
              onPressed: () {_getitems("2");},
              child: Text("Page 2"),
            ),
            FlatButton(
              textColor: Colors.white,
              onPressed: () {_getitems("3");},
              child: Text("Page 3"),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: zhitems.length,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
                  children: [
                    _buildStoryTitle(zhitems[index]),
                    _buildStoryIntroduction(zhitems[index]),
                    _buildStoryUpdate(zhitems[index])
                  ]
                )
            );
          },
        ));
  }
}