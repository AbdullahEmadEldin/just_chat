class UserModel {
  final String uid;
  final String name;
  final String phoneNumber;
  final String bio;
  final String? profilePicUrl;
  final String? fcmToken;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.bio,
    required this.profilePicUrl,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'profilePicUrl': profilePicUrl,
      'fcmToken': fcmToken
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bio: map['bio'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? phoneNumber,
    String? bio,
    String? profilePicUrl,
    String? fcmToken,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
