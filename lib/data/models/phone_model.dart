import 'package:flutter/material.dart';
import 'package:mobware/data/models/texture_model.dart';

class PhoneModel {
  ///id will be in the format ##,## => brandIndex,phoneIndex without the comma
  final int id;
  final dynamic phone;
  final Map<String, Color> colors;
  final Map<String, MyTexture> textures;

  PhoneModel({
    this.id,
    this.phone,
    this.colors,
    this.textures,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['phone'] = phone;
    map['colors'] = colors;
    map['textures'] = textures;
    return map;
  }
}
