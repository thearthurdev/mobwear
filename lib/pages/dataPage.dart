import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/database/phone_database.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/widgets/app_widgets/elevated_card.dart';
import 'package:provider/provider.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomizationProvider provider =
        Provider.of<CustomizationProvider>(context);

    int currentPhoneBrandIndex = provider.currentPhoneBrandIndex;

    List<PhoneDataModel> phonesDataList = PhoneDataModel
        .phonesDataLists[currentPhoneBrandIndex].reversed
        .toList();

    List phonesBoxDataList =
        PhoneDatabase.phonesBox.values.toList().reversed.toList();

    List<PhoneModel> phonesList =
        PhoneModel.phonesLists[currentPhoneBrandIndex].reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(LineAwesomeIcons.refresh),
            onPressed: () {
              PhoneDatabase.phonesBox.clear();
              print('phones database cleared');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: phonesDataList.length,
        itemBuilder: (context, i) {
          return dataCard(
            phoneID: phonesDataList[i].id,
            phoneName: phonesList[i].phone.getPhoneName,
            defaultColors: phonesDataList[i].colors,
            boxColors: phonesBoxDataList[i].colors,
            // textures: phonesDataList[i].textures,
          );
        },
      ),
    );
  }

  Widget dataCard(
      {int phoneID, String phoneName, defaultColors, boxColors, textures}) {
    return ElevatedCard(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('ID'),
            subtitle: Text('$phoneID'),
          ),
          ListTile(
            title: Text('Phone'),
            subtitle: Text('$phoneName'),
          ),
          ListTile(
            title: Text('Default Colors'),
            subtitle: Text('$defaultColors'),
          ),
          ListTile(
            title: Text('Box Colors'),
            subtitle: Text('$boxColors'),
          ),
          // ListTile(
          //   title: Text('Textures'),
          //   subtitle: Text('$textures'),
          // ),
        ],
      ),
    );
  }
}
