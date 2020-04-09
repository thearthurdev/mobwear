import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/carousel.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewPhoneCarousel extends StatefulWidget {
  final List<PhoneModel> phonesList;
  final PageController phoneCarouselController;
  final PageController tabsPageController;

  const NewPhoneCarousel({
    @required this.phonesList,
    @required this.phoneCarouselController,
    @required this.tabsPageController,
  });

  @override
  _NewPhoneCarouselState createState() => _NewPhoneCarouselState();
}

class _NewPhoneCarouselState extends State<NewPhoneCarousel> {
  List<PhoneModel> phonesList;
  PageController phoneCarouselController;
  PageController tabsPageController;
  bool editPageOpen;

  @override
  void initState() {
    super.initState();
    phonesList = widget.phonesList;
    editPageOpen = false;
    phoneCarouselController = widget.phoneCarouselController;
    tabsPageController = widget.tabsPageController;
  }

  @override
  Widget build(BuildContext context) {
    int reverseIndex(i) => phonesList.length - 1 - i;
    bool userIsSwiping = false;
    bool autoPlayCarousel =
        Provider.of<SettingsProvider>(context).autoPlayCarousel;
    bool tabIsSwiping = Provider.of<SettingsProvider>(context).tabIsSwiping;

    return NotificationListener(
      onNotification: (notification) =>
          handleScrollNotification(notification, userIsSwiping),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Carousel(
              controller: phoneCarouselController,
              itemCount: phonesList.length,
              autoPlay: autoPlayCarousel,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      kScreenAwareSize(24.0, context),
                      kScreenAwareSize(24.0, context),
                      kDeviceHeight(context) < 700.0
                          ? 60.0
                          : kScreenAwareSize(52.0, context),
                      kScreenAwareSize(16.0, context),
                    ),
                    child: Hero(
                      tag: phonesList[reverseIndex(i)].id,
                      child: phonesList[reverseIndex(i)].phone,
                    ),
                  ),
                  onTap: () => handleItemTap(i),
                );
              },
              onPageChanged: (i) => handlePageChanged(
                i,
                autoPlayCarousel,
                userIsSwiping,
                tabIsSwiping,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 50.0, bottom: 16.0),
            child: SmoothPageIndicator(
              controller: phoneCarouselController,
              count: phonesList.length,
              effect: ScrollingDotsEffect(
                fixedCenter: true,
                activeDotColor: kBrightnessAwareColor(context,
                    lightColor: Colors.black, darkColor: Colors.white),
                dotColor: kBrightnessAwareColor(context,
                    lightColor: Colors.grey[350], darkColor: Colors.grey[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool handleScrollNotification(
    ScrollNotification notification,
    bool userIsSwiping,
  ) {
    if (notification is ScrollStartNotification) {
      if (notification.dragDetails != null) {
        userIsSwiping = true;
      }
    } else if (notification is ScrollEndNotification) {
      userIsSwiping = false;
    }
    return false;
  }

  void handleItemTap(int i) {
    editPageOpen = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          int reverseIndex(i) => phonesList.length - 1 - i;

          return EditPhonePage(
            phone: phonesList[reverseIndex(i)].phone,
            phoneID: phonesList[reverseIndex(i)].id,
          );
        },
      ),
    ).whenComplete(() {
      editPageOpen = false;
      phoneCarouselController.jumpToPage(i);
    });
  }

  void handlePageChanged(
    int i,
    bool autoPlayCarousel,
    bool userIsSwiping,
    bool tabIsSwiping,
  ) {
    if (i == phonesList.length - 1 &&
        autoPlayCarousel &&
        !userIsSwiping &&
        !editPageOpen &&
        !tabIsSwiping) {
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
  }
}
