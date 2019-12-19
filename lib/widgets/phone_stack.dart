import 'package:flutter/material.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/widgets/scrolling_cards.dart';

class PhoneStack extends StatefulWidget {
  final PageController controller;
  final double currentPage;
  final List phoneList;

  PhoneStack({
    Key key,
    this.controller,
    this.currentPage,
    this.phoneList,
  }) : super(key: key);

  @override
  _PhoneStackState createState() => _PhoneStackState();
}

class _PhoneStackState extends State<PhoneStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ScrollingCards(
          currentPage: widget.currentPage,
          phoneList: widget.phoneList,
        ),
        Positioned.fill(
          child: GestureDetector(
            child: PageView.builder(
              itemCount: widget.phoneList.length,
              controller: widget.controller,
              reverse: true,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
            onTap: () {
              int index = widget.currentPage.toInt();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPhonePage(
                      phone: widget.phoneList[index].phone,
                      phoneList: widget.phoneList,
                      phoneIndex: widget.currentPage.toInt(),
                    );
                  },
                ),
              );
              widget.controller.animateToPage(
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
