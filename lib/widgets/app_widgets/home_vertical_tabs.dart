import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/settings_page.dart';
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

  static bool tabIsSwiping = false;

  @override
  Widget build(BuildContext context) {
    List<List<PhoneModel>> phonesLists = PhoneModel.phonesLists;

    List<Tab> tabs = List<Tab>.generate(BrandIcon.brandIcons.length, (i) {
      BrandIcon myBrandIcon = BrandIcon.brandIcons[i];
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
                  child: Container(
                    margin: EdgeInsets.only(right: 52.0),
                    child: Icon(
                      CustomIcons.mobwear,
                      color: kBrightnessAwareColor(context,
                          lightColor: Colors.black, darkColor: Colors.white),
                      size: kScreenAwareSize(40.0, context),
                    ),
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
                    tabIsSwiping: tabIsSwiping,
                  );
              }

              return view();
            },
          );
        },
      );
    }

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            tabIsSwiping = true;
            phoneCarouselController.stopAutoplay();
          }
        } else if (notification is ScrollEndNotification) {
          tabIsSwiping = false;
          phoneCarouselController.startAutoplay();
        }
        return false;
      },
      child: VerticalTabs(
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
        actions: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: CircleBorder(),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  LineAwesomeIcons.cog,
                ),
              ),
              onTap: () => Navigator.pushNamed(context, SettingsPage.id),
            ),
          ),
        ],
      ),
    );
  }
}
