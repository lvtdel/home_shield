import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/notification/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<String, bool>> pushNotif(
      NotificationModel notif, String receiverId);

  Future<Either<String, bool>> deleteNotif(String notifId);

  Future<Either<String, bool>> acceptNotif(NotificationModel notif);

  Future<Either<String, Stream<List<NotificationModel>>>> getNotif();
}

class NotificationRepositoryImpl extends NotificationRepository {
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _groupCollection = FirebaseFirestore.instance.collection("groups");

  @override
  Future<Either<String, Stream<List<NotificationModel>>>> getNotif() async {
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid ??
          "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";

      var notifCollection = _userCollection
          .doc(userId)
          .collection('notifications')
          .orderBy('created_at', descending: true);

      Stream<List<NotificationModel>> messageStream =
          notifCollection.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          NotificationModel notif = NotificationModel.fromJson(doc.data());
          notif.id = doc.id;
          return notif;
        }).toList();
      });

      return Right(messageStream);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> pushNotif(
      NotificationModel notif, String receiverId) async {
    try {
      var notifCollection =
          _userCollection.doc(receiverId).collection('notifications');

       await notifCollection.add(notif.toJson());

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> deleteNotif(String notifId) async {
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid ??
          "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";

      var notifDocument =
          _userCollection.doc(userId).collection('notifications').doc(notifId);

      await notifDocument.delete();

      return Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> acceptNotif(NotificationModel notif) async {
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid ??
          "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";

      if (notif.type == "GROUP_INVITE") {
        _userCollection.doc(userId).update({
          'group_ids': FieldValue.arrayUnion([notif.params])
        });

        _groupCollection.doc(notif.params).update({
          'user_ids': FieldValue.arrayUnion([userId])
        });
      }

      deleteNotif(notif.id!);

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
