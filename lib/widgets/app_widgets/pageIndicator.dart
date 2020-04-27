import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class IndicatorDot extends StatelessWidget {
  final bool isSelected;
  final BuildContext context;
  final Function onPressed;
  final double size;

  const IndicatorDot({
    this.isSelected = false,
    this.context,
    this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return indicatorDot(isSelected, context);
  }

  Widget indicatorDot(bool isSelected, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: kScreenAwareSize(size ?? 10.0, context),
          height: kScreenAwareSize(size ?? 10.0, context),
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
                  color: isSelected
                      ? Colors.blueGrey.withOpacity(0.5)
                      : Colors.transparent,
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
  final int currentSelectionIndex;
  final double dotSize;

  const PageIndicator({this.currentSelectionIndex, this.dotSize});

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
          isSelected: index == widget.currentSelectionIndex,
          context: context,
          size: widget.dotSize ?? null,
        );
      },
    );
  }
}
