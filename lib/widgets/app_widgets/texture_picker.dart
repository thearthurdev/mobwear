import 'package:flutter/material.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_indicator.dart';
import 'package:mobware/widgets/app_widgets/texture_blend_edit_button.dart';
import 'package:provider/provider.dart';

class TexturePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        String selectedTexture = provider.selectedTexture;
        String currentTexture = provider.currentTexture;
        int blendModeIndex = kGetTextureBlendModeIndex(
            provider.selectedBlendMode ?? provider.currentBlendMode);
        Color blendColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;

        return Column(
          children: <Widget>[
            Container(
              height: 300.0,
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: GridView.builder(
                itemCount: myTextures.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => provider.textureSelected(myTextures[i].asset),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          CustomizationIndicator(
                            texture: myTextures[i].asset,
                            textureBlendMode: myBlendModes[blendModeIndex].mode,
                            textureBlendColor: blendColor,
                            size: kScreenAwareSize(60, context),
                            isSelected: selectedTexture == null
                                ? currentTexture == myTextures[i].asset
                                : selectedTexture == myTextures[i].asset,
                          ),
                          SizedBox(height: 4.0),
                          Expanded(
                            child: Text(
                              myTextures[i].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextureBlendEditButton(
                      title: 'Blend Mode',
                      subtitle: myBlendModes[blendModeIndex].name,
                    ),
                  ),
                  SizedBox(width: 8.0),
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
