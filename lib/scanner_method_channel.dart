import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'scanner_platform_interface.dart';

/// An implementation of [ScannerPlatform] that uses method channels.
class MethodChannelScanner extends ScannerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('scanner');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
