import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

List<PhoneDataModel> galaxyDataList = [
  PhoneDataModel(
    id: 0300,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.blue[700],
      'Samsung Logo': Colors.white60,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0301,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.red[800],
      'Samsung Logo': Colors.black54,
      'Bezels': Colors.black87,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
