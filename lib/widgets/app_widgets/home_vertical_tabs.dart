import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/settings_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';
import 'package:mobwear/widgets/app_widgets/no_phones_found_widget.dart';
import 'package:mobwear/widgets/app_widgets/phone_carousel.dart';
import 'package:mobwear/widgets/app_widgets/phone_grid.dart';
import 'package:mobwear/widgets/app_widgets/vertical_tabs.dart';
import 'package:provider/provider.dart';

class HomeVerticalTabs extends StatefulWidget {
  final PageController tabsPageController;
  final ScrollController phoneGridController;
  final SwiperController phoneCarouselController;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
  });

  @override
  _HomeVerticalTabsState createState() => _HomeVerticalTabsState();
}

class _HomeVerticalTabsState extends State<HomeVerticalTabs> {
  bool tabIsSwiping;
  int randomInt;
  List<List<PhoneModel>> phonesLists = PhoneModel.phonesLists;
  List<String> randomExcuses;

  @override
  void initState() {
    super.initState();
    tabIsSwiping = false;
    randomInt = Random().nextInt(PhoneModel.excuses.length);
    PhoneModel.excuses.shuffle();
    randomExcuses = PhoneModel.excuses;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            tabIsSwiping = true;
            widget.phoneCarouselController.stopAutoplay();
          }
        } else if (notification is ScrollEndNotification) {
          tabIsSwiping = false;
          if (Provider.of<SettingsProvider>(context).autoplayCarousel) {
            widget.phoneCarouselController.startAutoplay();
          }
        }
        return false;
      },
      child: VerticalTabs(
        pageController: widget.tabsPageController,
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage(
                        phoneCarouselController:
                            widget.phoneCarouselController);
                  },
                ),
              ),
              customBorder: CircleBorder(),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  LineAwesomeIcons.cog,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      tabs.length,
      (i) {
        if (i > phonesLists.length - 1) {
          int reverseIndex = tabs.length - i;

          return Container(
            margin: EdgeInsets.only(right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAccentButton(icon: BrandModel.brands[i].brandIcon.icon),
                SizedBox(height: 8.0),
                Text('No ${BrandModel.brandNames[i]} phones found',
                    style: kTitleTextStyle),
                SizedBox(height: 4.0),
                Text(
                  randomExcuses[reverseIndex],
                  style: kSubtitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
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
                  controller: widget.phoneGridController,
                );
              if (snapshot.data == PhoneGroupView.carousel)
                return PhoneCarousel(
                  phonesList: phonesLists[i],
                  swiperController: widget.phoneCarouselController,
                  tabsPageController: widget.tabsPageController,
                  tabIsSwiping: tabIsSwiping,
                );
            }

            return view();
          },
        );
      },
    );
  }
}
