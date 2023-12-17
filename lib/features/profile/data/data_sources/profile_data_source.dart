import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileDataSource{
  Future<Either<Failures,bool>> logout();
  Future<Either<Failures,void>> editUserData(String name,String about);
}