import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class IndicatorDot extends StatelessWidget {
  final bool isSelected;
  final BuildContext context;
  final Function onPressed;
  final double size;

  const IndicatorDot({
    this.isSelected = false,
    this.context,
    this.onPressed,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return indicatorDot(isSelected, context);
  }

  Widget indicatorDot(bool isSelected, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: GestureDetector(
        child: Container(
          width: kScreenAwareSize(size, context),
          height: kScreenAwareSize(size, context),
          decoration: BoxDecoration(
              color: isSelected
                  ? kBrightnessAwareColor(context,
                      lightColor: Colors.black, darkColor: Colors.white)
                  : kBrightnessAwareColor(context,
                      lightColor: Colors.grey[350],
                      darkColor: Colors.grey[800]),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isSelected ? Colors.black26 : Colors.transparent,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 10.0,
                ),
              ]),
        ),
        onTap: onPressed,
      ),
    );
  }
}

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    @required this.currentSectionIndex,
    @required this.pageController,
  });

  final int currentSectionIndex;
  final PageController pageController;

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return IndicatorDot(
          isSelected: index == widget.currentSectionIndex,
          context: context,
          onPressed: () {
            setState(() {
              widget.pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.decelerate,
              );
            });
          },
        );
      },
    );
  }
}
