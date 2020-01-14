import 'package:flutter/material.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/custom_icons/custom_icons.dart';

enum PickerMode { color, image, texture }

class ModePickerModel {
  final PickerMode pickerMode;
  final Icon icon;

  ModePickerModel(this.pickerMode, this.icon);
}

List<ModePickerModel> pickerModes = [
  ModePickerModel(
    PickerMode.color,
    Icon(CustomIcons.color_palette_alt, size: 17.0),
  ),
  // ModePickerModel(
  //   PickerMode.image,
  //   Icon(LineAwesomeIcons.image),
  // ),
  // ModePickerModel(
  //   PickerMode.texture,
  //   Icon(CustomIcons.texture_wood_alt, size: 20),
  // ),
];
