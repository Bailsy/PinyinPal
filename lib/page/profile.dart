import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/imagepaths.dart';
import 'package:pinyinpal/page/home.dart';
import 'package:pinyinpal/page/login.dart';
import 'package:pinyinpal/widget/profilemenu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.moon))
        ],
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
                child: const Image(image: AssetImage(pUserProfileImage)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "大卫's profile",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("david@pinyinpal.com",
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
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ProfileWidgets(
              title: 'Logout',
              icon: LineAwesomeIcons.alternate_sign_out,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  LoginPage()));},
            ),
            PopScope(canPop: false, child: Container()),
          ],
        )),
      ),
    );
  }
}
