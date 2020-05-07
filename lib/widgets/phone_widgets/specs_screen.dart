import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/services/phone_specs.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';

class SpecModel {
  String name;
  IconData icon;

  SpecModel({this.name, this.icon});

  static List<SpecModel> specs = [
    SpecModel(name: 'Battery', icon: LineAwesomeIcons.battery_0),
    SpecModel(name: 'Camera', icon: LineAwesomeIcons.camera),
    SpecModel(name: 'Memory', icon: LineAwesomeIcons.database),
    SpecModel(name: 'Headphone Jack', icon: LineAwesomeIcons.headphones),
    SpecModel(name: 'Weight', icon: LineAwesomeIcons.balance_scale),
    SpecModel(name: 'Display', icon: LineAwesomeIcons.mobile),
  ];
}

class SpecsScreen extends StatefulWidget {
  final String phoneBrand, phoneModel, phoneName;

  const SpecsScreen({this.phoneBrand, this.phoneModel, this.phoneName});

  @override
  _SpecsScreenState createState() => _SpecsScreenState();
}

class _SpecsScreenState extends State<SpecsScreen> {
  PageController pageController;
  int page;
  int selectedSpec;
  String spec;

  @override
  void initState() {
    super.initState();
    page = 0;
    selectedSpec = 0;
    pageController = PageController(
      initialPage: page,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        buildSpecGridPage(),
        buildResultPage(context),
      ],
    );
  }

  FutureBuilder<List> buildSpecGridPage() {
    return FutureBuilder(
      future: PhoneSpecs().getPhoneSpecs(
        brand: widget.phoneBrand,
        model: widget.phoneModel,
        device: widget.phoneName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAccentButton(icon: LineAwesomeIcons.gears),
              SizedBox(height: 8.0),
              Text('No specs found', style: kTitleTextStyle),
              SizedBox(height: 4.0),
              Text('Try again later', style: kSubtitleTextStyle),
            ],
          );
        }

        List specsList = snapshot.data;

        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Specs',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    SpecModel.specs.length,
                    (i) {
                      return Center(
                        child: CircleAccentButton(
                          icon: SpecModel.specs[i].icon,
                          index: i,
                          onTap: () {
                            pageController.animateToPage(
                              1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                            selectedSpec = i;
                            spec = specsList[i];
                            page = 1;
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildResultPage(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: () {
              page = 0;
              pageController.animateToPage(
                0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CircleAccentButton(
                      icon: SpecModel.specs[selectedSpec].icon ?? Icons.close,
                      index: selectedSpec ?? 0,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      SpecModel.specs[selectedSpec].name ?? 'Spec Name',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        spec ?? 'No data found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: spec == null
                              ? kBrightnessAwareColor(context,
                                  lightColor: Colors.black38,
                                  darkColor: Colors.white38)
                              : null,
                          fontSize: 18.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Data retreived from\nfonoApi database',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
