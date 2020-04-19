import 'package:flutter/material.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';

class HeartRateSensor extends StatelessWidget {
  final double width, height, borderWidth, cornerRadius, dotSize, flashSize;
  final Color color, borderColor, dot23Colors, dot1Color;
  final bool hasFlash;

  const HeartRateSensor({
    this.width,
    this.height,
    this.borderWidth,
    this.cornerRadius,
    this.dotSize,
    this.flashSize,
    this.color,
    this.borderColor,
    this.dot1Color,
    this.dot23Colors,
    this.hasFlash = false,
  });

  Container dot({Color color}) {
    return Container(
      width: dotSize ?? 5.0,
      height: dotSize ?? 5.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dot23Colors ?? color ?? Colors.grey[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: width ?? 8.0,
        height: height ?? 20.0,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[800],
          borderRadius: BorderRadius.circular(cornerRadius ?? 2.0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: hasFlash
                      ? Flash(diameter: flashSize ?? null)
                      : dot(color: dot1Color ?? Colors.grey[500]),
                ),
              ),
              Flexible(
                flex: 3,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(cornerRadius - 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        dot(),
                        dot(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
