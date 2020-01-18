import 'package:flutter/material.dart';
import 'package:mobware/data/models/texture_model.dart';

class PhoneModel {
  final dynamic phone;
  final Map<String, Color> colors;
  final Map<String, MyTexture> textures;

  PhoneModel({
    this.phone,
    this.colors,
    this.textures,
  });
}
