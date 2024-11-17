import 'package:cloud_firestore/cloud_firestore.dart';

class LocationInfoModel {
  final String? id;
  final String? userName;
  final String? userId;
  final GeoPoint? location;
  final Timestamp? createAt;
  final String? phoneNumber;
  final String? image;

  LocationInfoModel({this.id, this.userName, this.userId, this.location, this.createAt, this.phoneNumber, this.image});

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) {
    return LocationInfoModel(
      userName: json['name'],
      userId: json['id'],
      location:json['location'],
      createAt: json['create_at'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'userName': userName,
  //       'userId': userId,
  //       'location': location?.toJson(),
  //       'createAt': createAt?.toJson(),
  //     };
}