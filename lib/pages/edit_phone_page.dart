import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/capture_page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/utils/my_phone_header_delegate.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_tile.dart';
import 'package:mobwear/widgets/app_widgets/flushbars.dart';
import 'package:provider/provider.dart';
import "package:flip/flip.dart";

class EditPhonePage extends StatefulWidget {
  static const String id = '/EditPhonePage';

  final dynamic phone;
  final int phoneID;

  EditPhonePage({
    this.phone,
    this.phoneID,
  });

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage>
    with SingleTickerProviderStateMixin {
  FlipController flipController;
  ScrollController scrollController1;
  ScrollController scrollController2;
  ScrollController currentController;
  bool showFAB, isWideScreen, isLargeScreen;

  static Box settingsBox = SettingsDatabase.settingsBox;
  bool showFlipTip = settingsBox.get(SettingsDatabase.flipPhoneTipKey) != 1;
  bool showSwipeTip = settingsBox.get(SettingsDatabase.flipPhoneTipKey) != 1;

  @override
  void initState() {
    super.initState();
    showFAB = true;
    flipController = FlipController();
    scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    scrollController1.addListener(scrollListener);
    scrollController2.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => showFlipTipFlushbar());
  }

  void showFlipTipFlushbar() {
    if (showFlipTip) {
      Future.delayed(Duration(milliseconds: 1500), () {
        if (flipController.isFront) flipController.flip();

        MyFlushbars.showTipFlushbar(
          context,
          title: 'Tip: Specs',
          message: 'Want to view the specs of any phone? Simply flip it over!',
          onDismiss: () {
            settingsBox.put(SettingsDatabase.flipPhoneTipKey, 1);
            if (!flipController.isFront) flipController.flip();
            if (showSwipeTip) showSwipeTipFlushbar();
          },
        );
      });
    }
  }

  void showSwipeTipFlushbar() {
    void showSwipeTip() {
      MyFlushbars.showTipFlushbar(
        context,
        title: 'Tip: Reset, Copy & Paste',
        message: 'Swipe left or right on a card to access more actions',
        onDismiss: () => settingsBox.put(SettingsDatabase.swipeCardTipKey, 1),
      );
    }

    if (isWideScreen) {
      showSwipeTip();
    } else {
      double maxScrollExtent = scrollController1.position.maxScrollExtent;
      setState(() => showFAB = false);
      scrollController1
          .animateTo(
              maxScrollExtent > 400.0 ? maxScrollExtent * 0.5 : maxScrollExtent,
              duration: Duration(milliseconds: 600),
              curve: Curves.linearToEaseOut)
          .whenComplete(() => showSwipeTip());
    }
  }

  void scrollListener() {
    if (currentController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (showFAB == true) setState(() => showFAB = false);
    } else if (currentController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (showFAB == false) setState(() => showFAB = true);
    }
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) &&
            kDeviceWidth(context) > kDeviceHeight(context) ||
        kDeviceIsLandscape(context);
    isLargeScreen = kDeviceHeight(context) >= 500.0 || !isWideScreen;
    currentController = isWideScreen ? scrollController2 : scrollController1;

    Provider.of<CustomizationProvider>(context, listen: false)
        .setCurrentPhoneData(
      phoneID: widget.phoneID,
      phoneBrandIndex: widget.phone.getPhoneBrandIndex,
      phoneIndex: widget.phone.getPhoneIndex,
    );

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
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
          floatingActionButton: isLargeScreen ? buildFAB() : null,
          floatingActionButtonLocation: isWideScreen
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.phone.getPhoneName),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(LineAwesomeIcons.angle_left),
        onPressed: () {
          if (!flipController.isFront) {
            flipPhoneAndPop();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(LineAwesomeIcons.database),
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => DataPage())),
        // ),
        isLargeScreen
            ? SizedBox()
            : IconButton(
                icon: Icon(LineAwesomeIcons.camera),
                onPressed: onFABPressed,
              ),
      ],
    );
  }

  Widget buildBody() {
    if (isWideScreen) {
      return buildWideScreenLayout();
    }

    return buildNormalLayout();
  }

  Widget buildWideScreenLayout() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Container(
              margin: EdgeInsets.all(
                kScreenAwareSize(24.0, context),
              ),
              child: buildPhone(),
            ),
          ),
          Flexible(
            child: buildCustomizationTileList(),
          ),
        ],
      ),
    );
  }

  Widget buildNormalLayout() {
    return CustomScrollView(
      controller: scrollController1,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: MyPhoneHeaderDelegate(
            minHeight: kScreenAwareSize(1.0, context),
            maxHeight: kScreenAwareSize(475.0, context),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Center(child: buildPhone()),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: kDeviceWidth(context) >= kTabletBreakpoint
                    ? EdgeInsets.symmetric(
                        horizontal: kScreenAwareSize(60.0, context))
                    : null,
                child: buildCustomizationTileList(),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Hero(
      tag: widget.phoneID,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => flipPhone(details),
        child: Flip(
          controller: flipController,
          flipDuration: Duration(milliseconds: 300),
          firstChild: widget.phone,
          secondChild: widget.phone.getPhoneFront,
        ),
      ),
    );
  }

  Widget buildCustomizationTileList() {
    Map textures = Provider.of<CustomizationProvider>(context).currentTextures;
    Map colors = Provider.of<CustomizationProvider>(context).currentColors;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: colors.length,
      controller: scrollController2,
      physics: isWideScreen ? null : NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return CustomizationPickerTile(
          colors: colors,
          textures: textures,
          index: i,
          noTexture: i > textures.length - 1,
        );
      },
    );
  }

  Widget buildFAB() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOutSine,
      height: showFAB ? isWideScreen ? 48.0 : 56.0 : 0.0,
      child: isWideScreen
          ? FloatingActionButton.extended(
              label: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: showFAB ? 1.0 : 0.0,
                child: Text('Capture', style: kTitleTextStyle),
              ),
              icon: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: showFAB ? 1.0 : 0.0,
                child: Icon(LineAwesomeIcons.camera),
              ),
              onPressed: onFABPressed,
            )
          : FloatingActionButton(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: showFAB ? 1.0 : 0.0,
                child: Icon(LineAwesomeIcons.camera),
              ),
              onPressed: onFABPressed,
            ),
    );
  }

  void onFABPressed() {
    Provider.of<CustomizationProvider>(context, listen: false)
        .resetCurrentValues();
    Provider.of<CustomizationProvider>(context, listen: false)
        .changeCapturePageStatus(true);
    if (!flipController.isFront) {
      flipController.flip();
      Future.delayed(Duration(milliseconds: 320), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CapturePage(
              phone: widget.phone,
              phoneID: widget.phoneID,
            ),
          ),
        ).whenComplete(() {
          Provider.of<CustomizationProvider>(context, listen: false)
              .changeCapturePageStatus(false);
        });
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CapturePage(
            phone: widget.phone,
            phoneID: widget.phoneID,
          ),
        ),
      ).whenComplete(() {
        Provider.of<CustomizationProvider>(context, listen: false)
            .changeCapturePageStatus(false);
      });
    }
  }

  void flipPhone(DragUpdateDetails details) {
    if (details.delta.dx > 0 && !flipController.isFront) {
      flipController.flip();
    } else if (details.delta.dx < 0 && flipController.isFront) {
      flipController.flip();
    }
  }

  void flipPhoneAndPop() {
    flipController.flip();
    Future.delayed(Duration(milliseconds: 320), () {
      Navigator.pop(context);
    });
  }

  Future<bool> onWillPop() {
    if (!flipController.isFront) {
      flipPhoneAndPop();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
