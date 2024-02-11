import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String name;
  String email;
  String password;
  String uid;
  String imageUrl;
  String phoneNo;

  UserDataModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.imageUrl,
    required this.phoneNo,
  });

  factory UserDataModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserDataModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      uid: map['uid'],
      imageUrl: map['userImage'],
      phoneNo: map['phoneNo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'userImage': imageUrl,
      'phoneNo': phoneNo,
    };
  }
}
