import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobware/custom_icons/custom_icons.dart';
import 'package:mobware/data/models/brand_icon_model.dart';
import 'package:mobware/data/models/phone_model.dart';
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
  final SwiperController phoneCarouselController;
  final List<List<PhoneModel>> brands;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
    @required this.brands,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context).loadPhoneGroupView();
    Provider.of<SettingsProvider>(context).loadAutoPlay();

    List<Tab> tabs = List<Tab>.generate(myBrandIcons.length, (i) {
      return Tab(
        icon: Icon(
          myBrandIcons[i].icon,
          size: myBrandIcons[i].size,
        ),
      );
    });

    List<Widget> contentsList() {
      return List<Widget>.generate(
        brands.length,
        (i) {
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
                if (snapshot.data == PhoneGroupView.grid)
                  return PhoneGrid(brands[i], i, phoneGridController);
                if (snapshot.data == PhoneGroupView.carousel)
                  return PhoneCarousel(brands[i], phoneCarouselController);
              }

              return view();
            },
          );
        },
      );
    }

    return VerticalTabs(
      pageController: tabsPageController,
      contentScrollAxis: Axis.vertical,
      tabsWidth: 50.0,
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
