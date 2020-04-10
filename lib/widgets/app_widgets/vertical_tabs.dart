import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final PageController pageController;
  final Key key;
  final double tabsWidth;
  final double itemExtent;
  final double indicatorWidth;
  final List<Tab> tabs;
  final List<Widget> contents;
  final List<Widget> actions;
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color dividerColor;
  final Duration changePageDuration;
  final Curve changePageCurve;

  final double tabsElevation;

  VerticalTabs({
    this.key,
    @required this.pageController,
    @required this.tabs,
    @required this.contents,
    this.actions,
    this.tabsWidth = 50,
    this.itemExtent = 50,
    this.indicatorWidth = 3,
    this.direction = TextDirection.ltr,
    this.indicatorColor = Colors.green,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.horizontal,
    this.dividerColor = const Color(0xffe5e5e5),
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.tabsElevation = 2.0,
  });

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _changePageByTapView;

  AnimationController animationController;
  Animation<double> animation;
  Animation<RelativeRect> rectAnimation;

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ));
    }
    _selectTab(0);

    if (widget.disabledChangePageFromContentView == true)
      pageScrollPhysics = NeverScrollableScrollPhysics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController;

    return Directionality(
      // textDirection: widget.direction,
      textDirection: TextDirection.ltr,
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(left: 50.0),
              width: kDeviceWidth(context) - widget.tabsWidth,
              height: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Container(
                  child: PageView.builder(
                    scrollDirection: widget.contentScrollAxis,
                    physics: pageScrollPhysics,
                    onPageChanged: (index) {
                      if (_changePageByTapView == false ||
                          _changePageByTapView == null) {
                        _selectTab(index);
                      }
                      if (_selectedIndex == index) {
                        _changePageByTapView = null;
                      }
                      setState(() {});
                    },
                    controller: pageController,

                    // the number of pages
                    itemCount: widget.contents.length,

                    // building pages
                    itemBuilder: (BuildContext context, int index) {
                      return widget.contents[index];
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: widget.tabsWidth,
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.white70, darkColor: Colors.black87),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                // itemExtent: widget.itemExtent,
                                padding: EdgeInsets.only(top: 16.0),
                                itemCount: widget.tabs.length,
                                itemBuilder: (context, index) {
                                  Tab tab = widget.tabs[index];
                                  Alignment alignment = Alignment.center;
                                  Widget child;

                                  if (tab.child != null) {
                                    child = tab.child;
                                  } else {
                                    child = Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        (tab.icon != null)
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  tab.icon,
                                                ],
                                              )
                                            : Container(),
                                        (tab.text != null)
                                            ? Text(tab.text)
                                            : Container(),
                                      ],
                                    );
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      _changePageByTapView = true;
                                      setState(() {
                                        _selectTab(index);
                                      });

                                      pageController.animateToPage(index,
                                          duration: widget.changePageDuration,
                                          curve: widget.changePageCurve);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ScaleTransition(
                                            child: Container(
                                              width: widget.indicatorWidth,
                                              height: widget.itemExtent,
                                              color: widget.indicatorColor,
                                            ),
                                            scale: Tween(begin: 0.0, end: 1.0)
                                                .animate(
                                              CurvedAnimation(
                                                parent:
                                                    animationControllers[index],
                                                curve: Curves.elasticOut,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: alignment,
                                              padding: EdgeInsets.all(5),
                                              child: child,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: kBrightnessAwareColor(context,
                                  lightColor: Colors.black12,
                                  darkColor: Colors.white12),
                              width: 32.0,
                              height: 1.0,
                            ),
                          ] +
                          widget.actions,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();
  }
}
