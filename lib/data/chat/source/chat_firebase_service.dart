import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:home_shield/data/chat/models/group_model.dart';
import 'package:home_shield/data/chat/models/message_model.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/entities/message.dart';

abstract class ChatFirebaseService {
  Future<Either<String, List<GroupModel>>> getContacts(String userId);

  Future<Either<String, Stream<List<MessageModel>>>> getMessages(
      String groupId);

  Future<Either<String, bool>> sendMessage(
      MessageModel message, String groupId);
}

class ChatFirebaseServiceImpl extends ChatFirebaseService {
  late final CollectionReference<Map<String, dynamic>> _groupCollection;
  late final CollectionReference<Map<String, dynamic>> _userCollection;

  ChatFirebaseServiceImpl() {
    _groupCollection = FirebaseFirestore.instance.collection('groups');
    _userCollection = FirebaseFirestore.instance.collection('users');
  }

  @override
  Future<Either<String, List<GroupModel>>> getContacts(String userId) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      List<String> groupIds = List.from(user.get('group_ids'));

      List<GroupModel> groupModels =
          await Future.wait(groupIds.map((groupId) async {
        var group = await _groupCollection.doc(groupId).get();
        // if (group.exists && group.data() != null)
        var data = group.data()!;
        data['id'] = groupId;
        return GroupModel.fromJson(data);
      }));

      return Right(groupModels);
    } catch (e) {
      return const Left("Error when fetch group!");
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Stream<List<MessageModel>>>> getMessages(
      String groupId) async {
    try {
      var messagesCollection =
          _groupCollection.doc(groupId).collection('messages').orderBy('created_at', descending: true);

      Stream<List<MessageModel>> messageStream =
          messagesCollection.snapshots().map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList();
      });

      return Right(messageStream);
    } catch (e) {
      print(e.toString());
      return Left("Error fetching message");
    }
  }

  @override
  Future<Either<String, bool>> sendMessage(
      MessageModel message, String groupId) async {
    try {
      await _groupCollection.doc(groupId).collection('messages').add(message.toJson());

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
