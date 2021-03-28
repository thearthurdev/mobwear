import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/aspect_ratio_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';
import 'package:provider/provider.dart';

class AspectRatioPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isWideScreen = kIsWideScreen(context) && kDeviceIsLandscape(context);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575),
            darkColor: isWideScreen ? Colors.black : Color(0xFF060606)),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AdaptiveDialog(
        title: 'Aspect Ratio',
        hasSelectButton: false,
        maxWidth: 300.0,
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: MyAspectRatio.myAspectRatios.length,
            itemBuilder: (context, i) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                title: Text(MyAspectRatio.myAspectRatios[i].name),
                trailing: Provider.of<CustomizationProvider>(context)
                            .aspectRatioIndex ==
                        i
                    ? Icon(
                        LineAwesomeIcons.check_circle,
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.black, darkColor: Colors.white),
                      )
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<CustomizationProvider>(context, listen: false)
                      .changeAspectRatioIndex(i);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
