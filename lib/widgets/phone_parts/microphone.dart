import 'package:flutter/material.dart';

class Microphone extends StatelessWidget {
  final double diameter;

  const Microphone({this.diameter = 6.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[900],
      ),
    );
  }
}
