import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/friends_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/pages/profile.dart';
import 'package:pinyinpal/widget/friendnavbar.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const FriendsPage({Key? key});
  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  int indexPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.user),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: FriendsNavBar(
        onIndexChanged: (index) {
          setState(() {
            indexPos = index;
            print(indexPos);
          });
        },
      ),
      body: IndexedStack(
        index: indexPos,
        children: const [FriendFinder(), FriendRequest()],
      ),
    );
  }
}

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  FriendRequestState createState() => FriendRequestState();
}

class FriendRequestState extends State<FriendRequest> {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
              ),
              itemCount: FriendModel.usernames.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(
                    FriendModel.usernames[index]["UNAME"]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCharacterItem(String username) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff303238).withOpacity(0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 10,
            ),
            Text(
              username,
              style: TextStyle(color: Colors.grey, fontSize: 30),
            ),
            Container(
              width: 100,
            ),
            InkWell(
              onTap: () {
                print("Character tapped: ${username}");
              },
              child: Icon(LineAwesomeIcons.times, color: Colors.red, size: 45),
            ),
            InkWell(
              onTap: () {
                print("Character tapped: ${username}");
              },
              child:
                  Icon(LineAwesomeIcons.check, color: Colors.green, size: 45),
            ),
            Container(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class FriendFinder extends StatefulWidget {
  const FriendFinder({Key? key}) : super(key: key);

  @override
  FriendFinderState createState() => FriendFinderState();
}

class FriendFinderState extends State<FriendFinder> {
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
                    //textAlign: TextAlign.center,
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
                        prefixIcon: Icon(
                          LineAwesomeIcons.search,
                          color: pLightGreyColour,
                        )),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
              ),
              itemCount: FriendModel.usernames.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(
                    FriendModel.usernames[index]["UNAME"]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCharacterItem(String username) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff303238).withOpacity(0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 10,
            ),
            Text(
              username,
              style: TextStyle(color: Colors.grey, fontSize: 30),
            ),
            Container(
              width: 100,
            ),
            InkWell(
              onTap: () {
                print("Character tapped: ${username}");
              },
              child: Icon(LineAwesomeIcons.user_friends,
                  color: pBlueColour, size: 45),
            ),
            Container(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
