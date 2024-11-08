import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/data/post/models/post_model.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/comment.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/service_locator.dart';

class PostRepositoryImpl extends PostRepository {
  final postFirebaseService = sl<PostFirebaseService>();

  @override
  Future<Either<String, List<Post>>> getFriendPosts() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    var returnedData = await postFirebaseService.getFriendPosts(currentUserId);

    return returnedData.fold((error) {
      return Left(error);
    }, (data) async {
      print(data);

      // Sử dụng Future.wait() để thực hiện các tác vụ bất đồng bộ đồng thời
      List<Post> posts = await Future.wait(data.map((postModel) async {
        String userId = postModel.userId!;
        UserApp userApp = UserApp(email: "vothelucErr", name: "LucvtE");

        // Lấy thông tin người dùng từ dịch vụ
        var userResponse = await postFirebaseService.getUser(userId);
        userResponse.fold((e) {
          print("Get user error, userId: ${postModel.userId}");
        }, (user) {
          userApp = user.toEntity();

        });

        // Chuyển đổi postModel sang đối tượng Post và trả về
        return postModel.toEntity(userApp);
      }).toList());

      return Right(posts); // Trả về Right với danh sách Post đã hoàn tất
    });
  }

  @override
  Future<Either> likePost(String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either> commentPost(Comment comment) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }

  @override
  Future<Either> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either> savePost(Post post) {
    // TODO: implement savePost
    throw UnimplementedError();
  }
}
