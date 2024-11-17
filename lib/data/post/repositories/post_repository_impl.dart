import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/data/post/models/post_model.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/data/service/dio_service.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/comment.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/service_locator.dart';
import 'package:path/path.dart' as pathLib;

class PostRepositoryImpl extends PostRepository {
  final postFirebaseService = sl<PostFirebaseService>();
  final _postCollection = FirebaseFirestore.instance.collection("posts");

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

      posts.sort((b, a) => a.createdAt.compareTo(b.createdAt));
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
  Future<Either> savePost(
      String content, File? imageFile, String? image) async {
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid ??
          "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";

      if (image == null && imageFile == null) {
        PostModel postModel = PostModel(
            content: content, createdAt: Timestamp.now(), userId: userId);
        await _postCollection.add(postModel.toJson());

        return Right(true);
      }

      var imagePath = image ?? (await uploadFile("images/post/", imageFile!));
      PostModel postModel = PostModel(
          content: content,
          createdAt: Timestamp.now(),
          image: imagePath,
          userId: userId);

      await _postCollection.add(postModel.toJson());

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> getImageGenerateLink(String content) async {
    var dio = sl<DioClient>().dio;

    var data = {'text': content};

    // Send the POST request
    try {
      Response response = await dio.post(
        'https://api.deepai.org/api/text2img',
        data: data, // Passing data as JSON
      );

      print(response.data);
      var imageUrl = response.data['share_url'];

      Dio dio2 = Dio();
      Response responseFile = await dio2.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));

      // Lấy dữ liệu bytes của ảnh
      final bytes = responseFile.data;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/post/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putData(Uint8List.fromList(bytes));

      await uploadTask.whenComplete(() async {
        // Lấy URL của ảnh đã upload
        final downloadUrl = await storageRef.getDownloadURL();
        print('Ảnh đã được upload và có URL: $downloadUrl');
      });

      return Right(await storageRef.getDownloadURL());
    } catch (e) {
      if (e is DioError) {
        // Handle DioError
        print('DioError: ${e.response?.data}');
      } else {
        // Handle other errors
        print('Error: $e');
      }

      return Left(e.toString());
    }
  }

  Future<String> uploadFile(String path, File file) async {
    String fileExtension = pathLib.extension(file.path);
    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
    Reference storageRef =
        FirebaseStorage.instance.ref().child("$path$fileName");
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }
}
