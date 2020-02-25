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
  bool isSwipeLeft, isLastSlide, isDone;
  PageController controller;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    isSwipeLeft = true;
    isLastSlide = false;
    isDone = false;
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
          child: Stack(
            children: <Widget>[
              PageView(
                controller: controller,
                onPageChanged: (i) => setState(() {
                  currentPage = i;
                  isLastSlide = currentPage == 2 ? true : false;
                }),
                children: List.generate(3, (i) {
                  return onboardingSlide(
                    title: OnboardingSlide.slides[i].title,
                    subtitle: OnboardingSlide.slides[i].subtitle,
                    imageAsset: OnboardingSlide.slides[i].imageAsset,
                    cardGradient: OnboardingSlide.slides[i].cardGradient,
                  );
                }),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 26.0),
                  height: 30.0,
                  child: PageIndicator(currentPage),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ShowUp(
                  delay: 400,
                  child: GestureDetector(
                    child: Container(
                      width: kDeviceWidth(context) -
                          kScreenAwareSize(150.0, context),
                      height: kScreenAwareSize(50.0, context),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.white, darkColor: Colors.black),
                        borderRadius: BorderRadius.circular(
                            kScreenAwareSize(16.0, context)),
                        boxShadow: [
                          BoxShadow(
                            color: kBrightnessAwareColor(context,
                                lightColor: Colors.blueGrey.withOpacity(0.2),
                                darkColor: Colors.black26),
                            blurRadius: 10.0,
                            offset: Offset(5.0, 6.0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: isDone
                            ? CircularProgressIndicator()
                            : Text(
                                isLastSlide ? 'Get Started' : 'Next',
                                style: kTitleTextStyle.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0,
                                ),
                              ),
                      ),
                    ),
                    onTap: () {
                      if (isLastSlide) {
                        setState(() => isDone = true);
                        Future.delayed(Duration(milliseconds: 2000))
                            .whenComplete(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        });

                        Box settingsBox = Hive.box(SettingsDatabase.settings);
                        settingsBox.put(SettingsDatabase.initLaunchKey, 1);
                      } else {
                        setState(() => isSwipeLeft = true);
                        controller.animateToPage(
                          currentPage + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget onboardingSlide({
    @required String title,
    @required String subtitle,
    @required String imageAsset,
    @required List<Color> cardGradient,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 48.0),
          ShowUp(
            direction: isSwipeLeft ? ShowUpFrom.right : ShowUpFrom.left,
            delay: 50,
            child: Text(
              title,
              style: TextStyle(
                fontSize: kScreenAwareSize(40.0, context),
                fontFamily: 'Righteous',
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Expanded(
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
                      padding: EdgeInsets.all(kScreenAwareSize(12.0, context)),
                      child: Text(
                        subtitle,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: kTitleTextStyle.copyWith(
                          fontSize: kScreenAwareSize(16.0, context),
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
          ),
        ],
      ),
    );
  }
}
