import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uId;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String image;
  final String university;
  final String faculty;
  final Timestamp createdAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.image,
    required this.university,
    required this.faculty,
    required this.uId,
    required this.createdAt,
  });

  // Add this static method to fetch user from Firestore
  static Future<UserModel?> getUserModelFromFirestore(String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromJson(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      university: json['university'] ?? '',
      faculty: json['faculty'] ?? '',
      uId: json['uId'] ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt'] as Timestamp
          : Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'email': email,
      'image': image,
      'university': university,
      'faculty': faculty,
      'uId': uId,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'image': image,
      'university': university,
      'faculty': faculty,
      'uId': uId,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModel.fromJson(map);
}
