import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_model.dart';

class BrandTab {
  final List<PhoneModel> list;
  final PageController controller;
  final double page;

  BrandTab({
    this.list,
    this.controller,
    this.page,
  });
}
