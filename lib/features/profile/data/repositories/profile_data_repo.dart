import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/home/data/data_sources/home_data_source.dart';
import 'package:giraffe_chat/features/home/domian/repositories/home_domain_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domian/repositories/profile_domain_repo.dart';
import '../data_sources/profile_data_source.dart';

@LazySingleton(as: ProfileDomainRepo)
class ProfileDataRepo extends ProfileDomainRepo {
  ProfileDataSource profileDataSource;

  ProfileDataRepo(this.profileDataSource);

  @override
  Future<Either<Failures, bool>> logout() => profileDataSource.logout();

  @override
  Future<Either<Failures, void>> editUserData(String name, String about)=>profileDataSource.editUserData(name, about);
}
