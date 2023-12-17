import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/login/domian/repositories/login_domain_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserExistUseCase{
  LoginDomainRepo loginDomainRepo;

  UserExistUseCase(this.loginDomainRepo);

  Future<Either<Failures,bool>> call() => loginDomainRepo.isUserExist();
}