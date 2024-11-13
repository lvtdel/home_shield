import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class GetPostUseCase implements UseCase<Either<String, List<Post>>, dynamic> {
  @override
  Future<Either<String, List<Post>>> call({dynamic params}) async {
    return sl<PostRepository>().getFriendPosts();
  }
}
