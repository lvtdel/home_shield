import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/data/post/models/comment_model.dart';
import 'package:home_shield/data/post/models/post_model.dart';
import 'package:home_shield/domain/post/entities/post.dart';

abstract class PostFirebaseService {
  Future<Either<String, List<PostModel>>> getFriendPosts(String userId);

  Future<Either> likePost(String userId, String postId);

  Future<Either> commentPost(CommentModel comment);

  Future<Either> savePost(PostModel post);

  Future<Either> deletePost(String userId, String postId);

  Future<Either<String, UserModel>> getUser(String userId);
}

class PostFirebaseServiceImpl extends PostFirebaseService {
  @override
  Future<Either> commentPost(CommentModel comment) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<Either> deletePost(String userId, String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<PostModel>>> getFriendPosts(String userId) async {
    try {
      List<String> groupIds = await friendList(userId);
      print("Friend: $groupIds");

      var posts = await FirebaseFirestore.instance
          .collection("posts")
          .where('user_id', whereIn: groupIds)
          .get();

      // Dùng Future.wait để lấy comments cho mỗi post đồng thời
      List<PostModel> postsWithComments = await Future.wait(posts.docs.map((postDoc) async {
        // Lấy thông tin của post
        PostModel post = PostModel.fromJson(postDoc.data());
        String postId = postDoc.id;

        // Lấy comments cho post này
        var commentsSnapshot = await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .get();

        List<CommentModel> comments = commentsSnapshot.docs.map((commentDoc) {
          return CommentModel.fromJson(commentDoc.data());
        }).toList();

        // Cập nhật bài post với danh sách comments
        post.comments = comments;

        return post;
      }).toList());

      return Right(postsWithComments);

      // return Right(
      //     posts.docs.map((e) => PostModel.fromJson(e.data())).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<List<String>> friendList(String userId) async {
    var user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<String> groupIds = (user.get("group_ids") as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        List.empty();

    if (groupIds.isEmpty) {
      print("FirebaseService return empty groupIds");
      return List<String>.empty();
    }
    Set<String> friendIds = {};

    for (String groupId in groupIds) {
      var groupSnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .get();

      if (groupSnapshot.exists) {
        List<String> userIds = List<String>.from(groupSnapshot.get("user_ids"));
        friendIds.addAll(userIds);
      }
    }
    return friendIds.toList();
  }

  @override
  Future<Either> likePost(String userId, String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either> savePost(PostModel post) {
    // TODO: implement savePost
    throw UnimplementedError();
  }

  @override
  Future<Either<String, UserModel>> getUser(String userId) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return Right(UserModel.fromMap(user.data()!));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
