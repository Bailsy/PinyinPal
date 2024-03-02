import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/friends_model.dart';
import 'package:pinyinpal/models/sendfriendrequest.dart';
import 'package:pinyinpal/pages/friendstat.dart';
import 'package:pinyinpal/pages/stats/stats.dart';
import 'package:pinyinpal/widget/friendnavbar.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const FriendsPage({super.key});
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      bottomNavigationBar: FriendsNavBar(
        onIndexChanged: (index) {
          setState(() {
            indexPos = index;
          });
        },
      ),
      body: IndexedStack(
        index: indexPos,
        children: const [FriendFinder(), FriendRequest(), FriendCircle()],
      ),
    );
  }
}

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  FriendRequestState createState() => FriendRequestState();
}

class FriendRequestState extends State<FriendRequest> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: DeviceInfo.height / 1.2,
              child: ChangeNotifierProvider(
                create: (_) => CollectionModel(),
                child: _buildBody(),
              ))
        ],
      ),
    );
  }

  //init stat

  Widget _buildBody() {
    return Consumer<FriendModel>(
      builder: (context, FriendModel, child) {
        if (FriendModel.requests.isEmpty) {
          return const Center(child: Text("No Requests found"));
        } else {
          // Build the grid with loaded characters
          return Container(
            margin: const EdgeInsets.all(16.0), // Adjust the margin as needed
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
              ),
              itemCount: FriendModel.requests.length,
              itemBuilder: (context, index) {
                return _buildFriendItem(FriendModel.requests[index]["UNAME"],
                    FriendModel.requests[index]["UID"]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildFriendItem(String username, String identification) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff303238).withOpacity(0),
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
              style: const TextStyle(color: Colors.grey, fontSize: 30),
            ),
            Container(
              width: 100,
            ),
            InkWell(
              onTap: () {
                SendFriendRequest sf = SendFriendRequest();
                sf.denyRequest(identification);
                print("Character tapped: $username");
              },
              child: const Icon(LineAwesomeIcons.times,
                  color: Colors.red, size: 45),
            ),
            InkWell(
              onTap: () {
                SendFriendRequest sf = SendFriendRequest();
                sf.acceptRequest(identification);
                print("Character tapped: $username");
              },
              child: const Icon(LineAwesomeIcons.check,
                  color: Colors.green, size: 45),
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

class FriendCircle extends StatefulWidget {
  const FriendCircle({super.key});

  @override
  FriendCircleState createState() => FriendCircleState();
}

class FriendCircleState extends State<FriendCircle> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: DeviceInfo.height / 1.2,
              child: ChangeNotifierProvider(
                create: (_) => CollectionModel(),
                child: _buildBody(),
              ))
        ],
      ),
    );
  }

  //init stat

  Widget _buildBody() {
    return Consumer<FriendModel>(
      builder: (context, FriendModel, child) {
        if (FriendModel.friends.isEmpty) {
          return const Center(child: Text("No Friends"));
        } else {
          // Build the grid with loaded characters
          return Container(
            margin: const EdgeInsets.all(16.0), // Adjust the margin as needed
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 4,
              ),
              itemCount: FriendModel.friends.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(FriendModel.friends[index]["UNAME"]);
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
          color: const Color(0xff303238).withOpacity(0),
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
              style: const TextStyle(color: Colors.grey, fontSize: 30),
            ),
            Container(
              width: 100,
            ),
            Column(
              // Align icons vertically using Column
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 30),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendStats(),
                            //here we pass in the reload page void call back so we can update the collection page
                          ),
                        );
                      },
                      child: const Icon(LineAwesomeIcons.bar_chart_1,
                          color: pBlueColour, size: 45),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(LineAwesomeIcons.circle,
                          color: pBlueColour, size: 45),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendFinder extends StatefulWidget {
  const FriendFinder({super.key});

  @override
  FriendFinderState createState() => FriendFinderState();
}

class FriendFinderState extends State<FriendFinder> {
  TextEditingController searchController = TextEditingController();

  String searchTerm = "";
  String previousSearchTerm = "";

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          if (searchController.text.isNotEmpty) {
            searchTerm = searchController.text;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(
              height: DeviceInfo.height / 1.2,
              child: ChangeNotifierProvider(
                create: (_) => CollectionModel(),
                child: _buildBody(),
              ))
        ],
      ),
    );
  }

  //init stat

  Widget _buildBody() {
    return Consumer<FriendModel>(
      builder: (context, FriendModel, child) {
        if (searchTerm != previousSearchTerm) {
          // If search term has changed, trigger loading
          FriendModel.loadUsers(searchTerm);
          // Update the current search term in FriendModel
          previousSearchTerm = searchTerm;
        }
        if (FriendModel.usernames.isEmpty && searchController.text.isNotEmpty) {
          // If characters are not loaded, trigger loading
          FriendModel.loadUsers(searchTerm);

          return const Center(child: CircularProgressIndicator());
        } else {
          // Build the grid with loaded characters
          return Container(
            margin: const EdgeInsets.all(16.0), // Adjust the margin as needed
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
                    FriendModel.usernames[index]["UNAME"],
                    FriendModel.usernames[index]["UID"]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCharacterItem(String username, String friendID) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff303238).withOpacity(0),
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
              style: const TextStyle(color: Colors.grey, fontSize: 30),
            ),
            Container(
              width: 100,
            ),
            Column(
              // Align icons vertically using Column
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 30),
                InkWell(
                  onTap: () {
                    print("Character tapped: $friendID");
                    SendFriendRequest sf = SendFriendRequest();

                    sf.sendRequest(friendID);
                  },
                  child: const Icon(LineAwesomeIcons.user_friends,
                      color: pBlueColour, size: 45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
