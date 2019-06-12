import 'package:andplus_flutter_7_gui/model/user.dart';
import 'package:flutter/material.dart';
import 'crud_form.dart';
import 'crud_list.dart';

class Crud extends StatefulWidget {
  Crud({Key key, this.title}) : super(key: key);

  final String title;

  _CrudContainerState createState() => _CrudContainerState();
}

class _CrudContainerState extends State<Crud> {
  List<User> users;

  @override
  Widget build(BuildContext context) {
    users = <User>[User(firstName: "First", lastName: "Last")];

    return Material(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CrudForm(
                      onUserAdded: (User user) {
                        setState(() {
                          users.add(user);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Text("Test"),
                  ),
                  Expanded(
                    flex: 3,
                    child: CrudList(onUserSelected: (user) {}, users: users),
                  )
                ],
              ),
        ),
      ),
    );
  }
}
