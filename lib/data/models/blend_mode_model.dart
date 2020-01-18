import 'package:flutter/material.dart';

class MyBlendMode {
  final String name;
  final BlendMode mode;

  MyBlendMode(this.name, this.mode);
}

List<MyBlendMode> myBlendModes = [
  MyBlendMode('None', null),
  MyBlendMode('Color', BlendMode.color),
  MyBlendMode('Burn', BlendMode.colorBurn),
  MyBlendMode('Dodge', BlendMode.colorDodge),
  MyBlendMode('Invert', BlendMode.difference),
  MyBlendMode('Exclude', BlendMode.exclusion),
];
