import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_faro_method_channel.dart';

abstract class FlutterFaroPlatform extends PlatformInterface {
  /// Constructs a FlutterFaroPlatform.
  FlutterFaroPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFaroPlatform _instance = MethodChannelFlutterFaro();

  /// The default instance of [FlutterFaroPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFaro].
  static FlutterFaroPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFaroPlatform] when
  /// they register themselves.
  static set instance(FlutterFaroPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
