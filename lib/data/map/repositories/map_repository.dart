import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/map/models/location_info_model.dart';

abstract class MapRepository {
  Future<Either<String, List<LocationInfoModel>>> getFriendLocations();
}

class MapRepositoryImpl extends MapRepository {
  final userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<Either<String, List<LocationInfoModel>>> getFriendLocations() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      // var userId = "qdsH5jU73JOrIMkwOB8BXKZ2QRy1";
      var friendIds = await friendList(userId);
      List<LocationInfoModel> locationInfos = await Future.wait( friendIds.map((userId) async {
        var data = await userCollection.doc(userId).get();

        LocationInfoModel location = LocationInfoModel.fromJson(data.data()!);
        return location;
      }));

      locationInfos.removeWhere((e)=>e.location==null || e.userId == userId);
      return Right(locationInfos);
    }
    catch(e) {
      return Left(e.toString());
    }


  }

  Future<List<String>> friendList(String userId) async {
    var user =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    // List<String> groupIds = (user.get("group_ids") as List<dynamic>?)
    //         ?.map((e) => e.toString())
    //         .toList() ??
    //     List.empty();
    List<String> groupIds = List.from(user.get('group_ids'));

    if (groupIds.isEmpty) {
      print("FirebaseService return empty groupIds");
      return [];
    }
    Set<String> friendIds = {};

    for (String groupId in groupIds) {
      var groupSnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .get();

      if (groupSnapshot.exists) {
        List<String> userIds = List<String>.from(groupSnapshot.get("user_ids"));
        friendIds.addAll(userIds);
      }
    }
    return friendIds.toList();
  }
}
