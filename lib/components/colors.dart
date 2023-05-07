import 'dart:typed_data';

import 'package:flutter/material.dart';

var darkBackColor = Colors.grey[850];
var lightBackColor = Colors.grey[100];

var darkTextColor = Colors.black;
var lightTextColor = Colors.white;

var darkBtnRoundColor = Colors.grey[600];
var lightBtnRoundColor = Colors.grey[200];

var routeblueColor = Colors.blue;
var routeredColor = Colors.red;
var routeyellowColor = Colors.yellow[600];
var routegreenColor = Colors.green;

// var mainColor = const Color.fromARGB(255, 21, 197, 220);
var mainColor =  Colors.amber;
var selectColor = const Color.fromARGB(255, 36, 36, 36);
// var selectColor = const Color.fromARGB(255, 255, 248, 225);

//Markers

Future<Uint8List> startMK(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/start_marker.png");

  return byteData.buffer.asUint8List();
}

Future<Uint8List> stopMK(context) async {
  ByteData byteData1 =
      await DefaultAssetBundle.of(context).load("assets/stop_marker.png");

  return byteData1.buffer.asUint8List();
}

Future<Uint8List> greenMK(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/green_marker.png");

  return byteData.buffer.asUint8List();
}

Future<Uint8List> blueMK(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/blue_marker.png");

  return byteData.buffer.asUint8List();
}

Future<Uint8List> greyMK(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/grey_marker.png");

  return byteData.buffer.asUint8List();
}

Future<Uint8List> redMK(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/red_marker.png");

  return byteData.buffer.asUint8List();
}
