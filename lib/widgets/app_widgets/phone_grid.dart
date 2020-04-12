import 'package:flutter/material.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/utils/constants.dart';

class PhoneGrid extends StatelessWidget {
  final List<PhoneModel> phonesList;
  final int brandIndex;
  final PageController controller;

  PhoneGrid({
    this.phonesList,
    this.brandIndex,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    int reverseIndex(i) => phonesList.length - 1 - i;

    return GridView.builder(
      controller: controller,
      padding: EdgeInsets.only(top: 6.0, left: 50.0),
      itemCount: phonesList.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: kDeviceHeight(context) < 500.0 ? 1 : 2,
        childAspectRatio: 16 / 9,
      ),
      itemBuilder: (context, i) {
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
      },
    );
  }
}
