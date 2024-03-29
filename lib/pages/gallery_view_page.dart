import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/gallery_item_delete_dialog.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/gallery_item_info_dialog.dart';
import 'package:mobwear/widgets/app_widgets/show_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:share_plus/share_plus.dart';

class GalleryViewPage extends StatefulWidget {
  static const String id = '/GalleryViewPage';

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
    hideBars = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = Provider.of<GalleryProvider>(context).galleryItems;
    currentIndex = Provider.of<GalleryProvider>(context).currentIndex;
    controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness:
            hideBars ? Brightness.dark : Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: items.isNotEmpty
            ? Scaffold(
                backgroundColor: Colors.black,
                extendBody: true,
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                appBar: hideBars
                    ? null
                    : AppBar(
                        backgroundColor: Colors.transparent,
                        systemOverlayStyle: SystemUiOverlayStyle.dark,
                        leading: IconButton(
                          icon: Icon(LineAwesomeIcons.angle_left,
                              color: Colors.white),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.memory(item.imageBytes),
                            ),
                          );
                        },
                        onPageChanged: (i) => setState(() {
                          currentIndex = i;
                          Provider.of<GalleryProvider>(context, listen: false)
                              .setCurrentIndex(i);
                        }),
                      ),
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          gradient: hideBars
                              ? null
                              : LinearGradient(
                                  colors: [
                                    Colors.black26,
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
                      SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersive)
                          .whenComplete(() {
                        Future.delayed(Duration(milliseconds: 10), () {
                          setState(() => hideBars = !hideBars);
                        });
                      });
                    } else {
                      SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.edgeToEdge)
                          .whenComplete(() {
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
                              Colors.black26,
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

                            return ShowUp(
                              delay: 100 * i,
                              child: IconButton(
                                icon: Icon(actionIcons[i], color: Colors.white),
                                onPressed: () => onActionPressed(i),
                              ),
                            );
                          }),
                        ),
                      ),
              )
            : Container(),
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

    try {
      await Share.shareFiles(
        [item.imageBytes.toString()],
        text: 'Share your ${item.phoneName}',
        mimeTypes: ['image/png'],
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
      builder: (BuildContext context) =>
          GalleryItemInfoDialog(items[currentIndex]),
    );
  }

  void toggleItemFavStatus() {
    Provider.of<GalleryProvider>(context, listen: false)
        .toggleItemFavStatus(currentIndex);
  }

  void deleteItem() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) =>
          GalleryItemDeleteDialog(items[currentIndex]),
    ).whenComplete(() {
      if (items.isEmpty) Navigator.pop(context);
    });
  }

  Future<bool> onWillPop() {
    if (hideBars) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive)
          .whenComplete(() {
        hideBars = !hideBars;
        return Future.value(false);
      });
    }
    return Future.value(true);
  }
}
