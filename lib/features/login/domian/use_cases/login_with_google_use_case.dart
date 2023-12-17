import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/login/domian/repositories/login_domain_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginWithGoogleUseCase {
  LoginDomainRepo loginDomainRepo;

  LoginWithGoogleUseCase(this.loginDomainRepo);

  Future<Either<Failures, UserCredential>> call() => loginDomainRepo.loginWithGoogle();
}
