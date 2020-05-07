import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/scrolling_page_indicator.dart';
import 'package:provider/provider.dart';

class PhoneCarousel extends StatefulWidget {
  final List<PhoneModel> phonesList;
  final SwiperController swiperController;
  final PageController tabsPageController;

  PhoneCarousel({
    @required this.phonesList,
    @required this.swiperController,
    @required this.tabsPageController,
  });

  @override
  _PhoneCarouselState createState() => _PhoneCarouselState();
}

class _PhoneCarouselState extends State<PhoneCarousel> {
  SwiperController swiperController;
  PageController tabsPageController;
  PageController pageIndicatorController;
  bool isEditPageOpen;
  int selectedIndex;
  bool userIsSwiping;

  @override
  void initState() {
    super.initState();
    isEditPageOpen = false;
    userIsSwiping = false;
    swiperController = widget.swiperController;
    tabsPageController = widget.tabsPageController;
    pageIndicatorController = PageController(viewportFraction: 0.15);
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<PhoneModel> phonesList = widget.phonesList;
    int reverseIndex(i) => phonesList.length - 1 - i;
    bool autoPlayCarousel =
        Provider.of<SettingsProvider>(context).autoPlayCarousel;
    bool tabIsSwiping = Provider.of<SettingsProvider>(context).tabIsSwiping;
    bool isWidescreen = kDeviceWidth(context) > kDeviceHeight(context);

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
      child: Column(
        children: <Widget>[
          Expanded(
            child: Swiper(
              controller: swiperController,
              itemCount: phonesList.length,
              autoplay: autoPlayCarousel,
              curve: isWidescreen ? Curves.easeOutExpo : Curves.ease,
              duration: 900,
              autoplayDelay: 5000,
              fade: isWidescreen ? 0.1 : 1.0,
              scale: isWidescreen ? 0.3 : 1.0,
              viewportFraction: isWidescreen ? 0.3 : 1.0,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    isWidescreen ? kScreenAwareSize(24.0, context) : 50.0,
                    kScreenAwareSize(24.0, context),
                    kScreenAwareSize(24.0, context),
                    kScreenAwareSize(16.0, context),
                  ),
                  child: Hero(
                    tag: phonesList[reverseIndex(i)].id,
                    child: phonesList[reverseIndex(i)].phone,
                  ),
                );
              },
              onTap: (i) {
                isEditPageOpen = true;
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
                    isEditPageOpen = false;
                    swiperController.move(i, animation: false);
                  },
                );
              },
              onIndexChanged: (i) {
                setState(() => selectedIndex = i);
                pageIndicatorController.animateToPage(
                  i,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                );

                if (i == phonesList.length - 1 &&
                    autoPlayCarousel &&
                    !userIsSwiping &&
                    !isEditPageOpen &&
                    !tabIsSwiping) {
                  int randomInt =
                      Random().nextInt(PhoneModel.phonesLists.length);
                  if (randomInt != tabsPageController.page.toInt()) {
                    Future.delayed(Duration(milliseconds: 1800))
                        .whenComplete(() {
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
          ),
          // Expanded(
          //   child: CarouselSlider.builder(
          //     itemCount: phonesList.length,
          //     itemBuilder: (context, i) {
          //       return Padding(
          //         padding: EdgeInsets.fromLTRB(
          //           isWidescreen ? kScreenAwareSize(24.0, context) : 40.0,
          //           kScreenAwareSize(24.0, context),
          //           kScreenAwareSize(16.0, context),
          //           kScreenAwareSize(16.0, context),
          //         ),
          //         child: AnimatedOpacity(
          //           opacity: 1.0,
          //           duration: Duration(milliseconds: 800),
          //           child: Hero(
          //             tag: phonesList[reverseIndex(i)].id,
          //             child: phonesList[reverseIndex(i)].phone,
          //           ),
          //         ),
          //       );
          //     },
          //     options: CarouselOptions(
          //       height: kDeviceHeight(context),
          //       autoPlay: autoPlayCarousel,
          //       autoPlayCurve: Curves.easeOut,
          //       viewportFraction: isWidescreen ? 0.3 : 1.0,
          //       enlargeCenterPage: isWidescreen,
          //     ),
          //   ),
          // ),
          Container(
            width: kScreenAwareSize(100.0, context),
            margin: EdgeInsets.only(
              bottom: 8.0,
            ),
            child: ScrollingPageIndicator(
              controller: pageIndicatorController,
              itemCount: phonesList.length,
              selectedIndex: selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}
