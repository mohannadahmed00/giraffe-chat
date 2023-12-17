import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';

import 'package:giraffe_chat/core/error/failures.dart';

import 'home_data_source.dart';

class LocalHomeDataSource extends HomeDataSource{
  @override
  Future<Either<Failures, Stream<QuerySnapshot<Map<String, dynamic>>>>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

}