import 'dart:async';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:zerohedge/zhitem.dart';

class ZHListItemView extends StatelessWidget {
  final ZHItem zhitem;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  ZHListItemView({
    @required this.zhitem
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl: zhitem.title,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}