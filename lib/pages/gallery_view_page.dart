import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/gallery_item_delete_dialog.dart';
import 'package:mobwear/widgets/app_widgets/gallery_item_info_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class GalleryViewPage extends StatefulWidget {
  static const String id = '/GalleryViewPage';

  final int currentIndex;

  const GalleryViewPage({this.currentIndex});

  @override
  _GalleryViewPageState createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage> {
  static int currentIndex;
  static List<GalleryItem> items;
  PageController controller;
  bool hideBars;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    hideBars = false;
    controller = PageController(initialPage: currentIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = Provider.of<GalleryProvider>(context).galleryItems;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: hideBars
              ? null
              : AppBar(
                  backgroundColor: Colors.transparent,
                  brightness: Brightness.dark,
                  leading: IconButton(
                    icon:
                        Icon(LineAwesomeIcons.angle_left, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
          body: GestureDetector(
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  controller: controller,
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    GalleryItem item = items[i];

                    return Hero(
                      tag: item.imageDateTime,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.memory(item.imageBytes),
                      ),
                    );
                  },
                  onPageChanged: (i) => setState(() => currentIndex = i),
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    gradient: hideBars
                        ? null
                        : LinearGradient(
                            colors: [
                              Colors.black38,
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                  ),
                ),
              ],
            ),
            onTap: () {
              if (hideBars) {
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)
                    .whenComplete(() {
                  Future.delayed(Duration(milliseconds: 10), () {
                    setState(() => hideBars = !hideBars);
                  });
                });
              } else {
                SystemChrome.setEnabledSystemUIOverlays(
                    [SystemUiOverlay.bottom]).whenComplete(() {
                  setState(() => hideBars = !hideBars);
                });
              }
            },
          ),
          bottomNavigationBar: hideBars
              ? null
              : Container(
                  height: kBottomNavigationBarHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (i) {
                      List<IconData> actionIcons = [
                        LineAwesomeIcons.share_alt,
                        LineAwesomeIcons.info_circle,
                        items[currentIndex].isFavorite
                            ? LineAwesomeIcons.heart
                            : LineAwesomeIcons.heart_o,
                        LineAwesomeIcons.trash_o,
                      ];

                      return IconButton(
                        icon: Icon(actionIcons[i], color: Colors.white),
                        onPressed: () => onActionPressed(i),
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }

  void onActionPressed(int i) {
    switch (i) {
      case 0:
        shareItem();
        break;
      case 1:
        showItemInfo();
        break;
      case 2:
        toggleItemFavStatus();
        break;
      case 3:
        deleteItem();
        break;
    }
  }

  Future<void> shareItem() async {
    GalleryItem item = items[currentIndex];
    String phoneName = item.phoneName;
    String imageDateTime = item.imageDateTime;

    try {
      await Share.file(
        'Share your $phoneName',
        '${kGetCombinedName(phoneName)}_${kGetDateTime(dateTime: imageDateTime)}.png',
        item.imageBytes,
        'image/png',
        text: 'Check out this $phoneName I customized with MobWear!',
      );
    } catch (e) {
      String errorText = 'Unable to share. Please try again later';
      Toast.show(errorText, context);
      print(e);
    }
  }

  void showItemInfo() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: GalleryItemInfoDialog(items[currentIndex]),
      ),
    );
  }

  void toggleItemFavStatus() {
    Provider.of<GalleryProvider>(context).toggleItemFavStatus(currentIndex);
  }

  void deleteItem() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: GalleryItemDeleteDialog(items[currentIndex], currentIndex),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (hideBars) {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)
          .whenComplete(() {
        hideBars = !hideBars;
        return Future.value(false);
      });
    }
    return Future.value(true);
  }
}
