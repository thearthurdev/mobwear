import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/data/phones/apple/iPhone_data_list.dart';
import 'package:mobwear/data/phones/google/pixel_data_list.dart';
import 'package:mobwear/data/phones/samsung/galaxy_data_list.dart';

part 'phone_data_model.g.dart';

@HiveType(typeId: 0)
class PhoneDataModel {
  //id will be in the format "##,##" => brandIndex,phoneIndex without the comma
  @HiveField(0)
  final int id;
  @HiveField(1)
  final Map<String, Color> colors;
  @HiveField(2)
  final Map<String, MyTexture> textures;

  PhoneDataModel({
    this.id,
    this.colors,
    this.textures,
  });

  static List<List<PhoneDataModel>> phonesDataLists = [
    iPhoneDataList,
    galaxyDataList,
    pixelDataList,
  ];
}
