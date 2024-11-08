import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/comment.dart';

class CommentModel {
  String? id;
  String content;
  Timestamp? createdAt;

  String? postId;
  String? userId;

  CommentModel(
      {this.id,
      this.createdAt,
      required this.content,
      this.userId,
      this.postId});

  Comment toEntity(UserApp user) {
    return Comment(
        content: content,
        id: id,
        createdAt: createdAt,
        user: user,
        postId: postId);
  }

  factory CommentModel.fromEntity(Comment comment, String userId) {
    return CommentModel(
        content: comment.content,
        createdAt: comment.createdAt,
        postId: comment.postId,
        userId: userId);
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'created_at': createdAt,
        'post_id': postId,
        'user_id': userId,
      };
}
