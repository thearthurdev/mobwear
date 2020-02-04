import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/custom_icons.dart';
import 'package:mobware/data/models/brand_icon_model.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/no_phones_found_widget.dart';
import 'package:mobware/widgets/app_widgets/phone_carousel.dart';
import 'package:mobware/widgets/app_widgets/phone_grid.dart';
import 'package:mobware/widgets/app_widgets/vertical_tabs.dart';
import 'package:provider/provider.dart';

class HomeVerticalTabs extends StatelessWidget {
  final PageController tabsPageController;
  final ScrollController phoneGridController;
  final List<BrandTab> brandTabs;
  final bool showSideBar;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.brandTabs,
    @required this.showSideBar,
  });

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = List<Tab>.generate(myBrandIcons.length, (i) {
      return Tab(
        icon: Icon(
          myBrandIcons[i].icon,
          size: myBrandIcons[i].size,
        ),
      );
    });

    Provider.of<SettingsProvider>(context).loadPhoneGroupView();
    Provider.of<SettingsProvider>(context).loadAutoPlay();

    List<Widget> contentsList() {
      return List<Widget>.generate(brandTabs.length, (i) {
        return FutureBuilder(
            future: Provider.of<SettingsProvider>(context).loadPhoneGroupView(),
            builder: (context, snapshot) {
              if (snapshot.data == null &&
                  snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Icon(
                    CustomIcons.mobware,
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.black, darkColor: Colors.white),
                    size: kScreenAwareSize(40.0, context),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.hasError) {
                return Center(child: NoPhonesFound());
              }
              dynamic view() {
                if (snapshot.data == PhoneGroupView.GRID)
                  return PhoneGrid(brandTabs[i], i, phoneGridController);
                if (snapshot.data == PhoneGroupView.CAROUSEL)
                  return PhoneCarousel(brandTabs[i]);
              }

              return view();
            });
      });
    }

    return VerticalTabs(
      pageController: tabsPageController,
      contentScrollAxis: Axis.vertical,
      tabsWidth: 50.0,
      showSideBar: showSideBar,
      itemExtent: kScreenAwareSize(45, context),
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
