import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/profile/data/data_sources/profile_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/server_failures.dart';

@LazySingleton(as: ProfileDataSource)
class RemoteProfileDataSource extends ProfileDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Either<Failures, bool>> logout() async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser?.uid ?? "")
          .update({"isOnline": false});
      await auth.signOut();
      await GoogleSignIn().signOut();
      return Right(true);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(ServerFailures(e.message ?? "something went wrong"));
      } else {
        return Left(ServerFailures("check your network connection"));
      }
    }
  }

  @override
  Future<Either<Failures, void>> editUserData(String name, String about) async {
    try {
      var result = await firestore
          .collection("users")
          .doc(auth.currentUser?.uid ?? "")
          .update({
        "name": name,
        "about": about,
      });
      return Right(result);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(ServerFailures(e.message ?? "something went wrong"));
      } else {
        return Left(ServerFailures("check your network connection"));
      }
    }
  }
}
