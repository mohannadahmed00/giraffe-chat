import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class HomeDataSource{
  Future<Either<Failures,Stream<QuerySnapshot<Map<String, dynamic>>>>> getUsers();
}