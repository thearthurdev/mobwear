import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';

List<Tab> brandTabs = [
  Tab(icon: Icon(BrandIcons.google)),
  Tab(icon: Icon(BrandIcons.apple)),
  Tab(icon: Icon(BrandIcons.samsung1)),
  Tab(icon: Icon(BrandIcons.huawei)),
  Tab(icon: Icon(BrandIcons.oneplus)),
  Tab(icon: Icon(BrandIcons.xiaomi)),
  Tab(icon: Icon(BrandIcons.htc)),
  Tab(icon: Icon(BrandIcons.lg)),
  Tab(icon: Icon(BrandIcons.motorola)),
  Tab(icon: Icon(BrandIcons.nokia, size: 30.0)),
];

List<Widget> brandContents = [
  Container(child: Text('Google'), padding: EdgeInsets.all(20)),
  Container(child: Text('Apple'), padding: EdgeInsets.all(20)),
  Container(child: Text('Samsung'), padding: EdgeInsets.all(20)),
  Container(child: Text('Huawei'), padding: EdgeInsets.all(20)),
  Container(child: Text('OnePlus'), padding: EdgeInsets.all(20)),
  Container(child: Text('Xiaomi'), padding: EdgeInsets.all(20)),
  Container(child: Text('htc'), padding: EdgeInsets.all(20)),
  Container(child: Text('LG'), padding: EdgeInsets.all(20)),
  Container(child: Text('Motorola'), padding: EdgeInsets.all(20)),
  Container(child: Text('Nokia'), padding: EdgeInsets.all(20)),
];
