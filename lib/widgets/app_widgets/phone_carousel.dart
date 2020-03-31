import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class PhoneCarousel extends StatefulWidget {
  final List<PhoneModel> phonesList;
  final SwiperController swiperController;
  final PageController tabsPageController;
  final bool tabIsSwiping;

  PhoneCarousel({
    @required this.phonesList,
    @required this.swiperController,
    @required this.tabsPageController,
    this.tabIsSwiping = false,
  });

  @override
  _PhoneCarouselState createState() => _PhoneCarouselState();
}

class _PhoneCarouselState extends State<PhoneCarousel> {
  bool autoplay;
  bool editPageOpen;
  SwiperController swiperController;
  PageController tabsPageController;

  @override
  void initState() {
    super.initState();
    editPageOpen = false;
    swiperController = widget.swiperController;
    tabsPageController = widget.tabsPageController;
  }

  @override
  Widget build(BuildContext context) {
    List<PhoneModel> phonesList = widget.phonesList;
    int reverseIndex(i) => phonesList.length - 1 - i;
    bool userIsSwiping = false;
    bool autoplayCarousel =
        Provider.of<SettingsProvider>(context).autoplayCarousel;

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            userIsSwiping = true;
          }
        } else if (notification is ScrollEndNotification) {
          userIsSwiping = false;
        }
        return false;
      },
      child: Swiper(
        controller: swiperController,
        itemCount: phonesList.length,
        autoplay: autoplayCarousel,
        duration: 900,
        autoplayDelay: 2500,
        outer: true,
        fade: 1.0,
        scale: 1.0,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              kScreenAwareSize(24.0, context),
              kScreenAwareSize(24.0, context),
              kDeviceHeight(context) < 700.0
                  ? 60.0
                  : kScreenAwareSize(52.0, context),
              kScreenAwareSize(24.0, context),
            ),
            child: Hero(
              tag: phonesList[reverseIndex(i)].id,
              child: phonesList[reverseIndex(i)].phone,
            ),
          );
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.only(right: 50.0, bottom: 8.0),
          builder: DotSwiperPaginationBuilder(
            activeColor: kBrightnessAwareColor(context,
                lightColor: Colors.black, darkColor: Colors.white),
            color: kBrightnessAwareColor(context,
                lightColor: Colors.grey[200], darkColor: Colors.grey[900]),
            size: kScreenAwareSize(8.0, context),
            activeSize: kScreenAwareSize(8.0, context),
          ),
        ),
        onTap: (i) {
          editPageOpen = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditPhonePage(
                  phone: phonesList[reverseIndex(i)].phone,
                  phoneID: phonesList[reverseIndex(i)].id,
                );
              },
            ),
          ).whenComplete(
            () {
              editPageOpen = false;
              swiperController.move(i, animation: false);
            },
          );
        },
        onIndexChanged: (i) {
          if (i == phonesList.length - 1 &&
              autoplayCarousel &&
              !userIsSwiping &&
              !editPageOpen &&
              !widget.tabIsSwiping) {
            int randomInt = Random().nextInt(PhoneModel.phonesLists.length);
            if (randomInt != tabsPageController.page.toInt()) {
              Future.delayed(Duration(milliseconds: 1400)).whenComplete(() {
                tabsPageController.animateToPage(
                  randomInt,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.decelerate,
                );
              });
            }
          }
        },
      ),
    );
  }
}
