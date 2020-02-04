import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobware/data/models/brand_tab_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class PhoneCarousel extends StatefulWidget {
  final BrandTab brandTab;

  PhoneCarousel(this.brandTab);

  @override
  _PhoneCarouselState createState() => _PhoneCarouselState();
}

class _PhoneCarouselState extends State<PhoneCarousel> {
  bool autoplay;
  SwiperController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.brandTab.controller;
  }

  @override
  Widget build(BuildContext context) {
    List<PhoneModel> phoneList = widget.brandTab.list;
    int reverseIndex(i) => phoneList.length - 1 - i;

    // print('carousel building');

    autoplay = Provider.of<SettingsProvider>(context).tempAutoplayValue ??
        Provider.of<SettingsProvider>(context).autoplayCarousel;

    return Swiper(
      controller: controller,
      itemCount: phoneList.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.all(kScreenAwareSize(24.0, context)),
          child: Hero(
            tag: phoneList[reverseIndex(i)].id,
            child: phoneList[reverseIndex(i)].phone,
          ),
        );
      },
      autoplay: autoplay,
      autoplayDisableOnInteraction: true,
      duration: 800,
      outer: true,
      fade: 0.0,
      viewportFraction: 1.0,
      scale: 1.0,
      pagination: SwiperPagination(
        margin: EdgeInsets.only(right: 50.0, bottom: 8.0),
        builder: DotSwiperPaginationBuilder(
          activeColor: kBrightnessAwareColor(context,
              lightColor: Colors.black, darkColor: Colors.white),
          color: kBrightnessAwareColor(context,
              lightColor: Colors.grey[350], darkColor: Colors.grey[800]),
          size: kScreenAwareSize(8.0, context),
          activeSize: kScreenAwareSize(8.0, context),
        ),
      ),
      onTap: (i) {
        controller.stopAutoplay();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditPhonePage(
                phone: phoneList[reverseIndex(i)].phone,
                phoneList: phoneList,
                phoneIndex: reverseIndex(i),
              );
            },
          ),
        ).whenComplete(
          () {
            if (Provider.of<SettingsProvider>(context).autoplayCarousel ==
                true) {
              Provider.of<SettingsProvider>(context)
                  .changeTempAutoplayValue(true);
            } else {
              Provider.of<SettingsProvider>(context)
                  .changeTempAutoplayValue(false);
            }
          },
        );
      },
    );
  }
}
