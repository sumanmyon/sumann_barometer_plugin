import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sumann_barometer_plugin/sumann_barometer_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _reading = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      final reading = await SumannBarometerPlugin.initialize();
      print("Reading-------> ${reading}");
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Latest reading: $_reading'),
              RaisedButton(
                child: Text("Get Barometer reading"),
                onPressed: () async {
                  final reading = await SumannBarometerPlugin.reading;
                  print("Reading-------> ${reading}");
                  setState(() {
                    _reading = reading;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
