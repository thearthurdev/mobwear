import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'texture_model.g.dart';

@HiveType(typeId: 1)
class MyTexture {
  @HiveField(0)
  String name;
  @HiveField(1)
  String asset;
  @HiveField(2)
  Color blendColor;
  @HiveField(3)
  int blendModeIndex;

  MyTexture({
    this.name,
    this.asset,
    this.blendColor = Colors.deepOrange,
    this.blendModeIndex = 0,
  });

  static List<MyTexture> myTextures = [
    MyTexture(name: 'Camo 1', asset: 'assets/textures/camo1.jpg'),
    MyTexture(name: 'Camo 2', asset: 'assets/textures/camo2.jpg'),
    MyTexture(name: 'Jeans', asset: 'assets/textures/jeans1.jpg'),
  ];

  static List<Image> textureAssets = [];

  static void loadTextureAssets(BuildContext context) {
    textureAssets.clear();
    for (MyTexture texture in myTextures) {
      textureAssets.add(Image.asset(texture.asset));
    }
  }

  static void precacheTextureAssets(BuildContext context) {
    for (Image asset in textureAssets) {
      precacheImage(asset.image, context);
    }
  }
}
