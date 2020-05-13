import 'package:carousel_slider/carousel_slider.dart';
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

  final CarouselController phoneCarouselController;

  const SettingsPage({this.phoneCarouselController});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isThemeExpanded = false;
  bool isAutoplayExpanded = false;
  bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context);

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
        body: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text('Settings'),
                  centerTitle: true,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(LineAwesomeIcons.angle_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SliverSafeArea(
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
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
                            Provider.of<ThemeProvider>(context, listen: false)
                                .changeTheme(context, i);
                          },
                        ),
                        SizedBox(height: 16.0),
                        SettingsExpansionTile(
                            title: 'Carousel mode',
                            subtitle: settingsProvider.autoPlayCarousel
                                ? 'Carousel will autoplay'
                                : 'Carousel will be stagnant',
                            settingMap: myAutoplayOptions,
                            isExpanded: isAutoplayExpanded,
                            selectedOptionCheck:
                                settingsProvider.autoPlayCarousel,
                            onExpansionChanged: (b) =>
                                setState(() => isAutoplayExpanded = b),
                            onOptionSelected: (i) {
                              settingsProvider.changeAutoPlay(
                                  myAutoplayOptions.values.elementAt(i));
                              if (i == 0) {
                                widget.phoneCarouselController.startAutoPlay();
                              } else {
                                widget.phoneCarouselController.stopAutoPlay();
                              }
                            }),
                        SizedBox(height: 16.0),
                        settingsListTile(
                          context: context,
                          title: 'About',
                          subtitle: 'Read more stuff',
                          onTap: () =>
                              Navigator.pushNamed(context, AboutPage.id),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                        ),
                      ],
                    ),
                  ),
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
