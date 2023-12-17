import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/core/error/server_failures.dart';
import 'package:injectable/injectable.dart';

import 'home_data_source.dart';

@LazySingleton(as: HomeDataSource)
class RemoteHomeDataSource extends HomeDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Either<Failures, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getUsers() async {
    try {
      var result = await firestore.collection("users")
          .where("id",isNotEqualTo: auth.currentUser?.uid)
          .snapshots();
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
