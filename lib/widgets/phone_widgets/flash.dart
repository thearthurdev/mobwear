import 'package:flutter/material.dart';

class Flash extends StatelessWidget {
  final double width, height, diameter, cornerRadius;

  const Flash({
    this.width,
    this.height,
    this.diameter = 20.0,
    this.cornerRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? diameter,
      height: height ?? diameter,
      decoration: BoxDecoration(
        shape: width == null || height == null
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: width == null || height == null
            ? null
            : BorderRadius.circular(cornerRadius),
        color: Colors.yellow[200],
        border: Border.all(
          color: Colors.grey[200],
          width: 3.0,
        ),
      ),
    );
  }
}
