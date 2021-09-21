import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sumann_barometer_plugin/sumann_barometer_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('sumann_barometer_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SumannBarometerPlugin.platformVersion, '42');
  });
}
