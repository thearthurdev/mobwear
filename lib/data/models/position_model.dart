import 'package:flutter/material.dart';

class Position {
  final String name;
  final Alignment alignment;

  Position(this.name, this.alignment);

  static List<Position> myPositions = [
    Position('Center', Alignment.center),
    Position('Left', Alignment.centerLeft),
    Position('Right', Alignment.centerRight),
    Position('Top', Alignment.topCenter),
    Position('Top-left', Alignment.topLeft),
    Position('Top-right', Alignment.topRight),
    Position('Bottom', Alignment.bottomCenter),
    Position('Bottom-left', Alignment.bottomLeft),
    Position('Bottom-right', Alignment.bottomRight),
  ];
}
