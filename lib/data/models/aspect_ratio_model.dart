import 'package:flutter/material.dart';

class MyAspectRatio {
  final String name;
  final double ratio;

  MyAspectRatio({
    this.name,
    this.ratio,
  });

  static List<MyAspectRatio> myAspectRatios(BuildContext context) {
    List<MyAspectRatio> aspectRatios = [
      MyAspectRatio(name: '1:1', ratio: 1.0 / 1.0),
      MyAspectRatio(name: '16:9', ratio: 16.0 / 9.0),
      MyAspectRatio(name: '9:16', ratio: 9.0 / 16.0),
      MyAspectRatio(name: '18:9', ratio: 18.0 / 9.0),
      MyAspectRatio(name: '9:18', ratio: 9.0 / 18.0),
    ];
    return aspectRatios;
  }
}
