import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobware/data/models/phone_model.dart';

class BrandTab {
  final List<PhoneModel> list;
  final SwiperController controller;
  final int page;

  BrandTab({
    this.list,
    this.controller,
    this.page,
  });
}
