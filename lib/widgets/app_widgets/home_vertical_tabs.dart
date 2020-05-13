import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  final PageController phoneGridController;
  final CarouselController phoneCarouselController;

  const HomeVerticalTabs({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
  });

  @override
  _HomeVerticalTabsState createState() => _HomeVerticalTabsState();
}

class _HomeVerticalTabsState extends State<HomeVerticalTabs> {
  int randomInt;
  List<List<PhoneModel>> phonesLists = PhoneModel.phonesLists;
  List<String> randomExcuses;

  @override
  void initState() {
    super.initState();
    randomInt = Random().nextInt(PhoneModel.excuses.length);
    PhoneModel.excuses.shuffle();
    randomExcuses = PhoneModel.excuses;
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (settingsProvider.phoneGroupView == PhoneGroupView.carousel) {
          if (notification is ScrollStartNotification) {
            if (notification.dragDetails != null) {
              settingsProvider.changeTabSwipingStatus(true);
              widget.phoneCarouselController.stopAutoPlay();
            }
          } else if (notification is ScrollEndNotification) {
            settingsProvider.changeTabSwipingStatus(false);
            if (settingsProvider.autoPlayCarousel) {
              widget.phoneCarouselController.startAutoPlay();
            }
          }
        }
        return false;
      },
      child: VerticalTabs(
        pageController: widget.tabsPageController,
        carouselController: widget.phoneCarouselController,
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
          Container(
            margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(
                        phoneCarouselController: widget.phoneCarouselController,
                      );
                    },
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    LineAwesomeIcons.cog,
                  ),
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
          future: Provider.of<SettingsProvider>(context, listen: false)
              .loadPhoneGroupView(),
          builder: (context, snapshot) {
            if (snapshot.data == null &&
                snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: Container(
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
                  carouselController: widget.phoneCarouselController,
                  tabsPageController: widget.tabsPageController,
                );
            }

            return view();
          },
        );
      },
    );
  }
}
