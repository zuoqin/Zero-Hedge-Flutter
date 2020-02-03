import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zerohedge/zhitem.dart';
import 'package:zerohedge/API.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class ZHListView extends StatelessWidget {
  @override
  createState() => _ZHListScreenState();
}

class _ZHListScreenState extends State {
  var zhitems = new List<ZHItem>();

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
          title: Text("User List"),
        ),
        body: ListView.builder(
          itemCount: zhitems.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(zhitems[index].title));
          },
        ));
  }
}