import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/custom_icons/custom_icons.dart';

enum PickerMode { color, texture, image }

class ModePickerModel {
  final PickerMode pickerMode;
  final Icon icon;
  final String modeName;

  ModePickerModel(this.pickerMode, this.icon, this.modeName);
}

List<ModePickerModel> pickerModes = [
  ModePickerModel(
    PickerMode.color,
    Icon(CustomIcons.color_palette_alt, size: 17.0),
    'a color',
  ),
  ModePickerModel(
    PickerMode.texture,
    Icon(CustomIcons.texture_wood_alt, size: 20),
    'a texture',
  ),
  ModePickerModel(
    PickerMode.image,
    Icon(LineAwesomeIcons.image),
    'an image',
  ),
];
