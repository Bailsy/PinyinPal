import 'package:pinyinpal/models/databasecontrol.dart';
import 'package:pinyinpal/models/profilemodel.dart';

// This class is a static class that is used to interface with the profile page
// Make it static

class ProfileService {
  static const String profileUrl =
      "https://pinyinpal.com/login_api/user_profile.php";

  static Future<void> setDetails(msg) async {
    Future<List<dynamic>> futureList =
        DataBaseIntegration.getUserStats(msg['userInfo']['UID'].toString());
    List<dynamic> normalList = await futureList;

    loadUserProfile(normalList[0]);
  }

  static Future<void> reloadDetails() async {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    Future<List<dynamic>> futureList =
        DataBaseIntegration.getUserStats(currentProfile.userId.toString());
    List<dynamic> normalList = await futureList;

    loadUserProfile(normalList[0]);
  }

  static Future<void> loadUserProfile(jsonString) async {
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
