import 'package:andplus_flutter_7_gui/model/user.dart';
import 'package:flutter/material.dart';

class CrudList extends StatefulWidget {
  CrudList({Key key, this.users, this.onUserSelected}) : super(key: key);

  final List<User> users;

  final SelectUser onUserSelected;

  _CrudListState createState() => _CrudListState();
}

class _CrudListState extends State<CrudList> {
  @override
  Widget build(BuildContext context) {
    widget.users.add(User(firstName: "test", lastName: "last"));
    print(widget.users.length);

    return Container(
      color: Colors.red,
      child: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (BuildContext context, int index) {
          var user = widget.users[index];
          return ListTile(
            key: Key(index.toString()),
            title: Text("${user.firstName} ${user.lastName}"),
          );
        },
      ),
    );
  }
}

typedef void SelectUser(User user);
