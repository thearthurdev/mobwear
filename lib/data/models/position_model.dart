import 'package:flutter/material.dart';

class MyPosition {
  final String name;
  final Alignment alignment;

  MyPosition(this.name, this.alignment);

  static List<MyPosition> myPositions = [
    MyPosition('Center', Alignment.center),
    MyPosition('Left', Alignment.centerLeft),
    MyPosition('Right', Alignment.centerRight),
    MyPosition('Top', Alignment.topCenter),
    MyPosition('Top-left', Alignment.topLeft),
    MyPosition('Top-right', Alignment.topRight),
    MyPosition('Bottom', Alignment.bottomCenter),
    MyPosition('Bottom-left', Alignment.bottomLeft),
    MyPosition('Bottom-right', Alignment.bottomRight),
  ];
}
