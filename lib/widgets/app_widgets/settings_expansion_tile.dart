import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class SettingsExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map settingMap;
  final Function onOptionSelected;
  final Function onExpansionChanged;
  final bool isExpanded;
  final Color expandedColor;
  final selectedOptionCheck;

  const SettingsExpansionTile({
    @required this.title,
    @required this.subtitle,
    @required this.settingMap,
    @required this.onOptionSelected,
    @required this.onExpansionChanged,
    @required this.isExpanded,
    @required this.selectedOptionCheck,
    this.expandedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: AnimatedContainer(
        // padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isExpanded
              ? expandedColor ??
                  kBrightnessAwareColor(context,
                      lightColor: Colors.grey[100], darkColor: Colors.grey[900])
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
            onExpansionChanged: (b) => onExpansionChanged(b),
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: kTitleTextStyle,
              ),
              subtitle: AnimatedOpacity(
                opacity: isExpanded ? 0.0 : 1.0,
                duration: Duration(milliseconds: 300),
                child: Text(
                  subtitle,
                  style: kSubtitleTextStyle,
                ),
              ),
            ),
            children: List.generate(
              settingMap.length,
              (int i) {
                return ListTile(
                  onTap: () => onOptionSelected(i),
                  title: Text(
                    settingMap.keys.elementAt(i),
                    style: kSubtitleTextStyle,
                  ),
                  trailing:
                      selectedOptionCheck == settingMap.values.elementAt(i) ||
                              selectedOptionCheck == i
                          ? Icon(
                              LineAwesomeIcons.check_circle,
                              color: kBrightnessAwareColor(context,
                                  lightColor: Colors.black,
                                  darkColor: Colors.white),
                            )
                          : null,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
