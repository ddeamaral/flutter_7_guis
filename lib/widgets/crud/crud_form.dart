import 'package:andplus_flutter_7_gui/model/user.dart';
import 'package:flutter/material.dart';

class CrudForm extends StatefulWidget {
  CrudForm({Key key, this.onUserAdded}) : super(key: key);

  void Function(User user) onUserAdded;

  _CrudFormState createState() => _CrudFormState();
}

class _CrudFormState extends State<CrudForm> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => Container(
              color: Colors.blueAccent[100],
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "First Name",
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "First name is required";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    user.firstName = value;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Last Name",
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Last name is required";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    user.lastName = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text(
                          "Save",
                        ),
                        splashColor: Colors.blueGrey,
                        onPressed: () {
                          widget.onUserAdded(
                            new User(firstName: "test", lastName: "last"),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
