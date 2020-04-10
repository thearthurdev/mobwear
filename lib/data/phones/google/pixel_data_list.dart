import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

List<PhoneDataModel> pixelDataList = [
  PhoneDataModel(
    id: 0200,
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
    id: 0201,
    colors: {
      'Glossy Panel': Color(0xFFBACCD9),
      'Matte Panel': Color(0xFFBFD1DF),
      'Fingerprint Sensor': Color(0xFFBFD1DF),
      'Google Logo': Color(0xFFB6C7D4),
      'Power Button': Color(0xFF02AE8B),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0202,
    colors: {
      'Glossy Panel': Colors.black,
      'Matte Panel': Color(0xFFFCFCFC),
      'Fingerprint Sensor': Color(0xFFFCFCFC),
      'Google Logo': Colors.grey[300],
      'Power Button': Color(0xFFE45D4F),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0203,
    colors: {
      'Glossy Panel': Color(0xFFFDF6F5),
      'Matte Panel': Color(0xFFFFFAF9),
      'Fingerprint Sensor': Color(0xFFFFFAF9),
      'Google Logo': Color(0xFFF4EEED),
      'Bezels': Color(0xFFF9F2F2),
      'Power Button': Color(0xFFE45D4F),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0204,
    colors: {
      'Glossy Panel': Color(0xFFE1EDF7),
      'Matte Panel': Color(0xFFE4EFF7),
      'Fingerprint Sensor': Color(0xFFE4EFF7),
      'Google Logo': Color(0xFFD1DDE5),
      'Bezels': Color(0xFFDFEBF4),
      'Power Button': Color(0xFFDEF669),
    },
    textures: {
      'Glossy Panel': MyTexture(),
      'Matte Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0205,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Color(0xFFF5795D),
      'Google Logo': Color(0xFFE45D4F),
      'Bezels': Colors.black,
      'Power Button': Color(0xFFF5B1A2),
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
