import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_faro/flutter_faro.dart';
import 'package:flutter_faro/flutter_faro_platform_interface.dart';
import 'package:flutter_faro/flutter_faro_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFaroPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFaroPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFaroPlatform initialPlatform = FlutterFaroPlatform.instance;

  test('$MethodChannelFlutterFaro is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFaro>());
  });

  test('getPlatformVersion', () async {
    FlutterFaro flutterFaroPlugin = FlutterFaro();
    MockFlutterFaroPlatform fakePlatform = MockFlutterFaroPlatform();
    FlutterFaroPlatform.instance = fakePlatform;

    expect(await flutterFaroPlugin.getPlatformVersion(), '42');
  });
}
