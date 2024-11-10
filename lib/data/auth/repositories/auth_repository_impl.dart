import 'package:dartz/dartz.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/data/auth/source/auth_firebase_service.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(UserApp user) async {
    return await sl<AuthFirebaseService>().signup(UserModel.fromEntity(user));
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getCurrentUser();
    return user.fold((error) {
      return Left(error);
    }, (data) {
      print(data);
      return Right(UserModel.fromMap(data).toEntity());
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> signIn(UserApp user) async {
    return await sl<AuthFirebaseService>().signIn(UserModel.fromEntity(user));
  }
}
