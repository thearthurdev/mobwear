import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/custom_icons/custom_icons.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/database/phone_database.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/widgets/app_widgets/phone_group_view_picker_button.dart';
import 'package:provider/provider.dart';
import 'package:mobware/widgets/app_widgets/home_search_widget.dart';
import 'package:mobware/widgets/app_widgets/home_vertical_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PhoneDatabase phoneDatabase;
  PageController tabsPageController = PageController();
  ScrollController phoneGridController = PageController();
  SwiperController phoneCarouselController = SwiperController();

  @override
  void initState() {
    super.initState();
    phoneDatabase = PhoneDatabase();
    phoneDatabase.initDatabase();
  }

  @override
  void dispose() {
    phoneDatabase.closeDatabase();
    tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isGrid = Provider.of<SettingsProvider>(context).phoneGroupView ==
        PhoneGroupView.grid;

    List<List<PhoneModel>> brands =
        Provider.of<CustomizationProvider>(context).phonesList;

    void togglePhoneGroupView() {
      if (isGrid) {
        Provider.of<SettingsProvider>(context)
            .changePhoneGroupView(myPhoneGroupViews.values.elementAt(1));
      } else {
        Provider.of<SettingsProvider>(context)
            .changePhoneGroupView(myPhoneGroupViews.values.elementAt(0));
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('MobWare'),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              PhoneGroupViewPickerButton(
                icon: CustomIcons.carousel_view,
                isSelected: !isGrid,
                onTap: togglePhoneGroupView,
                size: 18.0,
              ),
              PhoneGroupViewPickerButton(
                icon: LineAwesomeIcons.th_large,
                isSelected: isGrid,
                onTap: togglePhoneGroupView,
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
              brands: brands,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HomeSearchWidget(
              tabsPageController: tabsPageController,
              phoneGridController: phoneGridController,
              phoneCarouselController: phoneCarouselController,
              brands: brands,
            ),
          ),
        ],
      ),
    );
  }
}
