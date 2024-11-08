import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/domain/auth/entites/user.dart';

class Comment {
  String? id;
  String content;
  Timestamp? createdAt;
  String? postId;

  UserApp? user;

  Comment(
      {this.user, this.id, this.createdAt, required this.content, this.postId});
}
