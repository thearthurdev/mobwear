import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class ScrollingPageIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final ValueNotifier<int> selectedIndex;

  const ScrollingPageIndicator({
    @required this.controller,
    @required this.itemCount,
    @required this.selectedIndex,
  });

  @override
  _ScrollingPageIndicatorState createState() => _ScrollingPageIndicatorState();
}

class _ScrollingPageIndicatorState extends State<ScrollingPageIndicator> {
  PageController controller;
  int itemCount;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    itemCount = widget.itemCount;
  }

  Widget indicatorDot({int index, double size, bool isSelected}) {
    return Center(
      child: AnimatedContainer(
        width: size,
        height: size,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? kBrightnessAwareColor(context,
                  lightColor: Colors.black, darkColor: Colors.white)
              : kBrightnessAwareColor(context,
                  lightColor: Colors.grey[350], darkColor: Colors.grey[800]),
        ),
      ),
    );
  }

  Widget selectedIndicator() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2.0,
          color: kBrightnessAwareColor(context,
              lightColor: Colors.black, darkColor: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.selectedIndex,
      builder: (context, value, child) {
        int selectedIndex = value;

        return FittedBox(
          child: Container(
            width: 240.0,
            height: 40.0,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  itemCount: itemCount,
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    double size() {
                      double size = 20.0;
                      if (i == selectedIndex - 1 || i == selectedIndex + 1)
                        size = 16.0;
                      if (i == selectedIndex - 2 || i == selectedIndex + 2)
                        size = 12.0;
                      if (i <= selectedIndex - 3 || i >= selectedIndex + 3)
                        size = 8.0;
                      return size;
                    }

                    return indicatorDot(
                      index: i,
                      size: size(),
                      isSelected: selectedIndex == i,
                    );
                  },
                ),
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: selectedIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
