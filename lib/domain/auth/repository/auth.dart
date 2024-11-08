import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/entites/user.dart';

abstract class AuthRepository {
  Future<Either> signUp(UserApp user);
  Future<Either> signIn(UserApp user);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}
