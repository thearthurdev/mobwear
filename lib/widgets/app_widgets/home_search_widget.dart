import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/data/models/search_item_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/services/search.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/search_popup_list_item.dart';
import 'package:provider/provider.dart';

class HomeSearchWidget extends StatelessWidget {
  final PageController tabsPageController;
  final PageController phoneGridController;
  final SwiperController phoneCarouselController;

  const HomeSearchWidget({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
  });

  @override
  Widget build(BuildContext context) {
    SearchItem.getSearchItems();

    return Search<SearchItem>(
      dataList: SearchItem.allSearchItems,
      queryBuilder: (query, list) {
        return list.where((item) {
          bool result = false;
          if (item.phoneName.toLowerCase().contains(query.toLowerCase())) {
            result = true;
          }
          if (item.phoneBrand.toLowerCase().contains(query.toLowerCase())) {
            result = true;
          }
          return result;
        }).toList();
      },
      popupListItemBuilder: (item) {
        return SearchPopupListItemWidget(item);
      },
      onItemSelected: (item) => onPhoneSelected(context, item),
    );
  }

  void onPhoneSelected(BuildContext context, SearchItem item) {
    List<List<PhoneModel>> phonesLists = PhoneModel.phonesLists;

    if (Provider.of<SettingsProvider>(context, listen: false).phoneGroupView ==
        PhoneGroupView.carousel) {
      phoneCarouselController.stopAutoplay();
      tabsPageController
          .animateToPage(
        item.brandIndex,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      )
          .whenComplete(
        () {
          int selectedIndex = phonesLists.elementAt(item.brandIndex).length -
              1 -
              item.phoneIndex;
          phoneCarouselController.move(selectedIndex).whenComplete(
            () {
              Future.delayed(Duration(milliseconds: 140 * (selectedIndex + 1)),
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditPhonePage(
                        phone: item.phone,
                        phoneID: item.phoneID,
                      );
                    },
                  ),
                ).whenComplete(() {
                  phoneCarouselController.move(selectedIndex, animation: false);
                });

                if (Provider.of<SettingsProvider>(context, listen: false)
                    .autoPlayCarousel) {
                  phoneCarouselController.startAutoplay();
                }
              });
            },
          );
        },
      );
    } else {
      tabsPageController
          .animateToPage(
        item.brandIndex,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      )
          .whenComplete(
        () {
          int reverseIndex(i) {
            return phonesLists.elementAt(item.brandIndex).length - 1 - i;
          }

          int i = reverseIndex(item.phoneIndex);

          if (i < 4 && kDeviceHeight(context) > 500.0) {
            i = 0;
          } else if (kDeviceHeight(context) < 500.0) {
            if (i < 3) i = 0;
          }

          double moveMultiplier = kDeviceHeight(context) < 500.0 ? 0.32 : 0.09;

          phoneGridController
              .animateTo(
            kDeviceHeight(context) * moveMultiplier * i,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          )
              .whenComplete(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: item.phone,
                      phoneID: item.phoneID,
                    );
                  },
                ),
              );
            },
          );
        },
      );
    }
  }
}
