import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/auth/source/auth_firebase_service.dart';
import 'package:home_shield/data/chat/models/message_model.dart';
import 'package:home_shield/data/chat/source/chat_firebase_service.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/service_locator.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatFirebaseService _chatFirebaseService = sl<ChatFirebaseService>();
  final AuthFirebaseService _authFirebaseService = sl<AuthFirebaseService>();

  @override
  Future<Either<String, List<Group>>> getContacts() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // String userId = "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";

    return (await _chatFirebaseService.getContacts(userId)).fold((e) => Left(e),
        (groupModels) {
      return Right(
          groupModels.map((groupModel) => groupModel.toEntity()).toList());
    });
  }

  @override
  Future<Either<String, Stream<List<Message>>>> getMessages(
      String groupId) async {
    var data = await _chatFirebaseService.getMessages(groupId);

    return data.fold(
      (e) => Left(e),
      (dataStream) {
        return Right(
          dataStream.asyncMap((messModels) async {
            return await Future.wait(messModels.map((messModel) async {
              UserApp user = UserApp();

              (await _authFirebaseService.getUser(messModel.userId!))
                  .fold((e) {}, (userModel) {
                user = userModel.toEntity();
              });

              return messModel.toEntity(user);
            }).toList());
          }),
        );
      },
    );
  }

  @override
  Future<Either<String, bool>> sendMessage(
      Message message, String groupId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return _chatFirebaseService.sendMessage(
        MessageModel.fromEntity(message, userId), groupId);
  }
}
