import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/features/home/domian/entities/user_entity.dart';

import '../../../../core/error/failures.dart';

abstract class LoginDataSource{
  Future<Either<Failures, UserCredential>> loginWithGoogle();

  Future<Either<Failures, String>> createUserWithGoogle();

  Future<Either<Failures, bool>> isUserExist();
}