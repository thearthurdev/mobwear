import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class ColorPickerButton extends StatelessWidget {
  final String colorName;
  final Color color;
  final Function onPressed;

  const ColorPickerButton({
    @required this.colorName,
    @required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Brightness brightness = kThemeBrightness(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          colorName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Righteous',
            color: brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        FittedBox(
          child: GestureDetector(
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: color,
                  border: Border.all(
                    color: brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: brightness == Brightness.dark
                          ? Colors.black
                          : Colors.grey[300],
                      offset: Offset(5, 5),
                      spreadRadius: 2.0,
                      blurRadius: 10.0,
                    )
                  ]),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [
                          color.computeLuminance() > 0.335
                              ? Colors.black12
                              : Colors.white12,
                          Colors.transparent
                        ],
                        stops: [0.2, 0.2],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: onPressed,
          ),
        ),
      ],
    );
  }
}
