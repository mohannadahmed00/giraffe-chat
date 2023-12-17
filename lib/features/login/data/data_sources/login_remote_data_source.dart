import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/home/domian/entities/user_entity.dart';
import 'package:giraffe_chat/features/login/data/data_sources/login_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/server_failures.dart';

@LazySingleton(as: LoginDataSource)
class LoginRemoteDataSource implements LoginDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failures, UserCredential>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return Right(userCredential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(ServerFailures(e.message ?? "something went wring"));
      } else {
        return Left(ServerFailures("please check network connection"));
      }
    }
  }

  @override
  Future<Either<Failures, String>> createUserWithGoogle() async {
    try {
      var firebaseUser = auth.currentUser;
      var currentDateTime = Timestamp.now();
      var user = UserEntity(
              id: firebaseUser?.uid,
              imgUrl: firebaseUser?.photoURL,
              name: firebaseUser?.displayName,
              email: firebaseUser?.email,
              createdAt: currentDateTime,
              lastActive: currentDateTime,
              pushToken: '',
              isOnline: true)
          .toJson();
      await firestore.collection("users").doc(firebaseUser?.uid).set(user);
      return Right(firebaseUser?.uid ?? "");
    } catch (e) {
      if (e is FirebaseException) {
        return Left(ServerFailures(e.message ?? "something went wrong"));
      } else {
        return Left(ServerFailures("check your network connection"));
      }
    }
  }

  @override
  Future<Either<Failures, bool>> isUserExist() async {
    try {
      var result =
          await firestore.collection("users").doc(auth.currentUser?.uid).get();
      if (result.exists) {
        await firestore
            .collection("users")
            .doc(auth.currentUser?.uid ?? "")
            .update({"isOnline": true});
      }
      return Right(result.exists);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(ServerFailures(e.message ?? "something went wrong"));
      } else {
        return Left(ServerFailures("check your network connection"));
      }
    }
  }
}
