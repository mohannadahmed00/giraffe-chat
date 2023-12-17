import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/features/profile/domian/repositories/profile_domain_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';

@lazySingleton
class LogoutUseCase {
  ProfileDomainRepo profileDomainRepo;

  LogoutUseCase(this.profileDomainRepo);

  Future<Either<Failures, bool>> call() async =>
      profileDomainRepo.logout();
}
