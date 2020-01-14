import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/phone_stack.dart';
import 'package:mobware/widgets/app_widgets/vertical_tabs.dart';

class HomeVerticalTabs extends StatelessWidget {
  final PageController tabsPageController;
  final List<BrandTab> brandTabs;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.brandTabs,
  });

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
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

    List<PhoneStack> contentsList() {
      return List<PhoneStack>.generate(
        brandTabs.length,
        (i) => PhoneStack(brandTabs[i]),
      );
    }

    return VerticalTabs(
      pageController: tabsPageController,
      contentScrollAxis: Axis.vertical,
      indicatorColor: kBrightnessAwareColor(
        context,
        lightColor: Colors.black,
        darkColor: Colors.white,
      ),
      tabs: tabs,
      contents: contentsList(),
    );
  }
}
