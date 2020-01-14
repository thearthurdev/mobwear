import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/app_widgets/home_search_widget.dart';
import 'package:mobware/widgets/app_widgets/home_vertical_tabs.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/galaxyList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double googleCurrentPage = pixelList.length - 1.0;
  double appleCurrentPage = iPhoneList.length - 1.0;
  double samsungCurrentPage = galaxyList.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController tabsPageController = PageController();

    PageController googleController =
        PageController(initialPage: googleCurrentPage.toInt());

    PageController appleController =
        PageController(initialPage: appleCurrentPage.toInt());

    PageController samsungController =
        PageController(initialPage: samsungCurrentPage.toInt());

    googleController.addListener(
        () => setState(() => googleCurrentPage = googleController.page));
    appleController.addListener(
        () => setState(() => appleCurrentPage = appleController.page));
    samsungController.addListener(
        () => setState(() => samsungCurrentPage = samsungController.page));

    List<BrandTab> brandTabs = [
      BrandTab(
          list: Provider.of<PhonesData>(context).pixels,
          controller: googleController,
          page: googleCurrentPage),
      BrandTab(
          list: Provider.of<PhonesData>(context).iPhones,
          controller: appleController,
          page: appleCurrentPage),
      BrandTab(
          list: Provider.of<PhonesData>(context).samsungs,
          controller: samsungController,
          page: samsungCurrentPage),
    ];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('MobWare'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 55.0),
            child: HomeVerticalTabs(
              tabsPageController: tabsPageController,
              brandTabs: brandTabs,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HomeSearchWidget(
              tabsPageController: tabsPageController,
              brandTabs: brandTabs,
            ),
          ),
        ],
      ),
    );
  }
}
