import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/allPhonesLists.dart';
import 'package:mobware/data/brand_tabs.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/samsungList.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/pages/settings_page.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/no_items_found.dart';
import 'package:mobware/widgets/phone_stack.dart';
import 'package:mobware/widgets/popup_list_item.dart';
import 'package:mobware/widgets/search_bar.dart';
import 'package:mobware/widgets/search_widget.dart';
import 'package:mobware/widgets/vertical_tabs.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double googleCurrentPage = pixelList.length - 1.0;
  static double appleCurrentPage = iPhoneList.length - 1.0;
  static double samsungCurrentPage = samsungList.length - 1.0;

  @override
  void initState() {
    super.initState();
    // AllPhonesList.getPhones();
  }

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

    List<PageController> controllers = [
      googleController,
      appleController,
      samsungController,
    ];

    List<SearchItem> list = allPhones();

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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 55.0),
            child: VerticalTabs(
              pageController: tabsPageController,
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
                Container(child: Text('OnePlus'), padding: EdgeInsets.all(20)),
                Container(child: Text('Xiaomi'), padding: EdgeInsets.all(20)),
                Container(child: Text('htc'), padding: EdgeInsets.all(20)),
                Container(child: Text('LG'), padding: EdgeInsets.all(20)),
                Container(child: Text('Motorola'), padding: EdgeInsets.all(20)),
                Container(child: Text('Nokia'), padding: EdgeInsets.all(20)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SearchWidget<SearchItem>(
              dataList: list,
              hideSearchBoxWhenItemSelected: false,
              // listContainerHeight: MediaQuery.of(context).size.height / 3.5,
              listContainerHeight: 220.0,
              queryBuilder: (query, list) {
                return list
                    .where((item) => item.phoneName
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              },
              popupListItemBuilder: (item) {
                return PopupListItemWidget(item);
              },
              selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                return Container();
              },
              // widget customization
              noItemsFoundWidget: NoItemsFound(),
              textFieldBuilder: (controller, focusNode) {
                return SearchBar(controller, focusNode);
              },
              onItemSelected: (item) {
                // FocusScope.of(context).requestFocus(FocusNode());
                // print(phoneLists[item.brandIndex]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditPhonePage(
                          phone: item.phone,
                          phoneList: phoneListsMap[item.brandIndex],
                          phoneIndex: item.phoneIndex);
                    },
                  ),
                );
                // tabsPageController.animateToPage(
                //   item.brandIndex,
                //   curve: Curves.decelerate,
                //   duration: Duration(milliseconds: 200),
                // );
                // Future.delayed(Duration(seconds: 1), () {
                //   controllers.elementAt(item.brandIndex).animateToPage(
                //         item.phoneIndex,
                //         curve: Curves.decelerate,
                //         duration: Duration(milliseconds: 300),
                //       );
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}
