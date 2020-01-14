import 'package:flutter/material.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/models/search_item_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/services/all_phones.dart';
import 'package:mobware/services/search.dart';
import 'package:mobware/widgets/app_widgets/popup_list_item.dart';

class HomeSearchWidget extends StatelessWidget {
  final PageController tabsPageController;
  final List<BrandTab> brandTabs;

  const HomeSearchWidget({
    @required this.tabsPageController,
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
    tabsPageController
        .animateToPage(
      item.brandIndex,
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 300),
    )
        .then((v) {
      brandTabs
          .elementAt(item.brandIndex)
          .controller
          .animateToPage(
            item.phoneIndex,
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 300),
          )
          .then((v) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditPhonePage(
                  phone: item.phone,
                  phoneList: phoneLists.elementAt(item.brandIndex),
                  phoneIndex: item.phoneIndex);
            },
          ),
        );
      });
    });
  }
}
