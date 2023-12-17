import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/home/domian/entities/user_entity.dart';
import 'package:giraffe_chat/features/login/data/data_sources/login_data_source.dart';
import 'package:giraffe_chat/features/login/domian/repositories/login_domain_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginDomainRepo)
class LoginDataRepo implements LoginDomainRepo {
  LoginDataSource loginDataSource;

  LoginDataRepo(this.loginDataSource);

  @override
  Future<Either<Failures, UserCredential>> loginWithGoogle() =>
      loginDataSource.loginWithGoogle();

  @override
  Future<Either<Failures, String>> createUserWithGoogle() => loginDataSource.createUserWithGoogle();

  @override
  Future<Either<Failures, bool>> isUserExist() => loginDataSource.isUserExist();
}
