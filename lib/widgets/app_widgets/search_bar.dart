import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final bool _isFocused;
  final OverlayEntry overlayEntry;
  final Function onCloseTap;

  const SearchBar({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required bool isFocused,
    @required this.overlayEntry,
    @required this.onCloseTap,
  })  : _controller = controller,
        _focusNode = focusNode,
        _isFocused = isFocused;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: kBrightnessAwareColor(context,
              lightColor: Colors.white, darkColor: Colors.grey[900]),
          boxShadow: [
            BoxShadow(
              color: kBrightnessAwareColor(context,
                  lightColor: Colors.blueGrey.withOpacity(0.2),
                  darkColor: Colors.black26),
              blurRadius: 10.0,
              offset: Offset(5.0, 6.0),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Select a phone or search for one',
                  hintStyle: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.black87, darkColor: Colors.white70),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    right: 20,
                  ),
                ),
              ),
            ),
            _isFocused
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      child: Icon(
                        LineAwesomeIcons.close,
                        color: kThemeBrightness(context) == Brightness.light
                            ? Colors.black87
                            : Colors.white70,
                        size: 18,
                      ),
                      onTap: onCloseTap,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      child: Icon(
                        LineAwesomeIcons.search,
                        color: kThemeBrightness(context) == Brightness.light
                            ? Colors.black87
                            : Colors.white70,
                        size: 18,
                      ),
                      onTap: () => _focusNode.requestFocus(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
