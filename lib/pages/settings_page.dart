import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/pages/about_page.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/providers/theme_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/settings_expansion_tile.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String id = '/SettingsPage';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isThemeExpanded = false;
  bool isAutoplayExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return ListView(
              children: <Widget>[
                SizedBox(height: 8.0),
                SettingsExpansionTile(
                  title: 'Theme',
                  subtitle: ThemeProvider.myThemes.keys
                      .elementAt(ThemeProvider.themeIndex),
                  settingMap: ThemeProvider.myThemes,
                  isExpanded: isThemeExpanded,
                  selectedOptionCheck: ThemeProvider.themeIndex,
                  onExpansionChanged: (b) =>
                      setState(() => isThemeExpanded = b),
                  onOptionSelected: (i) {
                    Provider.of<ThemeProvider>(context).changeTheme(context, i);
                  },
                ),
                SizedBox(height: 16.0),
                SettingsExpansionTile(
                  title: 'Carousel mode',
                  subtitle: settingsProvider.autoplayCarousel
                      ? 'Carousel will autoplay'
                      : 'Carousel will be stagnant',
                  settingMap: myAutoplayOptions,
                  isExpanded: isAutoplayExpanded,
                  selectedOptionCheck: settingsProvider.autoplayCarousel,
                  onExpansionChanged: (b) =>
                      setState(() => isAutoplayExpanded = b),
                  onOptionSelected: (i) => settingsProvider
                      .changeAutoPlay(myAutoplayOptions.values.elementAt(i)),
                ),
                SizedBox(height: 16.0),
                settingsListTile(
                  context: context,
                  title: 'About',
                  subtitle: 'Read more stuff',
                  onTap: () => Navigator.pushNamed(context, AboutPage.id),
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                ),
              ],
            );
          },
        ),
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
