import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';

enum PickerMode { color, texture, image }

class ModePickerModel {
  final PickerMode pickerMode;
  final Icon icon;
  final String modeName;

  ModePickerModel(this.pickerMode, this.icon, this.modeName);

  static List<ModePickerModel> myPickerModes = [
    ModePickerModel(
      PickerMode.color,
      Icon(CustomIcons.color_palette_alt, size: 20.0),
      'a color',
    ),
    ModePickerModel(
      PickerMode.texture,
      Icon(CustomIcons.texture_wood_alt, size: 24),
      'a texture',
    ),
    ModePickerModel(
      PickerMode.image,
      Icon(LineAwesomeIcons.image, size: 26),
      'an image',
    ),
  ];
}
