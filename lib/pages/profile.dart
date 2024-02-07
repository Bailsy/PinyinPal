import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/cachelogin.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/scanner.dart';
import 'package:pinyinpal/providers/friendprovider.dart';
import 'package:pinyinpal/widget/profilemenu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
            //padding: const EdgeInsets.all()
            child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(currentProfile.profileImage),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${currentProfile.username}'s profile",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(currentProfile.email,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Edit Profile",
                        style: TextStyle(
                            color: Color.fromARGB(255, 26, 26, 26))))),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileWidgets(
                title: "Settings",
                icon: LineAwesomeIcons.cog,
                onPress: () {
                  print("settings");
                }),
            ProfileWidgets(
                title: "Billing Details",
                icon: LineAwesomeIcons.wallet,
                onPress: () {
                  print("wallet");
                }),
            ProfileWidgets(
                title: "User Management",
                icon: LineAwesomeIcons.user_check,
                onPress: () {
                  print("user check");
                }),
            ProfileWidgets(
                title: "Scan",
                icon: LineAwesomeIcons.qrcode,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Scanner()));
                }),
            ProfileWidgets(
                title: "Add Friends",
                icon: LineAwesomeIcons.user_friends,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FriendProvider()));
                }),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ProfileWidgets(
              title: 'Logout',
              icon: LineAwesomeIcons.alternate_sign_out,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                CacheLogin.deleteCredentials();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
            PopScope(canPop: false, child: Container()),
          ],
        )),
      ),
    );
  }
}
