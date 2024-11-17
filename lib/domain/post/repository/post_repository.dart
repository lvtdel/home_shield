import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/post/entities/comment.dart';
import 'package:home_shield/domain/post/entities/post.dart';

abstract class PostRepository {
  Future<Either<String, List<Post>>> getFriendPosts();

  Future<Either> likePost(String postId);

  Future<Either> commentPost(Comment comment);

  Future<Either> savePost(String content, File? imageFile, String? image);

  Future<Either> deletePost(String postId);

  Future<Either<String, String>> getImageGenerateLink(String content);
}
