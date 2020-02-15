import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/widgets/app_widgets/phone_group_view_picker_button.dart';
import 'package:provider/provider.dart';
import 'package:mobwear/widgets/app_widgets/home_search_widget.dart';
import 'package:mobwear/widgets/app_widgets/home_vertical_tabs.dart';
import 'package:mobwear/database/phone_database.dart';

class HomePage extends StatefulWidget {
  static String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController tabsPageController = PageController();
  ScrollController phoneGridController = PageController();
  SwiperController phoneCarouselController = SwiperController();

  @override
  void initState() {
    super.initState();
    MyTexture.loadTextureAssets(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyTexture.precacheTextureAssets(context);
  }

  @override
  void dispose() {
    tabsPageController.dispose();
    Hive.box(PhoneDatabase.phones).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isGrid = Provider.of<SettingsProvider>(context).phoneGroupView ==
        PhoneGroupView.grid;

    void togglePhoneGroupView(i) {
      Provider.of<SettingsProvider>(context)
          .changePhoneGroupView(myPhoneGroupViews.values.elementAt(i));
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('MobWear'),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              PhoneGroupViewPickerButton(
                icon: CustomIcons.carousel_view,
                isSelected: !isGrid,
                onTap: () => togglePhoneGroupView(0),
                size: 18.0,
              ),
              PhoneGroupViewPickerButton(
                icon: LineAwesomeIcons.th_large,
                isSelected: isGrid,
                onTap: () => togglePhoneGroupView(1),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 55.0),
            child: HomeVerticalTabs(
              tabsPageController: tabsPageController,
              phoneGridController: phoneGridController,
              phoneCarouselController: phoneCarouselController,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HomeSearchWidget(
              tabsPageController: tabsPageController,
              phoneGridController: phoneGridController,
              phoneCarouselController: phoneCarouselController,
            ),
          ),
        ],
      ),
    );
  }
}
