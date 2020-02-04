import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/custom_icons.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/utils/constants.dart';

class PhoneGrid extends StatelessWidget {
  final BrandTab brandTab;
  final int brandIndex;
  final ScrollController phoneGridController;

  PhoneGrid(
    this.brandTab,
    this.brandIndex,
    this.phoneGridController,
  );

  @override
  Widget build(BuildContext context) {
    List<PhoneModel> phoneList = brandTab.list;

    int reverseIndex(i) => phoneList.length - 1 - i;

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: GridView.builder(
        itemCount: phoneList.length + (phoneList.length.isOdd ? 1 : 0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
        ),
        itemBuilder: (context, i) {
          if (i == phoneList.length && i.isOdd) {
            return Center(
              child: Icon(
                CustomIcons.mobware,
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.black38, darkColor: Colors.white38),
                size: 30.0,
              ),
            );
          } else {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Hero(
                  tag: phoneList[reverseIndex(i)].id,
                  child: phoneList[reverseIndex(i)].phone,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditPhonePage(
                        phone: phoneList[reverseIndex(i)].phone,
                        phoneList: phoneList,
                        phoneIndex: reverseIndex(i),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
