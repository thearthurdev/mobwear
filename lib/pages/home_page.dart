import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/brand_tabs.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/samsungList.dart';
import 'package:mobware/pages/settings_page.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/phone_stack.dart';
import 'package:mobware/widgets/search_bar.dart';
import 'package:mobware/widgets/vertical_tabs.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double googleCurrentPage = pixelList.length - 1.0;
  double appleCurrentPage = iPhoneList.length - 1.0;
  double samsungCurrentPage = samsungList.length - 1.0;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('MobWare'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              LineAwesomeIcons.cog,
            ),
            onPressed: () => Navigator.pushNamed(context, SettingsPage.id),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SearchBar(),
          Expanded(
            child: Container(
              child: VerticalTabs(
                contentScrollAxis: Axis.vertical,
                indicatorColor: kThemeBrightness(context) == Brightness.light
                    ? Colors.black
                    : Colors.white,
                tabs: brandTabs,
                contents: [
                  PhoneStack(
                    controller: googleController,
                    currentPage: googleCurrentPage,
                    phoneList: Provider.of<PhonesData>(context).pixels,
                  ),
                  PhoneStack(
                    controller: appleController,
                    currentPage: appleCurrentPage,
                    phoneList: Provider.of<PhonesData>(context).iPhones,
                  ),
                  PhoneStack(
                    controller: samsungController,
                    currentPage: samsungCurrentPage,
                    phoneList: Provider.of<PhonesData>(context).samsungs,
                  ),
                  Container(child: Text('Huawei'), padding: EdgeInsets.all(20)),
                  Container(
                      child: Text('OnePlus'), padding: EdgeInsets.all(20)),
                  Container(child: Text('Xiaomi'), padding: EdgeInsets.all(20)),
                  Container(child: Text('htc'), padding: EdgeInsets.all(20)),
                  Container(child: Text('LG'), padding: EdgeInsets.all(20)),
                  Container(
                      child: Text('Motorola'), padding: EdgeInsets.all(20)),
                  Container(child: Text('Nokia'), padding: EdgeInsets.all(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
