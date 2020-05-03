import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class AdaptiveDialog extends StatelessWidget {
  final String title, selectText;
  final Widget child;
  final double maxWidth;
  final bool hasSelectButton, hasCancelButton, hasButtonBar;
  final Function onSelectPressed, onCancelPressed;

  const AdaptiveDialog({
    @required this.title,
    @required this.child,
    this.onSelectPressed,
    this.onCancelPressed,
    this.selectText,
    this.maxWidth,
    this.hasSelectButton = true,
    this.hasCancelButton = true,
    this.hasButtonBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? 500.0,
                  maxHeight: kDeviceHeight(context),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(top: 8.0, left: 24.0),
                        title: Text(
                          title,
                          style: kTitleTextStyle.copyWith(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: child,
                    ),
                    hasButtonBar
                        ? Flexible(
                            child: ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonTextTheme: ButtonTextTheme.normal,
                              children: <Widget>[
                                hasCancelButton
                                    ? FlatButton(
                                        child: Text('Cancel',
                                            style: kTitleTextStyle),
                                        onPressed: () => onCancelPressed == null
                                            ? Navigator.pop(context)
                                            : onCancelPressed(),
                                      )
                                    : SizedBox(),
                                hasSelectButton
                                    ? FlatButton(
                                        child: Text(selectText ?? 'Select',
                                            style: kTitleTextStyle),
                                        onPressed: () => onSelectPressed == null
                                            ? Navigator.pop(context)
                                            : onSelectPressed(),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
