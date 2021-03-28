import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/gallery_database.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/gallery_page.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/phone_group_view_picker_button.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/rate_app_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mobwear/widgets/app_widgets/home_search_widget.dart';
import 'package:mobwear/widgets/app_widgets/home_vertical_tabs.dart';
import 'package:mobwear/database/phone_database.dart';

class HomePage extends StatefulWidget {
  static const String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController tabsPageController;
  PageController phoneGridController;
  CarouselController phoneCarouselController;
  bool isWideScreen;

  @override
  void initState() {
    super.initState();

    MyTexture.loadTextureAssets(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    tabsPageController = PageController();
    phoneGridController = PageController();
    phoneCarouselController = CarouselController();

    WidgetsBinding.instance.addPostFrameCallback((_) => rateAppRequest());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyTexture.precacheTextureAssets(context);
  }

  @override
  void dispose() {
    tabsPageController.dispose();
    phoneGridController.dispose();
    PhoneDatabase.phonesBox.close();
    SettingsDatabase.settingsBox.close();
    GalleryDatabase.galleryBox.close();
    super.dispose();
  }

  //Rate app conditions check
  void rateAppRequest() {
    Box settingsBox = SettingsDatabase.settingsBox;
    int launchCount = settingsBox.get(SettingsDatabase.launchCountKey);

    Future.delayed(Duration(milliseconds: 2000), () {
      if (settingsBox.get(SettingsDatabase.rateAppKey) == 0) {
        if (launchCount % 7 == 0) {
          showDialog(
            context: context,
            builder: (context) => RateAppDialog(),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) && kDeviceHeight(context) > 500.0;

    Provider.of<SettingsProvider>(context, listen: false).loadAutoPlay();

    void togglePhoneGroupView(i) {
      Provider.of<SettingsProvider>(context, listen: false)
          .changePhoneGroupView(myPhoneGroupViews.values.elementAt(i));
    }

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
        appBar: buildAppBar(context, togglePhoneGroupView),
        body: buildBody(),
        floatingActionButton: buildFAB(),
      ),
    );
  }

  AppBar buildAppBar(
      BuildContext context, void togglePhoneGroupView(dynamic i)) {
    return AppBar(
      title: Text('MobWear'),
      centerTitle: true,
      // leading: IconButton(
      //   icon: Icon(LineAwesomeIcons.refresh),
      //   onPressed: () {
      //     PhoneDatabase.phonesBox.clear();
      //     print('phones database cleared');
      //   },
      // ),
      actions: <Widget>[
        FutureBuilder(
          future: Provider.of<SettingsProvider>(context).loadPhoneGroupView(),
          builder: (context, snapshot) {
            if (snapshot.data == null &&
                snapshot.connectionState != ConnectionState.done) {
              return Container();
            }
            dynamic view() {
              bool isGrid = snapshot.data == PhoneGroupView.grid;

              return Row(
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
              );
            }

            return view();
          },
        ),
      ],
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Stack(
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

  FloatingActionButton buildFAB() {
    void onFABPressed() {
      Provider.of<GalleryProvider>(context, listen: false).loadGallery().then(
            (galleryItems) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GalleryPage()),
            ),
          );
    }

    if (isWideScreen) {
      return FloatingActionButton.extended(
        label: Text(
          'Gallery',
          style: kTitleTextStyle,
        ),
        icon: Icon(LineAwesomeIcons.image),
        onPressed: onFABPressed,
      );
    }
    return FloatingActionButton(
      child: Icon(LineAwesomeIcons.image),
      onPressed: onFABPressed,
    );
  }
}
