import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/auth/models/user_model.dart';
import 'package:home_shield/domain/auth/entites/user.dart';

abstract class AuthFirebaseService {
  Future<Either<String, UserApp>> signup(UserModel user);

  Future<Either> signIn(UserModel user);

  Future<bool> isLoggedIn();

  Future<Either> getCurrentUser();

  Future<Either<String, UserModel>> getUser(String userId);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  var userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<Either<String, UserApp>> signup(UserModel user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      user.id = returnedData.user!.uid;

      userCollection.doc(returnedData.user!.uid).set(user.toMap());

      return Right(user.toEntity());
    } on FirebaseAuthException catch (e) {
      String mess = '';

      if (e.code == 'weak-password') {
        mess = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        mess = "An account already exists with that email.";
      }
      return Left(mess);
    }
  }

  @override
  Future<Either> signIn(UserModel user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      return const Right('Sign in was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Not user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for this user';
      }

      return Left(message);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> getCurrentUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      print("Current user: $currentUser");
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());
      return Right(userData);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either<String, UserModel>> getUser(String userId) async {
    try {
      var data = await userCollection.doc(userId).get();
      if (data.exists && data.data() != null) {
        return Right(UserModel.fromMap(data.data()!));
      } else {
        return const Left("User not found!");
      }
    } catch (e) {
      return const Left("Error fetching user!");
    }
  }
}
