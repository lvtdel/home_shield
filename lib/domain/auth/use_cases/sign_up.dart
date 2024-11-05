import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/entities/user.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class SignupUseCase implements UseCase<Either, UserApp> {
  @override
  Future<Either> call({UserApp ? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}