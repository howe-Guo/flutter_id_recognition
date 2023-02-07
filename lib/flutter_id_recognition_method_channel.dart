import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_id_recognition_platform_interface.dart';

/// An implementation of [FlutterIdRecognitionPlatform] that uses method channels.
class MethodChannelFlutterIdRecognition extends FlutterIdRecognitionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_id_recognition');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<dynamic> getIDNum() async {
    final idMap = await methodChannel.invokeMethod<dynamic>('getIDNum');
    return idMap;
  }
}
