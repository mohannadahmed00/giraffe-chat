import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/features/login/domian/use_cases/create_user_use_case.dart';
import 'package:giraffe_chat/features/login/domian/use_cases/user_exist_use_case.dart';
import 'package:giraffe_chat/features/login/presentation/manager/login_state.dart';

import '../../domian/use_cases/login_with_google_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginWithGoogleUseCase loginWithGoogleUseCase;
  CreateUserWithGoogleUseCase createUserUseCase;
  UserExistUseCase userExistUseCase;

  LoginCubit(this.loginWithGoogleUseCase, this.createUserUseCase,
      this.userExistUseCase)
      : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void signInWithGoogle() async {
    emit(LoginWithGoogleLoadingState());
    var result = await loginWithGoogleUseCase.call();
    result.fold((l) {
      emit(LoginWithGoogleFailState(l));
    }, (r) {
      emit(LoginWithGoogleSuccessState(r));
    });
  }

  bool passwordFlag = true;

  void changePasswordFlag(bool passwordFlag) {
    this.passwordFlag = passwordFlag;
    emit(ChangingPasswordFlagState(passwordFlag));
  }

  void createUserWithGoogle() async {
    emit(CreateUserWithGoogleLoadingState());
    var result = await createUserUseCase.call();
    result.fold((l) {
      emit(CreateUserWithGoogleFailState(l));
    }, (r) {
      emit(CreateUserWithGoogleSuccessState(r));
    });
  }

  void isUserExist() async {
    emit(UserExistLoadingState());
    var result = await userExistUseCase.call();
    result.fold((l) {
      emit(UserExistFailState(l));
    }, (r) {
      emit(UserExistSuccessState(r));
    });
  }
}
