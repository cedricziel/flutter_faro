import 'dart:async';

import 'package:faro_dart/faro_dart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_faro/src/flutter_faro_settings.dart';
import 'package:flutter_faro/src/resource_detector.dart';
import 'package:meta/meta.dart';

typedef SettingsConfiguration = FutureOr<void> Function(FlutterFaroSettings);

typedef AppRunner = FutureOr<void> Function();

mixin FlutterFaro {
  static const _channel = MethodChannel('flutter_faro');

  static init(
    SettingsConfiguration settingsConfiguration, {
    AppRunner? appRunner,
    @internal MethodChannel channel = _channel,
    @internal ResourceDetector? resourceDetector,
  }) async {
    final flutterFaroSettings = FlutterFaroSettings();

    if (resourceDetector != null) {
      flutterFaroSettings.resourceDetector = resourceDetector;
    }

    await Faro.init(
      (settings) async {
        await settingsConfiguration(settings as FlutterFaroSettings);
      },
      appRunner: appRunner,
      // ignore: invalid_use_of_internal_member
      settings: flutterFaroSettings,
    );
  }

  static void pushLog(String s) {
    Faro.pushLog(s);
  }

  static pushView(String view) {
    Faro.pushView(view);
  }

  static pushEvent(String name, Map<String, String> attributes) {
    Faro.pushEvent(Event(name, attributes: attributes));
  }

  static pushMeasurement(String name, num value) {
    Faro.pushMeasurement(name, value);
  }

  static pushException(Object error, {StackTrace? stackTrace}) {
    Faro.pushError(error, stackTrace: stackTrace);
  }
}
