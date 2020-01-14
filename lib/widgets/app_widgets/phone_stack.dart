import 'package:flutter/material.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/widgets/app_widgets/scrolling_cards.dart';

class PhoneStack extends StatefulWidget {
  final BrandTab brandTab;

  PhoneStack(this.brandTab);

  @override
  _PhoneStackState createState() => _PhoneStackState();
}

class _PhoneStackState extends State<PhoneStack> {
  @override
  Widget build(BuildContext context) {
    PageController controller = widget.brandTab.controller;
    double currentPage = widget.brandTab.page;
    List<PhoneModel> phoneList = widget.brandTab.list;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ScrollingCards(
          currentPage: currentPage,
          phoneList: phoneList,
        ),
        Positioned.fill(
          child: GestureDetector(
            child: PageView.builder(
              itemCount: phoneList.length,
              controller: controller,
              reverse: true,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
            onTap: () {
              int index = currentPage.round();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: phoneList[index].phone,
                      phoneList: phoneList,
                      phoneIndex: currentPage.toInt(),
                    );
                  },
                ),
              );
              controller.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.decelerate,
              );
            },
          ),
        )
      ],
    );
  }
}
