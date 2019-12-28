import 'package:flutter/material.dart';
import 'package:mobware/data/allPhonesLists.dart';

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 72.0,
      child: ListTile(
        title: Text(
          item.phoneName,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Quickksand',
            letterSpacing: 0.3,
          ),
        ),
        subtitle: Text('${item.phone.getPhoneBrand}'),
        trailing: FittedBox(
          child: item.phone,
        ),
      ),
    );
  }
}
