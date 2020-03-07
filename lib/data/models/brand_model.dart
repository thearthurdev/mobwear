import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';

class BrandIcon {
  IconData icon;
  double size;

  BrandIcon({
    this.icon,
    this.size,
  });

  static List<BrandIcon> brandIcons = [
    BrandIcon(icon: BrandIcons.google),
    BrandIcon(icon: BrandIcons.apple),
    BrandIcon(icon: BrandIcons.samsung1),
    BrandIcon(icon: BrandIcons.huawei),
    BrandIcon(icon: BrandIcons.oneplus),
    BrandIcon(icon: BrandIcons.xiaomi),
    BrandIcon(icon: BrandIcons.htc),
    BrandIcon(icon: BrandIcons.lg),
    BrandIcon(icon: BrandIcons.motorola),
    BrandIcon(icon: BrandIcons.nokia, size: 30.0),
  ];

  static List<BrandIcon> watermarkIcons =
      [BrandIcon(icon: CustomIcons.mobwear, size: 30.0)] + brandIcons;
}

class BrandModel {
  final String brandName;
  final BrandIcon brandIcon;

  BrandModel(this.brandName, this.brandIcon);

  static List<String> brandNames = [
    'Google',
    'Apple',
    'Samsung',
    'Huawei',
    'OnePlus',
    'Xiaomi',
    'HTC',
    'LG',
    'Motorola',
    'Nokia',
  ];

  static List<BrandModel> brands = List.generate(brandNames.length, (i) {
    return BrandModel(brandNames[i], BrandIcon.brandIcons[i]);
  });
}
