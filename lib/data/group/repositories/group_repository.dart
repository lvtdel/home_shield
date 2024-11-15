import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_shield/data/chat/models/group_model.dart';
import 'package:path/path.dart' as pathLib;

abstract class GroupRepository {
  Future<Either<String, String>> createGroup(File image, GroupModel groupModel);
}

class GroupRepositoryImpl extends GroupRepository {
  final _groupCollection = FirebaseFirestore.instance.collection('groups');
  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<Either<String, String>> createGroup(
      File image, GroupModel groupModel) async {
    try {
      var userIds = await Future.wait(groupModel.userIds.map((email) async {
        String userId = "";
        (await getUserIdByEmail(email)).fold((e) {
          throw Exception("Could not find $email");
        }, (u) {
          userId = u;
        });

        return userId;
      }));

      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      userIds.add(currentUserId);
      groupModel.userIds = userIds;
      groupModel.image = await uploadFile("images/group/", image);

      DocumentReference docRef =
          await _groupCollection.add(groupModel.toJson());

      String documentId = docRef.id;

      _groupCollection.doc(documentId).collection("messages").add({
        "content": "Welcome to ${groupModel.name}",
        "created_at": Timestamp.now(),
        "id": null,
        "user_id": currentUserId
      });

      for (var userId in userIds) {
        _userCollection.doc(userId).update({'group_ids': FieldValue.arrayUnion([documentId])});
      }

      return Right(groupModel.name);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> getUserIdByEmail(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return Right(snapshot.docs.first['id'] as String);
    } else {
      return Left(email);
    }
  }

  Future<String> uploadFile(String path, File file) async {
    String fileExtension = pathLib.extension(file.path);
    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;
    Reference storageRef =
        FirebaseStorage.instance.ref().child("$path$fileName");
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }


}
