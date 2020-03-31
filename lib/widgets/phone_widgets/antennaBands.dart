import 'package:flutter/material.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/texture_decoration.dart';

class AntennaBands {
  static Widget antennaBandCurved(
    Alignment alignment,
    Color color,
    double bandHeight,
    double bandWidth,
    double bandThickness,
  ) {
    return Align(
      alignment: alignment,
      child: BackPanel(
        backPanelColor: Colors.transparent,
        noShadow: true,
        width: bandWidth ?? 245.0,
        height: bandHeight ?? 42.0,
        bezelsWidth: bandThickness ?? 5.0,
        bezelsColor: color,
        borderRadius: alignment == Alignment.topCenter
            ? BorderRadius.only(
                topLeft: Radius.circular(34.0),
                topRight: Radius.circular(34.0),
              )
            : BorderRadius.only(
                bottomLeft: Radius.circular(34.0),
                bottomRight: Radius.circular(34.0),
              ),
      ),
    );
  }

  static Widget antennaBandHorizontal(
    Color color,
    String texture,
    Color blendColor,
    BlendMode blendMode,
    double height,
    double width,
    bool hasTexture,
  ) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 5.0,
      color: hasTexture ? null : color,
      decoration: hasTexture
          ? BoxDecoration(
              color: color,
              image: textureDecoration(
                texture: texture,
                textureBlendColor: blendColor,
                textureBlendMode: blendMode,
              ),
            )
          : null,
    );
  }

  static Widget antennaBandVertical(
    Color color,
    String texture,
    Color blendColor,
    BlendMode blendMode,
    double height,
    double width,
    bool hasTexture,
  ) {
    return Container(
      height: height ?? 40.0,
      width: width ?? 6.0,
      color: hasTexture ? null : color,
      decoration: hasTexture
          ? BoxDecoration(
              color: color,
              image: textureDecoration(
                texture: texture,
                textureBlendColor: blendColor,
                textureBlendMode: blendMode,
              ),
            )
          : null,
    );
  }
}
