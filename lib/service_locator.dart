import 'package:get_it/get_it.dart';
import 'package:home_shield/data/auth/repositories/auth_repository_impl.dart';
import 'package:home_shield/data/auth/source/auth_firebase_service.dart';
import 'package:home_shield/data/post/repositories/post_repository_impl.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/auth/use_cases/is_logged_in.dart';
import 'package:home_shield/domain/auth/use_cases/sign_in.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<PostFirebaseService>(PostFirebaseServiceImpl());

  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<PostRepository>(PostRepositoryImpl());

  // Use case
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

}
