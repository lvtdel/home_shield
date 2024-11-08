import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class SignInUseCase implements UseCase<Either, UserApp> {
  @override
  Future<Either> call({UserApp? params}) async {
    return sl<AuthRepository>().signIn(params!);
  }
}
