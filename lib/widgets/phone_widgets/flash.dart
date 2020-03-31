import 'package:flutter/material.dart';

class Flash extends StatelessWidget {
  final double diameter, height;

  const Flash({this.diameter = 20.0, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: height ?? diameter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.yellow[200],
        border: Border.all(
          color: Colors.grey[200],
          width: 3.0,
        ),
      ),
    );
  }
}
