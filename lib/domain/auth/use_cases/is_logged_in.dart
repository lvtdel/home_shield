import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool,dynamic> {

  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }

}