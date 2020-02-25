import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/brand_icon_model.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/no_phones_found_widget.dart';
import 'package:mobwear/widgets/app_widgets/phone_carousel.dart';
import 'package:mobwear/widgets/app_widgets/phone_grid.dart';
import 'package:mobwear/widgets/app_widgets/vertical_tabs.dart';
import 'package:provider/provider.dart';

class HomeVerticalTabs extends StatelessWidget {
  final PageController tabsPageController;
  final ScrollController phoneGridController;
  final SwiperController phoneCarouselController;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
  });

  @override
  Widget build(BuildContext context) {
    List<List<PhoneModel>> phonesLists = PhoneModel.phonesLists;

    List<Tab> tabs = List<Tab>.generate(BrandIcon.myBrandIcons.length, (i) {
      BrandIcon myBrandIcon = BrandIcon.myBrandIcons[i];
      return Tab(
        icon: Icon(
          myBrandIcon.icon,
          size: myBrandIcon.size,
        ),
      );
    });

    List<Widget> contentsList() {
      return List<Widget>.generate(
        phonesLists.length,
        (i) {
          return FutureBuilder(
            future: Provider.of<SettingsProvider>(context).loadPhoneGroupView(),
            builder: (context, snapshot) {
              if (snapshot.data == null &&
                  snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Icon(
                    CustomIcons.mobwear,
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
                  return PhoneGrid(
                    phonesList: phonesLists[i],
                    brandIndex: i,
                    controller: phoneGridController,
                  );
                if (snapshot.data == PhoneGroupView.carousel)
                  return PhoneCarousel(
                    phonesList: phonesLists[i],
                    swiperController: phoneCarouselController,
                    tabsPageController: tabsPageController,
                  );
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
