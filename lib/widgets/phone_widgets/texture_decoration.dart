import 'package:flutter/material.dart';

DecorationImage textureDecoration({
  @required String texture,
  @required Color textureBlendColor,
  @required BlendMode textureBlendMode,
}) {
  if (texture != null) {
    return DecorationImage(
      image: AssetImage(texture),
      fit: BoxFit.cover,
      colorFilter: textureBlendColor == null
          ? null
          : ColorFilter.mode(
              textureBlendColor,
              textureBlendMode,
            ),
    );
  } else {
    return null;
  }
}
