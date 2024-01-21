import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/model/databasecontrol.dart';
import 'package:pinyinpal/model/profilemodel.dart';

class SetProfile {
  String profileUrl = "https://pinyinpal.com/login_api/user_profile.php";

  Future<void> setDetails(msg) async {
    Future<List<dynamic>> futureList =
        DataBaseIntegration.getUserStats(msg['userInfo']['UID'].toString());
    List<dynamic> normalList = await futureList;

    loadUserProfile(normalList[0]);
  }

  Future<void> reloadDetails() async {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    Future<List<dynamic>> futureList =
        DataBaseIntegration.getUserStats(currentProfile.userId.toString());
    List<dynamic> normalList = await futureList;

    loadUserProfile(normalList[0]);
  }

  Future<void> loadUserProfile(jsonString) async {
    // Create a UserProfile object
    ProfileModelSingleton().updateProfileModel(
        email: jsonString['EMAIL'],
        profileImage: jsonString['PROFILEPIC'],
        userId: jsonString['UID'],
        experience: jsonString['XP'],
        userType: jsonString['USERTYPE'],
        username: jsonString['UNAME']);
  }
}
