import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final PageController controller;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool autoPlay;
  final Function onPageChanged;

  const Carousel({
    @required this.controller,
    @required this.itemBuilder,
    @required this.itemCount,
    this.autoPlay = false,
    this.onPageChanged,
  });

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool userIsSwiping = false;

    return NotificationListener(
      onNotification: (notification) =>
          handleScrollNotification(notification, userIsSwiping),
      child: PageView.builder(
        controller: widget.controller,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        onPageChanged: (i) => widget.onPageChanged(i),
      ),
    );
  }

  bool handleScrollNotification(
      ScrollNotification notification, bool userIsSwiping) {
    if (notification is ScrollStartNotification) {
      if (notification.dragDetails != null) {
        userIsSwiping = true;
      }
    } else if (notification is ScrollEndNotification) {
      userIsSwiping = false;
    }
    return false;
  }
}
