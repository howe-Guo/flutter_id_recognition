import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_id_recognition/flutter_id_recognition.dart';
import 'package:flutter_id_recognition_example/check_permission.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Map<String, String> _mapID = {"name": "howeGuo", "idNum": "610321"};
  final _flutterHuaweiMlPlugin = FlutterIdRecognition();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterHuaweiMlPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getIDNum() async {
    Map<String, String> mapID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var res = await _flutterHuaweiMlPlugin.getIDNum() ?? {};
      mapID = Map<String, String>.from(res);
    } on PlatformException {
      mapID = {"": ""};
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mapID = mapID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  CheckPermission.checkPermission(
                    permissions: [Permission.camera, Permission.storage],
                    onOpenSetting: () {
                      openAppSettings();
                    },
                    onFailed: () {},
                    onSuccess: getIDNum,
                  );
                },
                child: Text('scan'),
              ),
              Text("${_mapID["name"]}+${_mapID["idNum"]}"),
              Text('Running on: $_platformVersion\n')
            ],
          ),
        ),
      ),
    );
  }
}
