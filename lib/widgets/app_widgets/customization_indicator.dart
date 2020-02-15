import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class CustomizationIndicator extends StatelessWidget {
  final Color color, textureBlendColor;
  final String texture;
  final BlendMode textureBlendMode;
  final double size;
  final bool isSelected;

  const CustomizationIndicator({
    this.color = Colors.transparent,
    this.size,
    this.texture,
    this.isSelected = false,
    this.textureBlendColor = Colors.transparent,
    this.textureBlendMode = BlendMode.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 45.0,
      height: size ?? 45.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: kBrightnessAwareColor(context,
              lightColor: Colors.grey[300], darkColor: Colors.grey[800]),
        ),
        image: texture == null
            ? null
            : DecorationImage(
                image: AssetImage(texture),
                fit: BoxFit.cover,
                colorFilter: textureBlendMode == null
                    ? null
                    : ColorFilter.mode(
                        textureBlendColor,
                        textureBlendMode,
                      ),
              ),
      ),
      child: texture == null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                gradient: LinearGradient(
                  colors: [
                    color.computeLuminance() > 0.335
                        ? Colors.black.withOpacity(0.15)
                        : Colors.white.withOpacity(0.2),
                    Colors.transparent
                  ],
                  stops: [0.2, 0.2],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            )
          : isSelected
              ? Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 1.6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    child: Icon(
                      LineAwesomeIcons.check_circle,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
    );
  }
}
