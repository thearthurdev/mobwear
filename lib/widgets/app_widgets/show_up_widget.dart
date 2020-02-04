import 'dart:async';
import 'package:flutter/material.dart';

enum ShowUpFrom { left, right, top, bottom, center }

class ShowUp extends StatefulWidget {
  final Widget child;
  final ShowUpFrom direction;
  final int delay;

  ShowUp({
    @required this.child,
    this.direction,
    this.delay,
  });

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;
  Offset _beginOffset;

  void setOffset() {
    ShowUpFrom direction = widget.direction;
    switch (direction) {
      case ShowUpFrom.left:
        _beginOffset = Offset(-0.35, 0.0);
        break;
      case ShowUpFrom.right:
        _beginOffset = Offset(0.35, 0.0);
        break;
      case ShowUpFrom.top:
        _beginOffset = Offset(0.0, -0.35);
        break;
      case ShowUpFrom.bottom:
        _beginOffset = Offset(0.0, 0.35);
        break;
      case ShowUpFrom.center:
        _beginOffset = Offset.zero;
        break;
      default:
        _beginOffset = Offset(0.0, 0.35);
    }
  }

  @override
  void initState() {
    super.initState();
    setOffset();
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: _beginOffset, end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
