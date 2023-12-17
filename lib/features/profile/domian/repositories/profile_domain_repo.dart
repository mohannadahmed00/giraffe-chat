import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileDomainRepo{
  Future<Either<Failures,bool>> logout();
  Future<Either<Failures,void>> editUserData(String name,String about);
}