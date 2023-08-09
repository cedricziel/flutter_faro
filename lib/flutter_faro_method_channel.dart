import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_faro_platform_interface.dart';

/// An implementation of [FlutterFaroPlatform] that uses method channels.
class MethodChannelFlutterFaro extends FlutterFaroPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_faro');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
