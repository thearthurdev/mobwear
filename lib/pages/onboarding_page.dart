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
  PageController controller1, controller2, currentController;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    isSwipeLeft = true;
    isLastSlide = false;
    isDone = false;
    isWideScreen = false;
    controller1 = PageController();
    controller2 = PageController();
    controller1.addListener(handleSwipes);
    controller2.addListener(handleSwipes);
    OnboardingSlide.loadImageAssets(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    OnboardingSlide.precacheImageAssets(context);
    controller1 = PageController(initialPage: currentPage);
    controller2 = PageController(initialPage: currentPage);
  }

  void handleSwipes() {
    if (currentController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isSwipeLeft == false) setState(() => isSwipeLeft = true);
    } else if (currentController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isSwipeLeft == true) setState(() => isSwipeLeft = false);
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) && kDeviceIsLandscape(context);
    currentController = isWideScreen ? controller2 : controller1;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  OnboardingSlide.slides.elementAt(currentPage).cardGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: isWideScreen ? buildWideScreenLayout() : buildNormalLayout(),
          ),
        ),
      ),
    );
  }

  Widget buildWideScreenLayout() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: kScreenAwareSize(100.0, context),
          left: kScreenAwareSize(90.0, context),
          child: Container(
            height: 30.0,
            child: pageIndicator(),
          ),
        ),
        pageView(
          controller: controller2,
          child: (i) => Center(
            child: Padding(
              padding: EdgeInsets.all(
                kScreenAwareSize(48.0, context),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: kScreenAwareSize(40.0, context),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            titleText(OnboardingSlide.slides[i].title),
                            SizedBox(height: 16.0),
                            subtitleText(OnboardingSlide.slides[i].subtitle),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.teal,
                        child: slideImage(
                          subtitle: OnboardingSlide.slides[i].subtitle,
                          imageAsset: OnboardingSlide.slides[i].imageAsset,
                          cardGradient: OnboardingSlide.slides[i].cardGradient,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: kScreenAwareSize(30.0, context)),
            child: actionButton(context),
          ),
        ),
      ],
    );
  }

  Widget buildNormalLayout() {
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
        Container(
          margin: EdgeInsets.only(bottom: kScreenAwareSize(60.0, context)),
          child: pageView(
            controller: controller1,
            child: (i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 60.0, 0.0, 0.0),
                  child: titleText(OnboardingSlide.slides[i].title),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 16.0, 16.0, 0.0),
                  child: subtitleText(OnboardingSlide.slides[i].subtitle),
                ),
                Expanded(
                  child: Center(
                    child: slideImage(
                      subtitle: OnboardingSlide.slides[i].subtitle,
                      imageAsset: OnboardingSlide.slides[i].imageAsset,
                      cardGradient: OnboardingSlide.slides[i].cardGradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: kScreenAwareSize(8.0, context)),
            child: actionButton(context),
          ),
        ),
      ],
    );
  }

  PageView pageView({Widget child(int i), PageController controller}) {
    return PageView(
      controller: controller,
      onPageChanged: (i) => setState(() {
        currentPage = i;
        isLastSlide = currentPage == 2 ? true : false;
      }),
      children: List.generate(
        3,
        (i) {
          return child(i);
        },
      ),
    );
  }

  PageIndicator pageIndicator() {
    return PageIndicator(
      currentSelectionIndex: currentPage,
      dotSize: isWideScreen ? 20.0 : null,
      selectedColor: Colors.white,
      unselectedColor: Colors.white24,
    );
  }

  Widget titleText(String title) {
    return ShowUp(
      direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
      delay: 50,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: kScreenAwareSize(isWideScreen ? 60.0 : 40.0, context),
          fontFamily: 'Righteous',
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget subtitleText(String subtitle) {
    return ShowUp(
      direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
      delay: 50,
      child: Text(
        subtitle,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: kTitleTextStyle.copyWith(
          fontSize: kScreenAwareSize(isWideScreen ? 20.0 : 14.0, context),
          letterSpacing: 1.5,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget slideImage({
    @required String subtitle,
    @required String imageAsset,
    @required List<Color> cardGradient,
  }) {
    return ShowUp(
      direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
      child: Container(
        padding: EdgeInsets.all(kScreenAwareSize(24.0, context)),
        constraints: BoxConstraints(
          maxWidth: kScreenAwareSize(400.0, context),
          maxHeight: kScreenAwareSize(400.0, context),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageAsset),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButton(BuildContext context) {
    return ShowUp(
      delay: 400,
      child: Container(
        width: isWideScreen
            ? kScreenAwareSize(220.0, context)
            : kScreenAwareSize(140.0, context),
        height: isWideScreen
            ? kScreenAwareSize(70.0, context)
            : kScreenAwareSize(45.0, context),
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            kScreenAwareSize(isWideScreen ? 16.0 : 12.0, context),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[900].withOpacity(0.15),
              blurRadius: 10.0,
              offset: Offset(5.0, 6.0),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius:
                BorderRadius.circular(kScreenAwareSize(16.0, context)),
            onTap: onButtonPressed,
            child: Center(
              child: isDone
                  ? Container(
                      width:
                          kScreenAwareSize(isWideScreen ? 40.0 : 25.0, context),
                      height:
                          kScreenAwareSize(isWideScreen ? 40.0 : 25.0, context),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : Text(
                      isLastSlide ? 'Get Started' : 'Next',
                      style: kTitleTextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: kScreenAwareSize(
                            isWideScreen ? 18.0 : 12.0, context),
                      ),
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
      currentController.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    }
  }
}
