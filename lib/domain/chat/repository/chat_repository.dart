import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/entities/message.dart';

abstract class ChatRepository {
  Future<Either<String, List<Group>>> getContacts();

  Future<Either<String, Stream<List<Message>>>> getMessages(String groupId);

  Future<Either<String, bool>> sendMessage(Message message, String groupId);
}
