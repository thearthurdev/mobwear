import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/pages/about_page.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static final String id = '/SettingsPage';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isThemeExpanded = false;
  bool isAutoplayExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ListView(
              children: <Widget>[
                settingsExpansionTile(
                  context: context,
                  title: 'Theme',
                  subtitle: kThemeBrightness(context) == Brightness.light
                      ? 'White'
                      : 'Black',
                  settingMap: myThemes,
                  isExpanded: isThemeExpanded,
                  selectedOptionCheck: kThemeBrightness(context),
                  onExpansionChanged: (b) => isThemeExpanded = b,
                  onOptionSelected: (i) {
                    Provider.of<SettingsProvider>(context).changeBrightness(
                      context,
                      myThemes.values.elementAt(i),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                settingsExpansionTile(
                  context: context,
                  title: 'Carousel autoplay',
                  subtitle: settingsProvider.autoplayCarousel
                      ? 'Carousel will autoplay'
                      : 'Carousel will be stagnant',
                  settingMap: myAutoplayOptions,
                  isExpanded: isAutoplayExpanded,
                  selectedOptionCheck: settingsProvider.autoplayCarousel,
                  onExpansionChanged: (b) => isAutoplayExpanded = b,
                  onOptionSelected: (i) => settingsProvider
                      .changeAutoPlay(!settingsProvider.autoplayCarousel),
                ),
              
                SizedBox(height: 16.0),
                settingsListTile(
                  context: context,
                  title: 'About',
                  subtitle: 'Read more stuff',
                  onTap: () => Navigator.pushNamed(context, AboutPage.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ExpansionTile settingsExpansionTile({
    BuildContext context,
    String title,
    String subtitle,
    Map settingMap,
    Function onOptionSelected,
    Function onExpansionChanged,
    bool isExpanded,
    dynamic selectedOptionCheck,
  }) {
    return ExpansionTile(
      onExpansionChanged: (b) {
        setState(() => onExpansionChanged(b));
      },
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
        (i) {
          return ListTile(
            title: Text(
              settingMap.keys.elementAt(i),
              style: kSubtitleTextStyle,
            ),
            trailing: selectedOptionCheck == settingMap.values.elementAt(i)
                ? Icon(
                    LineAwesomeIcons.check_circle,
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.black, darkColor: Colors.white),
                  )
                : null,
            onTap: () => onOptionSelected(i),
          );
        },
      ),
    );
  }

  ListTile settingsListTile({
    BuildContext context,
    String title,
    String subtitle,
    Widget trailing,
    Function onTap,
    EdgeInsetsGeometry padding,
  }) {
    return ListTile(
      contentPadding: padding,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: kSubtitleTextStyle,
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
