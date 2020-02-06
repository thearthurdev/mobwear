import 'package:flutter/material.dart';
import 'package:mobware/data/models/brand_icon_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/utils/constants.dart';

class PhoneGrid extends StatelessWidget {
  final List<PhoneModel> phoneList;
  final int brandIndex;
  final ScrollController controller;

  PhoneGrid(
    this.phoneList,
    this.brandIndex,
    this.controller,
  );

  @override
  Widget build(BuildContext context) {
    int reverseIndex(i) => phoneList.length - 1 - i;

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: GridView.builder(
        controller: controller,
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
                myBrandIcons[brandIndex].icon,
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.black38, darkColor: Colors.white38),
                size: myBrandIcons[brandIndex].size == null
                    ? 30.0
                    : myBrandIcons[brandIndex].size + 6.0,
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
