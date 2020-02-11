import 'dart:ui';

class MyBlendMode {
  String name;
  BlendMode mode;

  MyBlendMode(this.name, this.mode);

  static List<MyBlendMode> myBlendModes = [
    MyBlendMode('None', BlendMode.dst),
    MyBlendMode('Color', BlendMode.color),
    MyBlendMode('Burn', BlendMode.colorBurn),
    MyBlendMode('Dodge', BlendMode.colorDodge),
    MyBlendMode('Invert', BlendMode.difference),
    MyBlendMode('Exclude', BlendMode.exclusion),
  ];
}
