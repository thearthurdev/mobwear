import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/pages/about_page.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/phone_group_view_picker_dialog.dart';
import 'package:mobware/widgets/app_widgets/theme_picker_dialog.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static final String id = '/SettingsPage';

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
          return ListView(
            children: <Widget>[
              settingsListTile(
                context: context,
                title: 'Theme',
                subtitle: kThemeBrightness(context) == Brightness.light
                    ? 'White'
                    : 'Black',
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ThemePickerDialog(),
                ),
              ),
              SizedBox(height: 16.0),
              settingsListTile(
                context: context,
                title: 'Phone group view',
                subtitle: settingsProvider.phoneGroupView == PhoneGroupView.GRID
                    ? 'Brand groups are displayed in a grid'
                    : 'Brand groups are displayed in a carousel',
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => PhoneGroupViewPickerDialog(),
                ),
              ),
              Visibility(
                visible:
                    settingsProvider.phoneGroupView == PhoneGroupView.CAROUSEL,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    settingsListTile(
                      context: context,
                      title: 'Carousel autoplay',
                      subtitle: settingsProvider.autoplayCarousel
                          ? 'Carousel will autoplay'
                          : 'Carousel will be stagnant',
                      trailing: settingsProvider.autoplayCarousel
                          ? Icon(LineAwesomeIcons.check_circle)
                          : null,
                      onTap: () => settingsProvider
                          .changeAutoPlay(!settingsProvider.autoplayCarousel),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              settingsListTile(
                context: context,
                title: 'About',
                subtitle: 'Read more stuff',
                onTap: () => Navigator.pushNamed(context, AboutPage.id),
              ),
            ],
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
  }) {
    return ListTile(
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
