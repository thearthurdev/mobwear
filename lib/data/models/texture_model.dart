import 'package:flutter/material.dart';

class MyTexture {
  String name;
  String asset;
  Color blendColor;
  BlendMode blendMode;

  MyTexture({
    this.name,
    this.asset,
    this.blendColor = Colors.deepOrange,
    this.blendMode,
  });
}

List<MyTexture> myTextures = [
  MyTexture(name: 'Camo 1', asset: 'assets/textures/camo1.jpg'),
  MyTexture(name: 'Camo 2', asset: 'assets/textures/camo2.jpg'),
  MyTexture(name: 'Jeans', asset: 'assets/textures/jeans1.jpg'),
];
