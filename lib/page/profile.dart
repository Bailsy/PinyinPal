


import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/imagepaths.dart';


class ProfileWidgets extends StatelessWidget{

  const ProfileWidgets({Key? key}): super(key: key);
   @override
    Widget build(BuildContext context){
    return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 76, 152, 238).withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.cog, color: Color.fromARGB(255, 76, 152, 238) ,),
                ),

                title: Text("Settings", style: Theme.of(context).textTheme.bodyLarge,),
                trailing:Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(LineAwesomeIcons.angle_right, color: Colors.grey),
                ),
     );
  }
}

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}): super(key: key);
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage>{


  @override
  Widget build(BuildContext context){
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    isDark = true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Profile", style: Theme.of(context).textTheme.headlineMedium,),
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
              Text ("大卫's profile", style: Theme.of(context).textTheme.headlineMedium,),
              Text("david@pinyinpal.com", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20,),
              SizedBox(width: 200,
               child: ElevatedButton(onPressed: () {},
               child: const Text("Edit Profile", style: TextStyle(color: Color.fromARGB(255, 26, 26, 26))))),
               const SizedBox(height: 30,),
               const Divider(),
               const SizedBox(height: 10,),
               const ProfileWidgets(),
               const ProfileWidgets(),
               const ProfileWidgets(),
               const ProfileWidgets(),
            ],
          )
        ),
      ),
    );
  }
}