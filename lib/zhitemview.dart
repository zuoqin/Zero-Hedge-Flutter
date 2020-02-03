import 'dart:async';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ZHItemView extends StatelessWidget {
  final String title;
  final String body;
  final String updated;
  final String reference;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  ZHItemView({
    @required this.title,
    @required this.body,
    @required this.updated,
    @required this.reference,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child :WebView(
            initialUrl: reference,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          )
        )
    );
  }
}