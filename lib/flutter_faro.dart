
import 'flutter_faro_platform_interface.dart';

class FlutterFaro {
  Future<String?> getPlatformVersion() {
    return FlutterFaroPlatform.instance.getPlatformVersion();
  }
}
