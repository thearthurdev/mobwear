import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

List<PhoneDataModel> pixelDataList = [
  PhoneDataModel(
    id: 0100,
    colors: {
      'Glossy Panel': Colors.white,
      'Matte Panel': Colors.grey[200],
      'Antenna Bands': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.grey[300],
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
      'Glossy Panel': Color(0xFFBACCD9),
      'Matte Panel': Color(0xFFBFD1DF),
      'Fingerprint Sensor': Color(0xFFBFD1DF),
      'Google Logo': Color(0xFFB6C7D4),
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
      'Matte Panel': Color(0xFFFCFCFC),
      'Fingerprint Sensor': Color(0xFFFCFCFC),
      'Google Logo': Colors.grey[300],
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0103,
    colors: {
      'Glossy Panel': Color(0xFFF8E7E7),
      'Matte Panel': Color(0xFFFAEDED),
      'Fingerprint Sensor': Color(0xFFFAEDED),
      'Google Logo': Color(0xFFF5DAD5),
      'Bezels': Color(0xFFF5EAE8),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0104,
    colors: {
      'Glossy Panel': Color(0xFFE1E4F7),
      'Matte Panel': Color(0xFFE3E6FA),
      'Fingerprint Sensor': Color(0xFFE3E6FA),
      'Google Logo': Color(0xFFD8D8F0),
      'Bezels': Color(0xFFD8D8F0),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0105,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Color(0xFFF5795D),
      'Google Logo': Color(0xFFF36355),
      'Bezels': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
