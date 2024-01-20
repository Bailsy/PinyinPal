import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/model/profilemodel.dart';

class SetProfile {
  String profileUrl = "https://pinyinpal.com/login_api/user_profile.php";

  Future<void> setDetails(msg) async {
    var idofuser = {'idofuser': msg['userInfo']['UID']};
    var profilegrab =
        await http.post(Uri.parse(profileUrl), body: json.encode(idofuser));
    var profdetails = jsonDecode(profilegrab.body);
    print("working!");
    loadUserProfile(profdetails["ProfileInfo"]);
  }

  Future<void> loadUserProfile(jsonString) async {
    // Create a UserProfile object
    print(jsonString['EMAIL']);
    ProfileModelSingleton().updateProfileModel(
        email: jsonString['EMAIL'],
        profileImage: jsonString['PROFILEPIC'],
        userId: int.parse(jsonString['UID']),
        experience: int.parse(jsonString['XP']),
        userType: jsonString['USERTYPE'],
        username: jsonString['UNAME']);
  }
}
