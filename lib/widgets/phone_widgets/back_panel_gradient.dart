import 'package:flutter/material.dart';

class BackPanelGradient extends StatelessWidget {
  final Color backPanelColor, borderColor;
  final double width, height, cornerRadius;
  final double gradientDarkness, gradientSideLightness;
  final List<double> stops;
  final BorderRadiusGeometry borderRadius;

  const BackPanelGradient({
    @required this.backPanelColor,
    @required this.stops,
    this.width,
    this.height,
    this.gradientDarkness,
    this.gradientSideLightness,
    this.borderRadius,
    this.borderColor,
    this.cornerRadius = 20.0,
  }) : assert(stops.length == 8);

  @override
  Widget build(BuildContext context) {
    Color gradientBlackColor = Colors.black.withOpacity(
      gradientDarkness == null
          ? backPanelColor.computeLuminance() > 0.335 ? 0.08 : 0.15
          : gradientDarkness,
    );

    Color gradientSideColor = Colors.white.withOpacity(
      gradientSideLightness == null
          ? backPanelColor.computeLuminance() > 0.335 ? 0.06 : 0.1
          : gradientSideLightness,
    );

    return Stack(
      children: <Widget>[
        Container(
          width: width ?? 238.0,
          height: height ?? 476.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: borderColor ?? gradientBlackColor,
            ),
            borderRadius: borderRadius == null
                ? BorderRadius.circular(cornerRadius)
                : borderRadius,
            gradient: LinearGradient(
              colors: [
                gradientSideColor,
                gradientBlackColor,
                Colors.black.withOpacity(0.001),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.001),
                gradientBlackColor,
                gradientSideColor,
              ],
              stops: stops,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Container(
          width: width ?? 238.0,
          height: height ?? 476.0,
          decoration: BoxDecoration(
            borderRadius: borderRadius == null
                ? BorderRadius.circular(cornerRadius)
                : borderRadius,
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.001),
                gradientBlackColor,
              ],
              stops: [0.0, 0.2, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
