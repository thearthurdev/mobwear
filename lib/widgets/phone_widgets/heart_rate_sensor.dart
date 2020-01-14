import 'package:flutter/material.dart';

class HeartRateSensor extends StatelessWidget {
  Container dot({Color color}) {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.grey[900],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            dot(color: Colors.grey[500]),
            dot(),
            dot(),
          ],
        ),
      ),
    );
  }
}
