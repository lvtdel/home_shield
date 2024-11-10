import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/domain/chat/use_case_params/send_message_params.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class SendMessageUseCase
    extends UseCase<Either<String, bool>, SendMessageParams> {
  @override
  Future<Either<String, bool>> call({SendMessageParams? params}) {
    Message message = params!.message;
    String groupId = params.groupId;
    return sl<ChatRepository>().sendMessage(message, groupId);
  }
}
