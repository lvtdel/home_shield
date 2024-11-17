import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String content;
  String params;
  String type;
  String? image;
  Timestamp createdAt;

  NotificationModel(
      {this.id,
      this.image,
      required this.content,
      required this.params,
      required this.type,
      required this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      content: json['content'],
      params: json['params'],
      image: json['image'],
      type: json['type'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'params': params,
        'type': type,
        'image': image ??
            "https://firebasestorage.googleapis.com/v0/b/home-shield-ce8cb.firebasestorage.app/o/images%2Fgroup%2Fnotification_1540708456-900x900.png?alt=media&token=7c7caf50-a46f-4e46-9ca5-c1b6ed9d08d8",
        'created_at': createdAt,
      };
}
