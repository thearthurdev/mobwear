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
    MyTexture(name: 'Camo 3', asset: 'assets/textures/camo3.jpg'),
    MyTexture(name: 'Camo 4', asset: 'assets/textures/camo4.jpg'),
    MyTexture(name: 'Carbon 1', asset: 'assets/textures/carbon1.jpg'),
    MyTexture(name: 'Carbon 2', asset: 'assets/textures/carbon2.jpg'),
    MyTexture(name: 'Concrete 1', asset: 'assets/textures/concrete1.jpg'),
    MyTexture(name: 'Concrete 2', asset: 'assets/textures/concrete2.jpg'),
    MyTexture(name: 'Jeans', asset: 'assets/textures/jeans1.jpg'),
    MyTexture(name: 'Leather 1', asset: 'assets/textures/leather1.jpg'),
    MyTexture(name: 'Leather 2', asset: 'assets/textures/leather2.jpg'),
    MyTexture(name: 'Marble 1', asset: 'assets/textures/marble1.jpg'),
    MyTexture(name: 'Marble 2', asset: 'assets/textures/marble2.jpg'),
    MyTexture(name: 'Marble 3', asset: 'assets/textures/marble3.jpg'),
    MyTexture(name: 'Brushed', asset: 'assets/textures/metal1.jpg'),
    MyTexture(name: 'Bronze', asset: 'assets/textures/metal2.jpg'),
    MyTexture(name: 'Foil', asset: 'assets/textures/metal3.jpg'),
    MyTexture(name: 'Wood 1', asset: 'assets/textures/wood1.jpg'),
    MyTexture(name: 'Wood 2', asset: 'assets/textures/wood2.jpg'),
    MyTexture(name: 'Wood 3', asset: 'assets/textures/wood3.jpg'),
  ];

  static List<Image> textureAssets = [];

  static void loadTextureAssets(BuildContext context) {
    textureAssets.clear();
    for (MyTexture texture in myTextures) {
      textureAssets.add(Image.asset(texture.asset));
    }
  }

  static Future<void> precacheTextureAssets(BuildContext context) async {
    for (Image asset in textureAssets) {
      await precacheImage(asset.image, context);
    }
  }
}
