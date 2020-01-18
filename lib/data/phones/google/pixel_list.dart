import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/data/phones/google/pixel2.dart';
import 'package:mobware/data/phones/google/pixel2XL.dart';
import 'package:mobware/data/phones/google/pixel3XL.dart';
import 'package:mobware/data/phones/google/pixel4XL.dart';
import 'package:mobware/data/phones/google/pixelXL.dart';

List<PhoneModel> pixelList = [
  PhoneModel(
    phone: PixelXL(),
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
  PhoneModel(
    phone: Pixel2(),
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
  PhoneModel(
    phone: Pixel2XL(),
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
  PhoneModel(
    phone: Pixel3XL(),
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
  PhoneModel(
    phone: Pixel4XL(),
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
