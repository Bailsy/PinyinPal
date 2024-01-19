


import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}): super(key: key);
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
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


        ),
      ),
    );
  }
}