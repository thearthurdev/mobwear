import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

get iPhoneDataList => _iPhoneDataList;

final List<PhoneDataModel> _iPhoneDataList = [
  PhoneDataModel(
    id: 0100,
    colors: {
      'Top Panel': Color(0xFFF2F2F2),
      'Bottom Panel': Colors.black,
      'Apple Logo': Color(0xFFBBC3C7),
      'Texts & Markings': Color(0xFFC9CFD3),
    },
    textures: {
      'Top Panel': MyTexture(),
      'Bottom Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0101,
    colors: {
      'Back Panel': Colors.white,
      'Apple Logo': Colors.grey[200],
      'Texts & Markings': Colors.grey[200],
      'Bezels': Color(0xFFEEEEEE),
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0102,
    colors: {
      'Top & Bottom Panel': Colors.white,
      'Middle Panel': Color(0xFFEEEEEE),
      'Apple Logo': Color(0xFFD2D2D2),
      'Texts & Markings': Color(0xFFD2D2D2),
      'Bezels': Color(0xFFEEEEEE),
    },
    textures: {
      'Top & Bottom Panel': MyTexture(),
      'Middle Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0103,
    colors: {
      'Back Panel': Color(0xFF39B6E7),
      'Apple Logo': Colors.black,
      'Texts & Markings': Colors.black,
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0104,
    colors: {
      'Top & Bottom Panel': Colors.white,
      'Middle Panel': Color(0xFFE5E1DA),
      'Apple Logo': Color(0xFFD5CDC0),
      'Texts & Markings': Color(0xFFCFC7BA),
      'Bezels': Color(0xFFD3CCC1),
    },
    textures: {
      'Top & Bottom Panel': MyTexture(),
      'Middle Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0105,
    colors: {
      'Back Panel': Color(0xFFF0D8D3),
      'Antenna Bands': Colors.white,
      'Apple Logo': Color(0xFFD1ACA5),
      'Texts & Markings': Color(0xFFBFA8A3),
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0106,
    colors: {
      'Back Panel': Color(0xFF312F2F),
      'Antenna Bands': Color(0xFF262424),
      'Apple Logo': Color(0xFF262525),
      'Texts & Markings': Color(0xFF393838),
    },
    textures: {},
  ),
  PhoneDataModel(
    id: 0107,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Color(0xFFE4D7D2),
      'Antenna Bands': Colors.white,
      'Apple Logo': Color(0xFFF4E6DF),
      'Texts & Markings': Color(0xFFCAC2BC),
    },
    textures: {},
  ),
  PhoneDataModel(
    id: 0108,
    colors: {
      'Back Panel': Color(0xFFF6E8E3),
      'Apple Logo': Color(0xFFFCEEEA),
      'iPhone Text': Color(0xFFDCCFCD),
      'Bezels': Color(0xFFFCE3DC),
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0109,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Color(0xFFEEEEEE),
      'Apple Logo': Color(0xFFD2D2D2),
      'iPhone Text': Color(0xFFD2D2D2),
      'Bezels': Color(0xFFEAEAEA),
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0110,
    colors: {
      'Back Panel': Color(0xFFFFEE44),
      'Apple Logo': Color(0xFF4E4D3E),
      'Texts & Markings': Color(0xFF48481C),
      'Bezels': Color(0xFFF9E737),
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0111,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Color(0xFF121516),
      'Apple Logo': Colors.black,
      'Texts & Markings': Colors.black,
      'Bezels': Color(0xFF0B0D0D),
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0112,
    colors: {
      'Camera Bump': Color(0xFFE2DFEA),
      'Back Panel': Color(0xFFD9D5E3),
      'Apple Logo': Color(0xFFEEEDF2),
      'Bezels': Color(0xFFD6D2E3),
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0113,
    colors: {
      'Camera Bump': Color(0xFF59655C),
      'Back Panel': Color(0xFF4E5850),
      'Apple Logo': Color(0xFF424A43),
      'Bezels': Color(0xFF3D4940),
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
