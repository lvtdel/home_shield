import 'package:home_shield/domain/chat/entities/message.dart';

class Group {
  final String? id;
  final String image;
  final String name;
  String? lastMess;
  final List<String> userIds;

  // final List<Message> messages;

  Group(
      {this.id,
        this.lastMess,
      required this.image,
      required this.name,
      required this.userIds});
}
