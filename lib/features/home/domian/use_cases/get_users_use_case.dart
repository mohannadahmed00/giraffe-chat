import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:giraffe_chat/core/error/failures.dart';
import 'package:giraffe_chat/features/home/domian/repositories/home_domain_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUsersUseCase{
  HomeDomainRepo homeDomainRepo;

  GetUsersUseCase(this.homeDomainRepo);
  
  Future<Either<Failures,Stream<QuerySnapshot<Map<String, dynamic>>>>> call() => homeDomainRepo.getUsers();
}