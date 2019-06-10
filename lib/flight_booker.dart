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
  int selected = 1;
  bool returnDateValid = true;
  TextEditingController flightDateController;
  TextEditingController returnTextController;

  @override
  void initState() {
    super.initState();
    flightDateController = new TextEditingController(
        text: DateFormat('MM/dd/yyyy').format(DateTime.now()));
    returnTextController = new TextEditingController(
        text: DateFormat('MM/dd/yyyy').format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
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
                        child: Text("One Way"),
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
              TextField(
                controller: flightDateController,
                decoration: InputDecoration(
                    filled: !dateIsValid(flightDateController.text),
                    fillColor: Colors.red),
                keyboardType: TextInputType.datetime,
              ),
              Center(
                child: Text(
                  "T2",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                controller: returnTextController,
                decoration: InputDecoration(
                    filled: !dateIsValid(returnTextController.text),
                    fillColor: Colors.red),
                keyboardType: TextInputType.datetime,
              ),
              RaisedButton(
                onPressed: dateIsValid(returnTextController.text) &&
                        dateIsValid(flightDateController.text)
                    ? () {
                        if (selected == 2) {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                                "You have booked a one-way flight on ${DateFormat("MM.dd.yyyy").format(DateTime.parse(flightDateController.text))}"),
                          ));
                        }
                      }
                    : null,
                child: Text(
                  "Book",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool dateIsValid(String value) {
    if (value.isEmpty) {
      return true;
    }

    DateTime t;
    try {
      t = DateFormat("MM/dd/yyyy").parse(value);
      print(t);
    } catch (e) {}

    try {
      t = DateFormat("MM.dd.yyyy").parse(value);
    } catch (e) {}

    try {
      t = DateFormat("MM-dd-yyyy").parse(value);
    } catch (e) {}

    if (t != null &&
        t.isAfter(DateTime.now().subtract(new Duration(days: 365 * 20)))) {
      return true;
    }

    return false;
  }
}
