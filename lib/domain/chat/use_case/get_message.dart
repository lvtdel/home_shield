import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class GetMessageUseCase
    extends UseCase<Either<String, Stream<List<Message>>>, String> {
  @override
  Future<Either<String, Stream<List<Message>>>> call({String? params}) {
    return sl<ChatRepository>().getMessages(params!);
  }
}
