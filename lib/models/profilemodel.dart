class ProfileModel {
  final String email;
  final String profileImage;
  final int userId;
  final String userType;
  final int experience;
  final String username;

  ProfileModel({
    required this.email,
    required this.profileImage,
    required this.userId,
    required this.experience,
    required this.userType,
    required this.username,
  });
}

class ProfileModelSingleton {
  static final ProfileModelSingleton _instance =
      ProfileModelSingleton._internal();

  factory ProfileModelSingleton() {
    return _instance;
  }

  ProfileModelSingleton._internal();

  ProfileModel _profileModel = ProfileModel(
      email: '',
      profileImage: '',
      userId: 0,
      experience: 0,
      userType: '',
      username: '');

  ProfileModel get profileModel => _profileModel;

  // Method to update profile model with new data
  void updateProfileModel({
    required String email,
    required String profileImage,
    required int userId,
    required int experience,
    required String userType,
    required String username,
  }) {
    _profileModel = ProfileModel(
      email: email,
      profileImage: profileImage,
      userId: userId,
      experience: experience,
      userType: userType,
      username: username,
    );
  }
}
