import 'package:get_it/get_it.dart';
import 'package:home_shield/data/auth/repositories/auth_repository_impl.dart';
import 'package:home_shield/data/auth/source/auth_firebase_service.dart';
import 'package:home_shield/data/chat/repositories/chat_repository_impl.dart';
import 'package:home_shield/data/chat/source/chat_firebase_service.dart';
import 'package:home_shield/data/emergency/repositories/emergency_repository.dart';
import 'package:home_shield/data/group/repositories/group_repository.dart';
import 'package:home_shield/data/map/repositories/map_repository.dart';
import 'package:home_shield/data/notification/repositories/notification_repostitory.dart';
import 'package:home_shield/data/post/repositories/post_repository_impl.dart';
import 'package:home_shield/data/post/source/post_firebase_service.dart';
import 'package:home_shield/data/service/dio_service.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/auth/use_cases/is_logged_in.dart';
import 'package:home_shield/domain/auth/use_cases/sign_in.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/domain/chat/use_case/get_contact.dart';
import 'package:home_shield/domain/chat/use_case/get_message.dart';
import 'package:home_shield/domain/chat/use_case/get_message.dart';
import 'package:home_shield/domain/chat/use_case/send_message.dart';
import 'package:home_shield/domain/chat/use_case/send_message.dart';
import 'package:home_shield/domain/emergency/use_case/send_location.dart';
import 'package:home_shield/domain/emergency/use_case/send_location.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/domain/post/use_cases/get_post.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<PostFirebaseService>(PostFirebaseServiceImpl());
  sl.registerSingleton<ChatFirebaseService>(ChatFirebaseServiceImpl());

  sl.registerSingleton<DioClient>(DioClient());

  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<PostRepository>(PostRepositoryImpl());
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl());
  sl.registerSingleton<GroupRepository>(GroupRepositoryImpl());
  sl.registerSingleton<EmergencyRepository>(EmergencyRepositoryImpl());
  sl.registerSingleton<MapRepository>(MapRepositoryImpl());
  sl.registerSingleton<NotificationRepository>(NotificationRepositoryImpl());

  // Use case
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  sl.registerSingleton<GetPostUseCase>(GetPostUseCase());

  sl.registerSingleton<GetContactUseCase>(GetContactUseCase());
  sl.registerSingleton<GetMessageUseCase>(GetMessageUseCase());
  sl.registerSingleton<SendMessageUseCase>(SendMessageUseCase());
  sl.registerSingleton<SendLocationUseCase>(SendLocationUseCase());
}
