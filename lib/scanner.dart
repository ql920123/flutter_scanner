import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'scanner_image.dart';

import 'scanner_platform_interface.dart';

const String _methodChannelIdentifier = 'scanner';

class Scanner extends StatefulWidget{
  final Function(ScannedImage) onDocumentScanned;
  final bool noGrayScale;
  const Scanner({super.key,
    required this.onDocumentScanned,
    this.noGrayScale = true,
  });
  Future<String?> getPlatformVersion() {
    return ScannerPlatform.instance.getPlatformVersion();
  }
  final MethodChannel _channel = const MethodChannel(_methodChannelIdentifier);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScannerState();
  }

}
class _ScannerState extends State<Scanner> {
  @override
  void initState() {
    print("initializing document scanner state");
    widget._channel.setMethodCallHandler(_onDocumentScanned);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: _methodChannelIdentifier,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: _getParams(),
      );
    } else if (Platform.isIOS) {
      print("platform ios");
      return UiKitView(
        viewType: _methodChannelIdentifier,
        creationParams: _getParams(),
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      throw ("Current Platform is not supported");
    }
  }

  Future<dynamic> _onDocumentScanned(MethodCall call) async {
    if (call.method == "onPictureTaken") {
      Map<String, dynamic> argsAsMap =
      Map<String, dynamic>.from(call.arguments);
      ScannedImage scannedImage = ScannedImage.fromMap(argsAsMap);
      if (scannedImage.croppedImage != null) {
        widget.onDocumentScanned(scannedImage);
      }
    }

    return;
  }

  Map<String, dynamic> _getParams() {
    Map<String, dynamic> allParams = {
      "noGrayScale": widget.noGrayScale,
    };

    Map<String, dynamic> nonNullParams = {};
    allParams.forEach((key, value) {
      if (value != null) {
        nonNullParams.addAll({key: value});
      }
    });

    return nonNullParams;
  }

}