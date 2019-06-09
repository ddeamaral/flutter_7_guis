import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({this.title});

  final String title;

  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    const TextStyle listItemStyle =
        TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
    const double iconSize = 40;

    List<Widget> menuItems = <Widget>[
      ListTile(
        key: Key("1"),
        leading:
            Icon(Icons.plus_one, size: iconSize, color: Colors.yellow[800]),
        title: Text(
          "Counter",
          style: listItemStyle,
        ),
        onTap: () {
          Navigator.pushNamed(context, "/counter");
        },
      ),
      ListTile(
        key: Key("2"),
        leading: Icon(
          Icons.autorenew,
          size: iconSize,
          color: Colors.blue,
        ),
        title: Text(
          "Converter",
          style: listItemStyle,
        ),
        onTap: () {
          Navigator.pushNamed(context, "/converter");
        },
      ),
      ListTile(
        key: Key("3"),
        leading: Icon(
          Icons.alarm,
          size: iconSize,
          color: Colors.red,
        ),
        title: Text(
          "Timer",
          style: listItemStyle,
        ),
        onTap: () {
          Navigator.pushNamed(context, "/timer");
        },
      )
    ];

    return Material(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return menuItems[index];
            },
            itemCount: menuItems.length,
          ),
        ),
      ),
    );
  }
}
