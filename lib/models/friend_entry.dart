class FriendEntry {
  final String username;

  FriendEntry({
    required this.username,
  });

  factory FriendEntry.fromJson(Map<String, dynamic> json) {
    return FriendEntry(
      username: json['username'],
    );
  }
}
