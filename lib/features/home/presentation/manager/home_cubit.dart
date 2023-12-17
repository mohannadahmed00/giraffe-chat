import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/features/home/domian/use_cases/get_users_use_case.dart';
import 'package:giraffe_chat/features/home/presentation/manager/home_state.dart';

import '../../domian/entities/user_entity.dart';

class HomeCubit extends Cubit<HomeState> {
  GetUsersUseCase getUsersUseCase;

  HomeCubit(this.getUsersUseCase) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshot = null;

  void getUsers() async {
    emit(HomeGetUsersLoadingState());
    var result = await getUsersUseCase.call();
    result.fold((l) {
      emit(HomeGetUsersFailState(l));
    }, (r) {
      snapshot = r;
      emit(HomeGetUsersSuccessState(r));
    });
  }

  List<UserEntity> users = [];

  void handleUsersStream(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs) {
    users = docs?.map((e) => UserEntity.fromJson(e.data())).toList() ?? [];
  }

  bool searchFlag = false;

  void changeSearchState(bool searchFlag) {
    this.searchFlag = searchFlag;
    emit(HomeSearchState(searchFlag));
  }

  TextEditingController searchController = TextEditingController();
  List<UserEntity> filteredUsers = [];

  void searchForUser() {
    String target = searchController.text.trim().toString();
    filteredUsers.clear();
    filteredUsers.addAll(users.where((user) =>
        (user.name?.contains(target) ?? false) ||
        (user.email?.contains(target) ?? false)));
    emit(HomeSearchResultState(filteredUsers));
  }
}
