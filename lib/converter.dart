import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  Converter({this.title});

  final String title;

  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  TextEditingController farenheitTextController = new TextEditingController();
  TextEditingController celsiusTextController = new TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Farenheit",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                controller: farenheitTextController,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    setState(() {
                      celsiusTextController.text = "";
                    });
                    return;
                  }

                  setState(() {
                    celsiusTextController.text =
                        calculateCelsius(double.parse(value)).toString();
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Text(
                    "Celsius",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              TextField(
                controller: celsiusTextController,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    setState(() {
                      farenheitTextController.text = "";
                    });
                    return;
                  }

                  setState(() {
                    farenheitTextController.text =
                        calculateFarenheit(double.parse(value)).toString();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // C = (F - 32) * (5/9)
  double calculateCelsius(double farenheight) {
    return (farenheight - 32) * (5 / 9);
  }

  // F = C * (9/5) + 32
  double calculateFarenheit(double celsius) {
    return celsius * (9 / 5) + 32;
  }
}
