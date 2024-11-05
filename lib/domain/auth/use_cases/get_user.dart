import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }

}