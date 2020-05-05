import 'package:flutter/material.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/customization_indicator.dart';
import 'package:mobwear/widgets/app_widgets/texture_blend_edit_button.dart';
import 'package:provider/provider.dart';

class TexturePicker extends StatelessWidget {
  static bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) && kDeviceIsLandscape(context);

    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        String selectedTexture = provider.selectedTexture;
        String currentTexture = provider.currentTexture;
        int blendModeIndex =
            provider.selectedBlendModeIndex ?? provider.currentBlendModeIndex;
        Color blendColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;
        BlendMode blendMode = kGetTextureBlendMode(blendModeIndex);

        Widget buildTextureGridItem(int i) {
          MyTexture myTexture = MyTexture.myTextures[i];

          return Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () => provider.textureSelected(myTexture.asset),
              child: Container(
                height: 100.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: CustomizationIndicator(
                          texture: myTexture.asset,
                          textureBlendMode: blendMode,
                          textureBlendColor: blendColor,
                          isSelected: selectedTexture == null
                              ? currentTexture == myTexture.asset
                              : selectedTexture == myTexture.asset,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      myTexture.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 300.0),
              margin: EdgeInsets.only(bottom: 4.0),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 60.0),
                itemCount: MyTexture.myTextures.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWideScreen ? 6 : 4),
                itemBuilder: (context, i) => buildTextureGridItem(i),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextureBlendEditButton(
                      title: 'Blend Mode',
                      subtitle: kGetTextureBlendModeName(blendModeIndex),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: TextureBlendEditButton(
                      title: 'Blend Color',
                      subtitle: '#${kGetColorString(blendColor)}',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
