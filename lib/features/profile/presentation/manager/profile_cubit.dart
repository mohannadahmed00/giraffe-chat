import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/features/profile/domian/use_cases/edit_user_data_use_case.dart';
import 'package:giraffe_chat/features/profile/presentation/manager/profile_state.dart';
import '../../domian/use_cases/logout_use_case.dart';

class ProfileCubit extends Cubit<ProfileState> {
  LogoutUseCase logoutUseCase;
  EditUserDataUseCase editUserDataUseCase;

  ProfileCubit(this.logoutUseCase, this.editUserDataUseCase)
      : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void logout() async {
    emit(ProfileLogoutLoadingState());
    var result = await logoutUseCase.call();
    result.fold((l) {
      emit(ProfileLogoutFailState(l));
    }, (r) {
      emit(ProfileLogoutSuccessState(r));
    });
  }

  void editUserData() async {
    emit(ProfileEditUserDataLoadingState());
    String name = nameController.text.toString();
    String about = aboutController.text.toString();
    var result = await editUserDataUseCase.call(name, about);
    result.fold((l) {
      emit(ProfileEditUserDataFailState(l));
    }, (r) {
      nameController.text = "";
      aboutController.text = "";
      emit(ProfileEditUserDataSuccessState());
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
}
