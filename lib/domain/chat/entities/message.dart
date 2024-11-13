import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_shield/domain/auth/entites/user.dart';

class Message {
  final String? id;
  final UserApp? userApp;
  final String content;
  final Timestamp createdAt;

  Message(
      {this.id, this.userApp, required this.content, required this.createdAt});
}
