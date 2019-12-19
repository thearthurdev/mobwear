import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
      child: Theme(
        data: ThemeData(
          hintColor: Colors.transparent,
          brightness: kThemeBrightness(context),
        ),
        child: TextField(
          cursorColor: kAccentColor(context),
          decoration: InputDecoration(
            hintText: 'Look for a phone',
            hintStyle: TextStyle(
              color: kThemeBrightness(context) == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
              fontSize: 14,
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            contentPadding: EdgeInsets.all(12),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: Icon(
                EvaIcons.search,
                color: kThemeBrightness(context) == Brightness.light
                    ? Colors.black87
                    : Colors.white70,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
