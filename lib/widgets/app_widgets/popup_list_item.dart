import 'package:flutter/material.dart';
import 'package:mobware/data/models/search_item_model.dart';
import 'package:mobware/utils/constants.dart';

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(right: 16.0),
      height: 72.0,
      child: ListTile(
        title: Text(
          item.phoneName,
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        subtitle: Text(
          '${item.phone.getPhoneBrand}',
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: kBrightnessAwareColor(context,
                lightColor: Colors.black54, darkColor: Colors.white54),
          ),
        ),
        trailing: FittedBox(
          child: item.phone,
        ),
      ),
    );
  }
}
