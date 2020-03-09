import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/aspect_ratio_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class AspectRatioPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Color(0xFF060606)),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SimpleDialog(
        contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Aspect Ratio',
              style: kTitleTextStyle.copyWith(fontSize: 18.0),
            ),
          ],
        ),
        children: <Widget>[
          Container(
            width: kDeviceWidth(context) - 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: MyAspectRatio.myAspectRatios(context).length,
              itemBuilder: (context, i) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text(MyAspectRatio.myAspectRatios(context)[i].name),
                  trailing: Provider.of<CustomizationProvider>(context)
                              .aspectRatioIndex ==
                          i
                      ? Icon(
                          LineAwesomeIcons.check_circle,
                          color: kBrightnessAwareColor(context,
                              lightColor: Colors.black,
                              darkColor: Colors.white),
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<CustomizationProvider>(context)
                        .changeAspectRatioIndex(i);
                  },
                );
              },
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonTextTheme: ButtonTextTheme.normal,
            children: <Widget>[
              FlatButton(
                child: Text('Cancel', style: kTitleTextStyle),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
