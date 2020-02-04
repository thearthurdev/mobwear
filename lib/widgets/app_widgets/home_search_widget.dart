import 'package:flutter/material.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/models/search_item_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/services/all_phones.dart';
import 'package:mobware/services/search.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/popup_list_item.dart';
import 'package:provider/provider.dart';

class HomeSearchWidget extends StatelessWidget {
  final PageController tabsPageController;
  final ScrollController phoneGridController;
  final List<BrandTab> brandTabs;

  const HomeSearchWidget({
    @required this.tabsPageController,
    @required this.phoneGridController,
    @required this.brandTabs,
  });

  @override
  Widget build(BuildContext context) {
    return Search<SearchItem>(
      dataList: allPhones(),
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
        return PopupListItemWidget(item);
      },
      onItemSelected: (item) => onPhoneSelected(context, item),
    );
  }

  void onPhoneSelected(BuildContext context, SearchItem item) {
    if (Provider.of<SettingsProvider>(context).phoneGroupView ==
        PhoneGroupView.CAROUSEL) {
      tabsPageController
          .animateToPage(
        item.brandIndex,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      )
          .then(
        (v) {
          brandTabs
              .elementAt(item.brandIndex)
              .controller
              .move(
                  brandTabs.elementAt(item.brandIndex).list.length -
                      1 -
                      item.phoneIndex,
                  animation: true)
              .then(
            (v) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: item.phone,
                      phoneList: phoneLists.elementAt(item.brandIndex),
                      phoneIndex: item.phoneIndex,
                    );
                  },
                ),
              );
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
            return brandTabs.elementAt(item.brandIndex).list.length - 1 - i;
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
                      phoneList: phoneLists.elementAt(item.brandIndex),
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
