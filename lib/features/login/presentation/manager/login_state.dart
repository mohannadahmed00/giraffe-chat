import 'package:firebase_auth/firebase_auth.dart';
import 'package:giraffe_chat/core/error/failures.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginWithGoogleSuccessState extends LoginState {
  UserCredential userCredential;

  LoginWithGoogleSuccessState(this.userCredential);
}

class LoginWithGoogleFailState extends LoginState {
  Failures failures;

  LoginWithGoogleFailState(this.failures);
}

class LoginWithGoogleLoadingState extends LoginState {}
class ChangingPasswordFlagState extends LoginState {
  bool passwordFlag;

  ChangingPasswordFlagState(this.passwordFlag);
}

class CreateUserWithGoogleSuccessState extends LoginState {
  String userId;

  CreateUserWithGoogleSuccessState(this.userId);
}

class CreateUserWithGoogleFailState extends LoginState {
  Failures failures;

  CreateUserWithGoogleFailState(this.failures);
}

class CreateUserWithGoogleLoadingState extends LoginState {}

class UserExistSuccessState extends LoginState {
  bool isExist;

  UserExistSuccessState(this.isExist);
}

class UserExistFailState extends LoginState {
  Failures failures;

  UserExistFailState(this.failures);
}

class UserExistLoadingState extends LoginState {}
