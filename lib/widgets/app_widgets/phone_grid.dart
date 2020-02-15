import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';

class PhoneGrid extends StatelessWidget {
  final List<PhoneModel> phonesList;
  final int brandIndex;
  final ScrollController controller;

  PhoneGrid({
    this.phonesList,
    this.brandIndex,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    int reverseIndex(i) => phonesList.length - 1 - i;

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: GridView.builder(
        controller: controller,
        itemCount: phonesList.length +
            (phonesList.length.isOdd && phonesList.length > 1 ? 1 : 0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
        ),
        itemBuilder: (context, i) {
          if (i == phonesList.length && i.isOdd) {
            // BrandIcon myBrandIcon = BrandIcon.myBrandIcons[brandIndex];

            // return Center(
            //   child: Icon(
            //     myBrandIcon.icon,
            //     color: kBrightnessAwareColor(context,
            //         lightColor: Colors.black12, darkColor: Colors.grey[850]),
            //     size: myBrandIcon.size == null ? 30.0 : myBrandIcon.size + 6.0,
            //   ),
            // );
            return Container();
          } else {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Hero(
                  tag: phonesList[reverseIndex(i)].id,
                  child: phonesList[reverseIndex(i)].phone,
                ),
              ),
              onTap: () {
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
