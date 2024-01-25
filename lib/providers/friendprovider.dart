import 'package:flutter/material.dart';
import 'package:pinyinpal/models/friends_model.dart';
import 'package:pinyinpal/pages/friends.dart';
import 'package:provider/provider.dart';

class FriendProvider extends StatelessWidget {
  const FriendProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FriendModel(),
      child: const FriendsPage(),
    );
  }
}
