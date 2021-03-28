import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/scrolling_page_indicator.dart';
import 'package:provider/provider.dart';

class PhoneCarousel extends StatefulWidget {
  final List<PhoneModel> phonesList;
  final CarouselController carouselController;
  final PageController tabsPageController;

  PhoneCarousel({
    @required this.phonesList,
    @required this.tabsPageController,
    this.carouselController,
  });

  @override
  _PhoneCarouselState createState() => _PhoneCarouselState();
}

class _PhoneCarouselState extends State<PhoneCarousel> {
  CarouselController carouselController;
  PageController tabsPageController;
  PageController pageIndicatorController;
  bool isEditPageOpen;
  ValueNotifier<int> selectedIndex;
  bool userIsSwiping;

  @override
  void initState() {
    super.initState();
    isEditPageOpen = false;
    userIsSwiping = false;
    carouselController = widget.carouselController;
    tabsPageController = widget.tabsPageController;
    pageIndicatorController = PageController(viewportFraction: 0.15);
    selectedIndex = ValueNotifier(0);
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
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: phonesList.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  padding: EdgeInsets.fromLTRB(
                    isWidescreen ? kScreenAwareSize(24.0, context) : 50.0,
                    kScreenAwareSize(24.0, context),
                    kScreenAwareSize(24.0, context),
                    kScreenAwareSize(16.0, context),
                  ),
                  child: GestureDetector(
                    onTap: () => onPhoneTapped(index, phonesList),
                    child: Hero(
                      tag: phonesList[reverseIndex(index)].id,
                      child: phonesList[reverseIndex(index)].phone,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: kDeviceHeight(context),
                autoPlay: autoPlayCarousel,
                autoPlayCurve: isWidescreen ? Curves.easeOutExpo : Curves.ease,
                autoPlayInterval: Duration(milliseconds: 5000),
                viewportFraction: isWidescreen ? 0.3 : 1.0,
                enlargeCenterPage: isWidescreen,
                onPageChanged: (i, reason) => onPageChanged(
                    i, phonesList, autoPlayCarousel, tabIsSwiping, reason),
              ),
            ),
          ),
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

  void onPhoneTapped(int i, List<PhoneModel> phonesList) {
    int reverseIndex(i) => phonesList.length - 1 - i;
    carouselController.stopAutoPlay();
    isEditPageOpen = true;

    Provider.of<CustomizationProvider>(context, listen: false)
        .changeEditPageStatus(true);

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
        carouselController.jumpToPage(i);
        carouselController.startAutoPlay();
        Provider.of<CustomizationProvider>(context, listen: false)
            .changeEditPageStatus(false);
      },
    );
  }

  void onPageChanged(
    int i,
    List<PhoneModel> phonesList,
    bool autoPlayCarousel,
    bool tabIsSwiping,
    CarouselPageChangedReason reason,
  ) {
    selectedIndex.value = i;
    pageIndicatorController.animateToPage(
      i,
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );

    if (i == phonesList.length - 1 &&
        autoPlayCarousel &&
        !userIsSwiping &&
        !isEditPageOpen &&
        !tabIsSwiping &&
        reason != CarouselPageChangedReason.manual) {
      int randomInt = Random().nextInt(PhoneModel.phonesLists.length);
      if (randomInt != tabsPageController.page.toInt()) {
        Future.delayed(Duration(milliseconds: 1800)).whenComplete(() {
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
