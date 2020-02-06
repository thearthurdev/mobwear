import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding, margin;

  const ElevatedCard({
    this.child,
    this.color,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color == null
            ? kBrightnessAwareColor(context,
                lightColor: Colors.white, darkColor: Colors.grey[900])
            : color,
        boxShadow: [
          BoxShadow(
            color: kBrightnessAwareColor(context,
                lightColor: Colors.blueGrey.withOpacity(0.2),
                darkColor: Colors.black26),
            blurRadius: 10.0,
            offset: Offset(5.0, 6.0),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
