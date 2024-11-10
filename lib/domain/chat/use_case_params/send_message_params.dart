import 'package:home_shield/domain/chat/entities/message.dart';

class SendMessageParams {
  final Message message;
  final String groupId;

  SendMessageParams({required this.message, required this.groupId});
}
