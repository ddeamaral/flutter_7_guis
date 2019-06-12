import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Requirements:
//    T2 is enabled if return flight is selected
//      When 'Return Flight' is selected, and T2 is before T1's date, book button is disabled
//    When either T is invalid, background is red, and b is disabled

class FlightBooker extends StatefulWidget {
  FlightBooker({this.title});

  final String title;

  _FlightBookerState createState() => _FlightBookerState();
}

class _FlightBookerState extends State<FlightBooker> {
  int selected = 2;
  bool formValid = true;
  TextEditingController flightDateController;
  TextEditingController returnTextController;
  String t1 = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String t2 = DateFormat('MM/dd/yyyy').format(DateTime.now());
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) => Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DropdownButton(
                      value: selected,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          child: Center(child: Text("Return Flight")),
                          value: 1,
                        ),
                        DropdownMenuItem(
                            child: Center(
                              child: Text("One-Way flight"),
                            ),
                            value: 2)
                      ],
                      isExpanded: true,
                      onChanged: (item) {
                        setState(() {
                          selected = item;
                        });
                      },
                    ),
                    Center(
                      child: Text(
                        "T1",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      initialValue:
                          DateFormat('MM/dd/yyyy').format(DateTime.now()),
                      validator: (value) {
                        if (!dateIsValid(value)) {
                          return "Please enter a valid date";
                        }

                        return null;
                      },
                      onSaved: (value) => setState(() {
                            t1 = value;
                          }),
                      decoration: InputDecoration(
                          filled: !dateIsValid(t1), fillColor: Colors.red),
                      keyboardType: TextInputType.datetime,
                    ),
                    Center(
                      child: Text(
                        "T2",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      initialValue:
                          DateFormat('MM/dd/yyyy').format(DateTime.now()),
                      validator: (value) {
                        if (!dateIsValid(value)) {
                          return "Please enter a valid date";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        filled: !dateIsValid(t2),
                        fillColor: Colors.red,
                      ),
                      onSaved: (value) => setState(() {
                            t2 = value;
                          }),
                      keyboardType: TextInputType.datetime,
                      enabled: selected == 1,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (selected == 2 && _key.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: new Text(
                                "You have booked a one-way flight on ${DateFormat("MM.dd.yyyy").format(tryParse(t1))}"),
                          ));
                        }
                      },
                      child: Text(
                        "Book",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  bool dateIsValid(String value) {
    DateTime t = tryParse(value);

    if (t != null && t.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }

    return false;
  }

  DateTime tryParse(String value) {
    DateTime t;
    try {
      t = DateFormat("MM/dd/yyyy").parse(value);
    } catch (e) {}

    try {
      t = DateFormat("MM.dd.yyyy").parse(value);
    } catch (e) {}

    try {
      t = DateFormat("MM-dd-yyyy").parse(value);
    } catch (e) {}

    return t;
  }

  void isFormValid() {
    DateTime t = dateIsValid(flightDateController.text)
        ? tryParse(flightDateController.text)
        : null;
    DateTime t2 = dateIsValid(returnTextController.text)
        ? tryParse(flightDateController.text)
        : null;

    bool returnFlightValid =
        !(selected == 1 && t != null && t2 != null && t2.isBefore(t));
    bool oneWayFlightValid = selected == 2 && t != null;

    setState(() {
      formValid = returnFlightValid || oneWayFlightValid;
    });
  }
}
