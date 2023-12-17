import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/features/profile/domian/repositories/profile_domain_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';

@lazySingleton
class EditUserDataUseCase {
  ProfileDomainRepo profileDomainRepo;

  EditUserDataUseCase(this.profileDomainRepo);

  Future<Either<Failures, void>> call(String name, String about) =>
      profileDomainRepo.editUserData(name, about);
}
