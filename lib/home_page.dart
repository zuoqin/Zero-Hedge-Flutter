import 'package:flutter/material.dart';
import 'package:zerohedge/zhlistview.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Open Webpage"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ZHListView(
                  title: "Alligator.io",
                  selectedUrl: "https://alligator.io",
                )));
          },
        ),
      ),
    );
  }
}
