import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/comment.dart';

class Post {
  final String? id;
  final String content;
  final String? image;
  final Timestamp createdAt;
  List<Comment>? comments;

  final UserApp? user;

  Post(
      {this.user,
      this.id,
      required this.content,
      this.image,
      required this.createdAt,
      this.comments});
}
