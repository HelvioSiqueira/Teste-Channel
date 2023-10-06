import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teste_plugin/teste_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _hearthRate = 'Unknown';
  Map<Object?, Object?>? _location = {};
  final _testePlugin = TestePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String healthRate;
    Map<Object?, Object?>? location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    var statusSensors = await Permission.sensors.status;
    var statusLocation = await Permission.location.status;

    if (statusSensors.isDenied) {
      await Permission.sensors.request();
    }

    if (statusLocation.isDenied) {
      await Permission.location.request();
    }

    while (true) {
      try {
        healthRate = await _testePlugin.getPlatformVersion() ??
            'Unknown platform version';
        location = await _testePlugin.getLocationUpdates() ?? {};
      } on PlatformException {
        healthRate = 'Failed to get platform version.';
        location = {};
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        _hearthRate = healthRate;
        _location = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                Text('Heart Rate: $_hearthRate\n'),
                Text(
                    "Latitude: ${_location!["latitude"]} | Logitude: ${_location!["longitude"]}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
