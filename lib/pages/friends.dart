import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/friends_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/pages/profile.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: DeviceInfo.height / 100, left: 80, right: 80),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TextField(
                    controller: searchController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: pWhiteColour,
                      fontSize: StylingConstants.pFontSizeSmall,
                      fontFamily: StylingConstants.pStandartFont,
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Friend Name',
                      hintStyle: TextStyle(color: pLightGreyColour),
                      labelStyle: TextStyle(
                          color: pWhiteColour, //underline color
                          fontSize: StylingConstants.pFontSizeSmall),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: pWhiteColour),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: pWhiteColour),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  height: DeviceInfo.height / 1.2,
                  child: ChangeNotifierProvider(
                    create: (_) => CollectionModel(),
                    child: _buildBody(),
                  ))
            ],
          ),
        ));
  }

  //init stat

  Widget _buildBody() {
    return Consumer<FriendModel>(
      builder: (context, FriendModel, child) {
        if (FriendModel.usernames.isEmpty) {
          // If characters are not loaded, trigger loading
          FriendModel.loadData();
          return Center(child: CircularProgressIndicator());
        } else {
          // Build the grid with loaded characters
          return Container(
            margin: EdgeInsets.all(16.0), // Adjust the margin as needed
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3,
              ),
              itemCount: FriendModel.usernames.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(FriendModel.usernames[index]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCharacterItem(HskEntry character) {
    return GestureDetector(
      onTap: () {
        print("Character tapped: ${character.simplified}");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff303238),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            character.simplified,
            style: TextStyle(color: Colors.grey, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
