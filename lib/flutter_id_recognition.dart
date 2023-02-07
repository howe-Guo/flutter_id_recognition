import 'flutter_id_recognition_platform_interface.dart';

class FlutterIdRecognition {
  Future<String?> getPlatformVersion() {
    return FlutterIdRecognitionPlatform.instance.getPlatformVersion();
  }

  Future<dynamic> getIDNum() {
    return FlutterIdRecognitionPlatform.instance.getIDNum();
  }
}
