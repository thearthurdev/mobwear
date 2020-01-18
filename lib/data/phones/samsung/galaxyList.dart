import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/data/phones/samsung/Note10Plus.dart';
import 'package:mobware/data/phones/samsung/S10Plus.dart';
import 'package:mobware/data/phones/samsung/S9Plus.dart';

List<PhoneModel> galaxyList = [
  PhoneModel(
    phone: S9Plus(),
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.black,
      'Fingerprint Sensor': Colors.black,
      'Samsung Logo': Colors.white60,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneModel(
    phone: S10Plus(),
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
  PhoneModel(
    phone: Note10Plus(),
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
