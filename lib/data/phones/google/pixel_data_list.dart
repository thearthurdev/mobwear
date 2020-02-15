import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

List<PhoneDataModel> pixelDataList = [
  PhoneDataModel(
    id: 0100,
    colors: {
      'Glossy Panel': Colors.white,
      'Matte Panel': Colors.grey[300],
      'Antenna Bands': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.grey[400],
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
      'Antenna Bands': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0101,
    colors: {
      'Glossy Panel': Colors.black,
      'Matte Panel': Colors.grey[900],
      'Fingerprint Sensor': Colors.grey[900],
      'Google Logo': Colors.black,
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0102,
    colors: {
      'Glossy Panel': Colors.black,
      'Matte Panel': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.black,
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0103,
    colors: {
      'Glossy Panel': Colors.white,
      'Matte Panel': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.black,
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0104,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.deepOrange[500],
      'Google Logo': Colors.deepOrange[600],
      'Bezels': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
