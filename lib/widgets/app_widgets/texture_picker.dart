import 'package:flutter/material.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/customization_indicator.dart';
import 'package:mobwear/widgets/app_widgets/texture_blend_edit_button.dart';
import 'package:provider/provider.dart';

class TexturePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        String selectedTexture = provider.selectedTexture;
        String currentTexture = provider.currentTexture;
        int blendModeIndex =
            provider.selectedBlendModeIndex ?? provider.currentBlendModeIndex;
        Color blendColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;
        BlendMode blendMode = kGetTextureBlendMode(blendModeIndex);

        return Column(
          children: <Widget>[
            Container(
              height: kScreenAwareSize(250.0, context),
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: GridView.builder(
                itemCount: MyTexture.myTextures.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, i) {
                  MyTexture myTexture = MyTexture.myTextures[i];

                  return GestureDetector(
                    onTap: () => provider.textureSelected(myTexture.asset),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          CustomizationIndicator(
                            texture: myTexture.asset,
                            textureBlendMode: blendMode,
                            textureBlendColor: blendColor,
                            size: 70.0,
                            isSelected: selectedTexture == null
                                ? currentTexture == myTexture.asset
                                : selectedTexture == myTexture.asset,
                          ),
                          SizedBox(height: 4.0),
                          Expanded(
                            child: Text(
                              myTexture.name,
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
                      subtitle: kGetTextureBlendModeName(blendModeIndex),
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
