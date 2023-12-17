import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../home/domian/entities/user_entity.dart';

abstract class LoginDomainRepo {
  Future<Either<Failures, UserCredential>> loginWithGoogle();
  Future<Either<Failures,String>> createUserWithGoogle();
  Future<Either<Failures,bool>> isUserExist();
}
