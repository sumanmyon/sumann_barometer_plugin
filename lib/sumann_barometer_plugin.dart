
import 'dart:async';

import 'package:flutter/services.dart';

class SumannBarometerPlugin {
  static const MethodChannel _channel =
      const MethodChannel('sumann_barometer_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<double> get reading async {
    final double reading = await _channel.invokeMethod('getBarometer');
    return reading;
  }

  static Future<bool> initialize() async {
    final bool init = await _channel.invokeMethod('initializeBarometer');
    return init;
  }
}
