import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final bool? isOnline;
  final Timestamp? lastSeen;
  final String phoneNumber;
  final String bio;
  final String? profilePicUrl;
  final String? fcmToken;

  UserModel({
    required this.uid,
    required this.name,
    this.isOnline,
    this.lastSeen,
    required this.phoneNumber,
    required this.bio,
    required this.profilePicUrl,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
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
      isOnline: map['isOnline'] ?? false,
      lastSeen: map['lastSeen'] ?? Timestamp.now(),
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
    bool? isOnline,
    Timestamp? lastSeen,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
