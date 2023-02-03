import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_id_recognition_method_channel.dart';

abstract class FlutterIdRecognitionPlatform extends PlatformInterface {
  /// Constructs a FlutterIdRecognitionPlatform.
  FlutterIdRecognitionPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIdRecognitionPlatform _instance = MethodChannelFlutterIdRecognition();

  /// The default instance of [FlutterIdRecognitionPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIdRecognition].
  static FlutterIdRecognitionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIdRecognitionPlatform] when
  /// they register themselves.
  static set instance(FlutterIdRecognitionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
