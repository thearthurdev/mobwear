import 'dart:math';
import 'package:flutter/material.dart';

class ScrollingCards extends StatelessWidget {
  final List phoneList;
  final double currentPage;
  final double padding;
  final double verticalInset;
  final int inset;

  ScrollingCards({
    this.currentPage,
    this.phoneList,
    this.padding = 30.0,
    this.verticalInset = 20.0,
    this.inset = 3,
  });

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 9.0 / 16.0;
    var widgetAspectRatio = cardAspectRatio * 1.3;

    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 3 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / inset;

        List<Widget> cardList = List();

        for (var i = 0; i < phoneList.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 50 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Hero(
              tag: phoneList[i].phone,
              child: phoneList[i].phone,
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
