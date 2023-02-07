import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_id_recognition/flutter_id_recognition.dart';
import 'package:flutter_id_recognition/flutter_id_recognition_platform_interface.dart';
import 'package:flutter_id_recognition/flutter_id_recognition_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIdRecognitionPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIdRecognitionPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future getIDNum() => Future.value({'idNum': '4315345423'});
}

void main() {
  final FlutterIdRecognitionPlatform initialPlatform =
      FlutterIdRecognitionPlatform.instance;

  test('$MethodChannelFlutterIdRecognition is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIdRecognition>());
  });

  test('getPlatformVersion', () async {
    FlutterIdRecognition flutterIdRecognitionPlugin = FlutterIdRecognition();
    MockFlutterIdRecognitionPlatform fakePlatform =
        MockFlutterIdRecognitionPlatform();
    FlutterIdRecognitionPlatform.instance = fakePlatform;

    expect(await flutterIdRecognitionPlugin.getPlatformVersion(), '42');
  });
}
