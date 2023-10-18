import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_card_scanner/scanner_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScannerPlatform
    with MockPlatformInterfaceMixin
    implements ScannerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScannerPlatform initialPlatform = ScannerPlatform.instance;

  // test('$MethodChannelScanner is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelScanner>());
  // });
  //
  // test('getPlatformVersion', () async {
  //   Scanner scannerPlugin = Scanner();
  //   MockScannerPlatform fakePlatform = MockScannerPlatform();
  //   ScannerPlatform.instance = fakePlatform;
  //
  //   expect(await scannerPlugin.getPlatformVersion(), '42');
  // });
}
