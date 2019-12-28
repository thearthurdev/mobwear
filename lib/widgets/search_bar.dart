import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/utils/constants.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar(this.controller, this.focusNode);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        isFocused = true;
      } else if (!widget.focusNode.hasFocus) {
        isFocused = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: kThemeBrightness(context) == Brightness.light
              ? Colors.white
              : Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: kThemeBrightness(context) == Brightness.light
                  ? Colors.black12
                  : Colors.black26,
              blurRadius: 10.0,
              offset: Offset(5.0, 6.0),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            suffixIcon: isFocused
                ? IconButton(
                    icon: Icon(LineAwesomeIcons.close),
                    onPressed: () {},
                  )
                : Icon(
                    EvaIcons.search,
                    color: kThemeBrightness(context) == Brightness.light
                        ? Colors.black87
                        : Colors.white70,
                    size: 18,
                  ),
            border: InputBorder.none,
            hintText: 'Look for a phone',
            hintStyle: TextStyle(
              color: kThemeBrightness(context) == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 20,
              top: 14,
              bottom: 14,
            ),
          ),
        ),
      ),
    );
  }
}
