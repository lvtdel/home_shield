import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';

abstract class EmergencyRepository {
  Future<Either<String, bool>> sendLocation(SendLocationParams location);
}

class EmergencyRepositoryImpl extends EmergencyRepository {
  final _userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<Either<String, bool>> sendLocation(SendLocationParams location) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _userCollection.doc(userId).set(
        {
          'location': GeoPoint(location.lat, location.lng),
        },
        SetOptions(merge: true), // merge: true để cập nhật hoặc tạo mới nếu tài liệu chưa có
      );
      print("User location updated successfully.");
      return Right(true);
    } catch (e) {
      print("Failed to update user location: $e");
      return Left(e.toString());
    }
  }

}