import 'package:flutter/material.dart';

class Speaker extends StatelessWidget {
  final double width, height, cornerRadius;
  final BorderRadiusGeometry borderRadius;
  final Color color;

  const Speaker({
    this.width = 32.0,
    this.height = 6.0,
    this.cornerRadius = 6.0,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[900],
        borderRadius: borderRadius == null
            ? BorderRadius.circular(cornerRadius)
            : borderRadius,
      ),
    );
  }
}
