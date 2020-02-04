import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/database/phone_database.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/widgets/app_widgets/home_search_widget.dart';
import 'package:mobware/widgets/app_widgets/home_vertical_tabs.dart';
import 'package:mobware/data/models/brand_tab_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool showSideBar = true;
  bool isGrid = true;

  PhoneDatabase phoneDatabase;
  PageController tabsPageController;

  AnimationController iconController;
  Animation<double> iconAnimation;

  int googleCurrentPage = 0;
  int appleCurrentPage = 0;
  int samsungCurrentPage = 0;

  SwiperController googleController = SwiperController();
  SwiperController appleController = SwiperController();
  SwiperController samsungController = SwiperController();

  @override
  void initState() {
    super.initState();
    phoneDatabase = PhoneDatabase();
    phoneDatabase.initDatabase();
    tabsPageController = PageController();

    iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    iconAnimation = Tween<double>(begin: 0, end: 1).animate(iconController);
  }

  @override
  void dispose() {
    phoneDatabase.closeDatabase();
    tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController phoneGridController = PageController();

    List<BrandTab> brandTabs = [
      BrandTab(
          list: Provider.of<CustomizationProvider>(context).pixels,
          controller: googleController,
          page: googleCurrentPage),
      BrandTab(
          list: Provider.of<CustomizationProvider>(context).iPhones,
          controller: appleController,
          page: appleCurrentPage),
      BrandTab(
          list: Provider.of<CustomizationProvider>(context).samsungs,
          controller: samsungController,
          page: samsungCurrentPage),
    ];

    // void toggleSideBar() {
    //   setState(() {
    //     if (showSideBar) {
    //       iconController.reverse();
    //       showSideBar = !showSideBar;
    //     } else {
    //       iconController.forward();
    //       showSideBar = !showSideBar;
    //     }
    //   });
    // }

    void togglePhoneGroupView() {
      if (isGrid) {
        Provider.of<SettingsProvider>(context)
            .changePhoneGroupView(myPhoneGroupViews.values.elementAt(1));
        isGrid = !isGrid;
      } else {
        Provider.of<SettingsProvider>(context)
            .changePhoneGroupView(myPhoneGroupViews.values.elementAt(0));
        isGrid = !isGrid;
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('MobWare'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: AnimatedIcon(
        //     icon: AnimatedIcons.menu_close,
        //     progress: iconAnimation,
        //   ),
        //   onPressed: toggleSideBar,
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(isGrid ? Icons.view_carousel : Icons.view_module),
            onPressed: togglePhoneGroupView,
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
              brandTabs: brandTabs,
              showSideBar: showSideBar,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HomeSearchWidget(
              tabsPageController: tabsPageController,
              phoneGridController: phoneGridController,
              brandTabs: brandTabs,
            ),
          ),
        ],
      ),
    );
  }
}
