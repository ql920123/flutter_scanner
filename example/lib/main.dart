import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:scanner/scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/scanner_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  File? scannedDocument;
  Future<PermissionStatus>? cameraPermissionFuture;

  @override
  void initState() {
    super.initState();
    cameraPermissionFuture = Permission.camera.request();
  }

  Future<PermissionStatus> requestCamera() async{
    return Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Scanner app'),
          ),
          body: FutureBuilder<PermissionStatus>(
            future: requestCamera(),
            builder: (BuildContext context,
                AsyncSnapshot<PermissionStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data! == PermissionStatus.granted) {
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: scannedDocument != null
                                ? Image(
                              image: FileImage(scannedDocument!),
                            )
                                : Scanner(
                              // documentAnimation: false,
                              noGrayScale: true,
                              onDocumentScanned:
                                  (ScannedImage scannedImage) {
                                print("document : " +
                                    scannedImage.croppedImage!);

                                setState(() {
                                  scannedDocument = scannedImage
                                      .getScannedDocumentAsFile();
                                  // imageLocation = image;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      scannedDocument != null
                          ? Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: ElevatedButton(
                            child: Text("retry"),
                            onPressed: () {
                              setState(() {
                                scannedDocument = null;
                              });
                            }),
                      )
                          : Container(),
                    ],
                  );
                } else {
                  Permission.camera.request();
                  return const Center(
                    child: Text("camera permission denied"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
