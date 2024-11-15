import 'package:home_shield/data/chat/models/message_model.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:collection/collection.dart';
import 'package:home_shield/domain/chat/entities/message.dart';

class GroupModel {
  final String? id;
  String image;
  final String name;
   List<String> userIds;

  // final List<MessageModel> messages;

  GroupModel({
    this.id,
    required this.image,
    required this.name,
    required this.userIds,
    // required this.messages
  });

  // factory ContactModel.fromEntity(Contact contact) {
  //   return ContactModel(
  //       image: contact.image,
  //       userIds: contact.userIds,
  //       messages:
  //           List.from(contact.messages.map((e) => MessageModel.fromEntity(e))));
  // }

  Group toEntity() {
    return Group(
      id: id,
      image: image,
      name: name,
      userIds: userIds,
      // messages: IterableZip([messages, userApps]).map<Message>((e) {
      //   return (e.first as MessageModel).toEntity(e.last as UserApp);
      // }).toList()
    );
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      userIds:
          (json['user_ids'] as List<dynamic>).map((e) => e.toString()).toList(),
      // messages: json['messages'] == null
      //     ? List<MessageModel>.from([])
      //     : List<MessageModel>.from(
      //         json['messages'].map((x) => MessageModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'user_ids': userIds,
        // 'messages': messages.map((e) => e.toJson()).toList(),
      };
}
