import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zerohedge/zhitem.dart';
import 'package:zerohedge/API.dart';
import 'package:zerohedge/zhlistitem.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';

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

  initState() {
    super.initState();
    _getitems();
  }

  dispose() {
    super.dispose();
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
            return Container(
                child: Html(
                    data: zhitems[index].title
                  )
            );
          },
        ));
  }
}