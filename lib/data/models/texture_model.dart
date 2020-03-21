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
    MyTexture(name: 'Blots', asset: 'assets/textures/blobs1.jpg'),
    MyTexture(name: 'Boxes', asset: 'assets/textures/boxes1.jpg'),
    MyTexture(name: 'Burberry', asset: 'assets/textures/burberry1.jpg'),
    MyTexture(name: 'Hexi', asset: 'assets/textures/hexagons1.jpg'),
    MyTexture(name: 'Leather', asset: 'assets/textures/leather1.jpg'),
    MyTexture(name: 'Leaves', asset: 'assets/textures/leaves1.jpg'),
    MyTexture(name: 'Brushed', asset: 'assets/textures/metal1.jpg'),
    MyTexture(name: 'Bronze', asset: 'assets/textures/metal2.jpg'),
    MyTexture(name: 'Foil', asset: 'assets/textures/metal3.jpg'),
    MyTexture(name: 'Polka', asset: 'assets/textures/polka1.jpg'),
    MyTexture(name: 'Psych', asset: 'assets/textures/psych1.jpg'),
    MyTexture(name: 'Tartan', asset: 'assets/textures/tartan1.jpg'),
    MyTexture(name: 'Vintage', asset: 'assets/textures/vintage1.jpg'),
    MyTexture(name: 'Paint', asset: 'assets/textures/wall1.jpg'),
    MyTexture(name: 'Wavy', asset: 'assets/textures/wavy1.jpg'),
    MyTexture(name: 'Wood 1', asset: 'assets/textures/wood1.jpg'),
    MyTexture(name: 'Wood 2', asset: 'assets/textures/wood2.jpg'),
    MyTexture(name: 'Wood 3', asset: 'assets/textures/wood4.jpg'),
    MyTexture(name: 'Wood 4', asset: 'assets/textures/wood5.jpg'),
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
