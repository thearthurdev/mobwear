import 'package:flutter/material.dart';
import 'package:mobwear/data/models/search_item_model.dart';
import 'package:mobwear/utils/constants.dart';

class SearchPopupListItemWidget extends StatelessWidget {
  const SearchPopupListItemWidget(this.item);

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          item.phoneName,
          style: kTitleTextStyle,
        ),
        subtitle: Text(
          '${item.phone.getPhoneBrand}',
          style: kSubtitleTextStyle,
        ),
        trailing: FittedBox(
          child: item.phone,
        ),
      ),
    );
  }
}
