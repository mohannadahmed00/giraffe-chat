import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giraffe_chat/core/error/failures.dart';

import '../../domian/entities/user_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetUsersSuccessState extends HomeState {
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  HomeGetUsersSuccessState(this.snapshot);
}

class HomeGetUsersFailState extends HomeState {
  Failures failures;

  HomeGetUsersFailState(this.failures);
}

class HomeGetUsersLoadingState extends HomeState {}

class HomeSearchState extends HomeState {
  bool searchFlag;

  HomeSearchState(this.searchFlag);
}

class HomeSearchResultState extends HomeState {
  List<UserEntity> filteredUsers;

  HomeSearchResultState(this.filteredUsers);
}
