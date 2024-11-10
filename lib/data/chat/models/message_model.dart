import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/chat/entities/message.dart';

class MessageModel {
  final String? id;
  final String? userId;
  final String content;
  final Timestamp createdAt;

  MessageModel(
      {this.id, this.userId, required this.content, required this.createdAt});

  factory MessageModel.fromEntity(Message message, String userId) {
    return MessageModel(
        userId: userId, content: message.content, createdAt: message.createdAt);
  }

  Message toEntity(UserApp user) {
    return Message(
        id: id, userApp: user, content: content, createdAt: createdAt);
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'content': content,
        'created_at': createdAt,
      };
}
