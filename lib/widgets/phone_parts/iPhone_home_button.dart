import 'package:flutter/material.dart';

class IPhoneHomeButton extends StatelessWidget {
  final double diameter, trimWidth;
  final Color buttonColor, trimColor, backPanelColor;
  final bool hasElevation, hasSquare;

  const IPhoneHomeButton({
    this.diameter = 40.0,
    this.trimWidth = 2.0,
    this.buttonColor = Colors.white,
    this.trimColor,
    this.hasElevation = false,
    this.backPanelColor = Colors.black,
    this.hasSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      child: FittedBox(
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
            border: Border.all(
              color: trimColor ?? buttonColor.computeLuminance() > 0.335
                  ? Colors.grey[300]
                  : Colors.grey[800],
              width: trimWidth,
            ),
            boxShadow: hasElevation
                ? [
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black26
                          : Colors.black38,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                    )
                  ]
                : null,
          ),
          child: hasSquare
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: diameter - 20.0,
                      height: diameter - 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: buttonColor,
                        border: Border.all(
                          color: buttonColor.computeLuminance() > 0.335
                              ? Colors.grey[300]
                              : Colors.grey[800],
                          width: 2.0,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
