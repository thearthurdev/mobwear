import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/models/search_item_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/services/search.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/search_popup_list_item.dart';
import 'package:provider/provider.dart';

class HomeSearchWidget extends StatelessWidget {
  final PageController tabsPageController;
  final ScrollController phoneGridController;
  final SwiperController phoneCarouselController;
  final List<List<PhoneModel>> brands;

  const HomeSearchWidget({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.phoneCarouselController,
    @required this.brands,
  });

  @override
  Widget build(BuildContext context) {
    return Search<SearchItem>(
      dataList: Provider.of<CustomizationProvider>(context).allPhones(),
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
    List<List<PhoneModel>> phonesList =
        Provider.of<CustomizationProvider>(context).phonesList;

    if (Provider.of<SettingsProvider>(context).phoneGroupView ==
        PhoneGroupView.carousel) {
      tabsPageController
          .animateToPage(
        item.brandIndex,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      )
          .then(
        (v) {
          int selectedIndex =
              brands.elementAt(item.brandIndex).length - 1 - item.phoneIndex;
          phoneCarouselController.move(selectedIndex).then(
            (v) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: item.phone,
                      phoneList: phonesList.elementAt(item.brandIndex),
                      phoneIndex: item.phoneIndex,
                    );
                  },
                ),
              ).whenComplete(() {
                phoneCarouselController.move(selectedIndex, animation: false);
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
          .then(
        (v) {
          int reverseIndex(i) {
            return brands.elementAt(item.brandIndex).length - 1 - i;
          }

          int i = reverseIndex(item.phoneIndex);

          if (i < 4) i = 0;

          phoneGridController
              .animateTo(
            kDeviceHeight(context) * 0.08 * i,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          )
              .then(
            (v) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: item.phone,
                      phoneList: phonesList.elementAt(item.brandIndex),
                      phoneIndex: item.phoneIndex,
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
