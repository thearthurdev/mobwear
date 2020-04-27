import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/home_page.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/pageIndicator.dart';
import 'package:mobwear/widgets/app_widgets/show_up_widget.dart';

class OnboardingSlide {
  final String title, subtitle, imageAsset;
  final List<Color> cardGradient;
  OnboardingSlide(
      {this.title, this.subtitle, this.imageAsset, this.cardGradient});

  static List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: 'Select your\nfavorite\nphone',
      subtitle: 'Choose a flagship from any of the major phone makers',
      imageAsset: 'assets/images/phone_stack.png',
      cardGradient: [Color(0xFFCC2B5E), Color(0xFF753A88)],
    ),
    OnboardingSlide(
      title: 'Customize\nits\nfeatures',
      subtitle: 'Mix colors and blend textures to get the best looking device',
      imageAsset: 'assets/images/phone_customize.png',
      cardGradient: [Color(0xFFDD5E89), Color(0xFFF7BB97)],
    ),
    OnboardingSlide(
      title: 'Share\nyour\ncreation',
      subtitle: 'Let your friends and family enjoy what you\'ve created',
      imageAsset: 'assets/images/phone_share.png',
      cardGradient: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
    ),
  ];

  static List<Image> imageAssets = [];

  static void loadImageAssets(BuildContext context) {
    imageAssets.clear();
    for (OnboardingSlide slide in slides) {
      imageAssets.add(Image.asset(slide.imageAsset));
    }
  }

  static void precacheImageAssets(BuildContext context) {
    for (Image asset in imageAssets) {
      precacheImage(asset.image, context);
    }
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage;
  bool isSwipeLeft, isLastSlide, isDone, isWideScreen;
  PageController controller;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    isSwipeLeft = true;
    isLastSlide = false;
    isDone = false;
    isWideScreen = false;
    controller = PageController();
    controller.addListener(handleSwipes);
    OnboardingSlide.loadImageAssets(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    OnboardingSlide.precacheImageAssets(context);
  }

  void handleSwipes() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (isSwipeLeft == false) setState(() => isSwipeLeft = true);
    } else if (controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isSwipeLeft == true) setState(() => isSwipeLeft = false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: kThemeBrightness(context) == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            isWideScreen = constraints.maxWidth >= kTabletBreakpoint;

            if (isWideScreen) {
              return wideScreenLayout();
            }

            return normalLayout();
          }),
        ),
      ),
    );
  }

  Widget wideScreenLayout() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 26.0),
            height: 30.0,
            child: pageIndicator(),
          ),
        ),
        PageView(
          controller: controller,
          onPageChanged: (i) => setState(() {
            currentPage = i;
            isLastSlide = currentPage == 2 ? true : false;
          }),
          children: List.generate(
            3,
            (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 80.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleText(title: OnboardingSlide.slides[i].title),
                        SizedBox(height: 40.0),
                        ShowUp(
                          direction:
                              isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
                          delay: 50,
                          child: actionButton(context),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 5,
                    child: Container(
                      // color: Colors.teal,
                      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: onboardingSlide(
                        subtitle: OnboardingSlide.slides[i].subtitle,
                        imageAsset: OnboardingSlide.slides[i].imageAsset,
                        cardGradient: OnboardingSlide.slides[i].cardGradient,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget normalLayout() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 26.0),
            height: 30.0,
            child: pageIndicator(),
          ),
        ),
        PageView(
          controller: controller,
          onPageChanged: (i) => setState(() {
            currentPage = i;
            isLastSlide = currentPage == 2 ? true : false;
          }),
          children: List.generate(
            3,
            (i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 60.0, 0.0, 0.0),
                    child: titleText(title: OnboardingSlide.slides[i].title),
                  ),
                  Expanded(
                    child: onboardingSlide(
                      subtitle: OnboardingSlide.slides[i].subtitle,
                      imageAsset: OnboardingSlide.slides[i].imageAsset,
                      cardGradient: OnboardingSlide.slides[i].cardGradient,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ShowUp(
            delay: 400,
            child: actionButton(context),
          ),
        ),
      ],
    );
  }

  PageIndicator pageIndicator() {
    return PageIndicator(
      currentSelectionIndex: currentPage,
      dotSize: isWideScreen ? 20.0 : null,
    );
  }

  Widget actionButton(BuildContext context) {
    return Container(
      width: isWideScreen
          ? kScreenAwareSize(220.0, context)
          : kDeviceWidth(context) - kScreenAwareSize(150.0, context),
      height: isWideScreen
          ? kScreenAwareSize(70.0, context)
          : kScreenAwareSize(50.0, context),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: kBrightnessAwareColor(
          context,
          lightColor: Colors.white,
          darkColor: isWideScreen ? Colors.white : Colors.black,
        ),
        // color: Colors.teal,
        borderRadius: BorderRadius.circular(
          kScreenAwareSize(16.0, context),
        ),
        boxShadow: [
          BoxShadow(
            color: kBrightnessAwareColor(context,
                lightColor: Colors.blueGrey.withOpacity(0.2),
                darkColor: Colors.grey[900].withOpacity(0.15)),
            blurRadius: 10.0,
            offset: Offset(5.0, 6.0),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(kScreenAwareSize(16.0, context)),
          onTap: onButtonPressed,
          child: Center(
            child: isDone
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      kBrightnessAwareColor(
                        context,
                        lightColor: Colors.black,
                        darkColor: isWideScreen ? Colors.black : Colors.white,
                      ),
                    ),
                  )
                : Text(
                    isLastSlide ? 'Get Started' : 'Next',
                    style: kTitleTextStyle.copyWith(
                      color: kBrightnessAwareColor(
                        context,
                        lightColor: Colors.black,
                        darkColor: isWideScreen ? Colors.black : Colors.white,
                      ),
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    if (isLastSlide) {
      setState(() => isDone = true);
      Future.delayed(Duration(milliseconds: 2000)).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });

      Box settingsBox = SettingsDatabase.settingsBox;
      settingsBox.put(SettingsDatabase.initLaunchKey, 1);
    } else {
      setState(() => isSwipeLeft = true);
      controller.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    }
  }

  Widget titleText({String title}) {
    return ShowUp(
      direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
      delay: 50,
      child: Text(
        title,
        style: TextStyle(
          fontSize: kScreenAwareSize(isWideScreen ? 70.0 : 40.0, context),
          fontFamily: 'Righteous',
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget onboardingSlide({
    @required String subtitle,
    @required String imageAsset,
    @required List<Color> cardGradient,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 26.0),
      child: ShowUp(
        direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(kScreenAwareSize(35.0, context)),
            gradient: LinearGradient(
              colors: cardGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(
                    kScreenAwareSize(isWideScreen ? 16.0 : 12.0, context)),
                child: Text(
                  subtitle,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: kTitleTextStyle.copyWith(
                    fontSize:
                        kScreenAwareSize(isWideScreen ? 22.0 : 16.0, context),
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              SizedBox(height: kScreenAwareSize(16.0, context)),
            ],
          ),
        ),
      ),
    );
  }
}
