import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/utils/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final bool _showClose;
  final OverlayEntry overlayEntry;
  final Function onCloseTap;

  const SearchBar({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required bool showClose,
    @required this.overlayEntry,
    @required this.onCloseTap,
  })  : _controller = controller,
        _focusNode = focusNode,
        _showClose = showClose;

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
                  lightColor: Colors.black12, darkColor: Colors.black26),
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
                  hintText: 'Look for a phone',
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
            _showClose
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
                        EvaIcons.search,
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
