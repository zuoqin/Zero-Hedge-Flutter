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

  Choice _selectedChoice = choices[0]; // The app's "state".
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search ZH' );
  final _controller1 = TextEditingController();
  var issearch = false;
  String search_text = '';

  void _handleSubmitted(String value) {
    issearch = true;
    search_text = value;

    API.searchItems(value, "0").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        zhitems = list.map((model) => ZHItem.fromJson(model)).toList();
      });
    });
  }

  void _select(Choice choice) {
    if(choice.title == "Home") {
      _getitems("0");
    }
    else {

      _getitems(choice.title.substring(5));
    }
  }

  _getitems(page) {
    if(issearch && page != 0 && page != '0'){
      API.searchItems(search_text, page).then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          zhitems = list.map((model) => ZHItem.fromJson(model)).toList();
        });
      });
    } else{
      issearch = false;
      API.getItems(page).then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          zhitems = list.map((model) => ZHItem.fromJson(model)).toList();
        });
      });
    }
  }

  _getitem(reference) {

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
          child: Container(
            margin: const EdgeInsets.only(top: 5.0),
            child :Html(
              data: zhitem.title,
              backgroundColor: Colors.blueAccent,
              defaultTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
            Container(
              child: zhitem.picture == null ? null : Image.network(zhitem.picture),
            )
          ]
      ),
      Flexible(
      child:Column(
        children: [
          Container(
            child: GestureDetector(

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
          )

        ]
      )
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


  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {

        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextFormField(
          textInputAction: TextInputAction.next,
          onFieldSubmitted: _handleSubmitted,
          controller: _controller1,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search ZH' );
        _controller1.clear();
      }
    });
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          leading: new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,

          ),
          actions: <Widget>[

            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Home', icon: Icons.directions_boat),
  const Choice(title: 'Page 1', icon: Icons.directions_bus),
  const Choice(title: 'Page 2', icon: Icons.directions_railway),
  const Choice(title: 'Page 3', icon: Icons.directions_walk),
];
