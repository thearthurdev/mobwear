import 'package:flutter/material.dart';
import 'package:mobware/data/phone_model.dart';
import 'package:mobware/data/phones/google/pixel2.dart';
import 'package:mobware/data/phones/google/pixel2XL.dart';
import 'package:mobware/data/phones/google/pixel3XL.dart';
import 'package:mobware/data/phones/google/pixel4XL.dart';
import 'package:mobware/data/phones/google/pixelXL.dart';

List<PhoneModel> pixelList = [
  PhoneModel(
    phone: PixelXL(),
    colors: {
      'Gloss Panel': Colors.white,
      'Matte Panel': Colors.grey[300],
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.grey[400],
      'Antenna Bands': Colors.white,
    },
  ),
  PhoneModel(
    phone: Pixel2(),
    colors: {
      'Gloss Panel': Colors.black,
      'Matte Panel': Colors.grey[900],
      'Fingerprint Sensor': Colors.grey[900],
      'Google Logo': Colors.black,
    },
  ),
  PhoneModel(
    phone: Pixel2XL(),
    colors: {
      'Gloss Panel': Colors.black,
      'Matte Panel': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.black,
    },
  ),
  PhoneModel(
    phone: Pixel3XL(),
    colors: {
      'Gloss Panel': Colors.white,
      'Matte Panel': Colors.white,
      'Fingerprint Sensor': Colors.white,
      'Google Logo': Colors.black,
    },
  ),
  PhoneModel(
    phone: Pixel4XL(),
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.deepOrange[500],
      'Google Logo': Colors.deepOrange[500],
      'Bezels': Colors.black,
    },
  ),
];
