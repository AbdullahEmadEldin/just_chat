class UserModel {
  final String uid;
  final String name;
  final String phoneNumber;
  final String bio;
  final String? profilePicUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.bio,
    required this.profilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bio: map['bio'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
    );
  }
}
