import 'package:flutter/material.dart';

class Flash extends StatelessWidget {
  final double diameter;

  const Flash({this.diameter = 20.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellow[200],
        border: Border.all(
          color: Colors.grey[200],
          width: 3.0,
        ),
      ),
    );
  }
}
