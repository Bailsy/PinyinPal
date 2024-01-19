import 'package:flutter/foundation.dart';

class ProfileModel {
  final String email;
  final String profileImage;
  final int userId;
  final String username;
  final String userType;

  ProfileModel({
    required this.email,
    required this.profileImage,
    required this.userId,
    required this.username,
    required this.userType,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['EMAIL'],
      profileImage: json['PROFILEIMAGE'],
      userId: json['UID'],
      username: json['USERNAME'],
      userType: json['USERTYPE'],
    );
  }
}

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _currentProfile;

  ProfileModel? get currentProfile => _currentProfile;

  void setProfile(ProfileModel profile) {
    _currentProfile = profile;
    notifyListeners();
  }

  void clearProfile() {
    _currentProfile = null;
    notifyListeners();
  }

  void setProfileFromJson(Map<String, dynamic> json) {
    final profile = ProfileModel.fromJson(json);
    setProfile(profile);
  }
}

