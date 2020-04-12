import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

List<PhoneDataModel> galaxyDataList = [
  PhoneDataModel(
    id: 0200,
    colors: {
      'Camera': Color(0xFFD2CDBF),
      'Back Panel': Color(0xFFE0DBCC),
      'Samsung Logo': Color(0xFFFAF9F6),
      'Bezels': Color(0xFFDDD9C9),
    },
    textures: {
      'Camera': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0201,
    colors: {
      'Camera': Color(0xFF000000),
      'Back Panel': Color(0xFFDCE3EC),
      'Samsung Logo': Color(0xFFFAFBFD),
      'Bezels': Color(0xFFD8DFE8),
    },
    textures: {
      'Camera': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0202,
    colors: {
      'Camera': Color(0xFF000000),
      'Back Panel': Color(0xFFE4E9EF),
      'Samsung Logo': Color(0xFFF4F8FD),
      'Bezels': Color(0xFFE4E8EE),
    },
    textures: {
      'Camera': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0203,
    colors: {
      'Camera': Color(0xFF000000),
      'Back Panel': Color(0xFFE4E9EF),
      'Samsung Logo': Color(0xFFF4F8FD),
      'Bezels': Color(0xFFE4E8EE),
    },
    textures: {
      'Camera': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  // PhoneDataModel(
  //   id: 0200,
  //   colors: {
  //     'Camera Bump': Colors.black,
  //     'Back Panel': Colors.blue[700],
  //     'Samsung Logo': Colors.white60,
  //   },
  //   textures: {
  //     'Camera Bump': MyTexture(),
  //     'Back Panel': MyTexture(),
  //   },
  // ),
  // PhoneDataModel(
  //   id: 0201,
  //   colors: {
  //     'Camera Bump': Colors.black,
  //     'Back Panel': Colors.red[800],
  //     'Samsung Logo': Colors.black54,
  //     'Bezels': Colors.black87,
  //   },
  //   textures: {
  //     'Camera Bump': MyTexture(),
  //     'Back Panel': MyTexture(),
  //   },
  // ),
];
