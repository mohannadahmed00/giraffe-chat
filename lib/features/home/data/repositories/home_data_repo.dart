import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/home/data/data_sources/home_data_source.dart';
import 'package:giraffe_chat/features/home/domian/repositories/home_domain_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeDomainRepo)
class HomeDataRepo extends HomeDomainRepo {
  HomeDataSource remoteHomeDataSource;
  //HomeDataSource localHomeDataSource;

  HomeDataRepo(this.remoteHomeDataSource);

  @override
  Future<Either<Failures, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getUsers() => remoteHomeDataSource.getUsers();


}
