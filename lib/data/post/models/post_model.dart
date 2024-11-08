import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/data/post/models/comment_model.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/comment.dart';
import 'package:home_shield/domain/post/entities/post.dart';

class PostModel {
  final String? id;
  final String content;
  final String? image;
  final Timestamp createdAt;
  List<CommentModel>? comments;

  final String? userId;

  PostModel(
      {this.id,
      required this.content,
      required this.image,
      required this.createdAt,
      this.userId,
      this.comments});

  Post toEntity(UserApp user) {
    return Post(
        user: user,
        id: id,
        content: content,
        createdAt: createdAt,
        image: image,
        comments: comments?.map((e) => e.toEntity(user)).toList());
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
        content: post.content, image: post.image, createdAt: post.createdAt);
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      createdAt: json['created_at'],
      comments: json['comments'] == null
          ? null
          : List<CommentModel>.from(
              json['comments'].map((x) => CommentModel.fromJson(x))),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'image': image,
        'createdAt': createdAt,
        'comments': comments?.map((e) => e.toJson()).toList(),
        'userId': userId,
      };
}
