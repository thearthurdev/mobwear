import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/pages/settings_page.dart';
import 'package:mobware/utils/constants.dart';

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final PageController pageController;
  final Key key;
  final double tabsWidth;
  final double itemExtent;
  final double indicatorWidth;
  final List<Tab> tabs;
  final List<Widget> contents;
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color dividerColor;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final bool showSideBar;

  final double tabsElevation;

  VerticalTabs({
    this.key,
    @required this.pageController,
    @required this.tabs,
    @required this.contents,
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
    this.showSideBar = false,
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
          // mainAxisSize: MainAxisSize.min,
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedContainer(
              padding: widget.showSideBar
                  ? EdgeInsets.only(left: 50.0)
                  : EdgeInsets.zero,
              duration: Duration(milliseconds: 300),
              width: kDeviceWidth(context) - widget.tabsWidth,
              height: double.maxFinite,
              // color: Colors.teal,
              child: Container(
                // color: Colors.orange,
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
            AnimatedAlign(
              alignment:
                  widget.showSideBar ? Alignment(-1, 0) : Alignment(-2, 0),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                width: widget.tabsWidth,
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.white, darkColor: Colors.black),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemExtent: widget.itemExtent,
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
                                    scale: Tween(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                        parent: animationControllers[index],
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
                    Divider(
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                    IconButton(
                      icon: Icon(
                        LineAwesomeIcons.cog,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, SettingsPage.id),
                    ),
                  ],
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
