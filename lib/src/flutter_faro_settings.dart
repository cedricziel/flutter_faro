import 'package:faro_dart/faro_dart.dart';
import 'package:flutter_faro/src/resource_detector.dart';

class FlutterFaroSettings extends FaroSettings {
  ResourceDetector? resourceDetector;

  FlutterFaroSettings({Uri? collectorUrl}): super(collectorUrl: collectorUrl);
}
