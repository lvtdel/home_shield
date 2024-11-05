import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/domain/entities/user.dart';

class UserModel {
  String? id;
  final String email;
  final String? password;
  final String? name;
  final String? phoneNumber;
  final String? bloodType;
  final String? image;

  UserModel(
      {this.password,
      this.id,
      required this.name,
      required this.email,
      this.phoneNumber,
      this.bloodType,
      this.image});

  factory UserModel.fromEntity(UserApp user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      password: user.password,
      phoneNumber: user.phoneNumber,
      bloodType: user.bloodType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'bloodType': bloodType,
      'image': image
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        bloodType: map['bloodType'],
        image: map['image']);
  }

  UserApp toEntity() {
    return UserApp(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        bloodType: bloodType,
        image: image);
  }
}
