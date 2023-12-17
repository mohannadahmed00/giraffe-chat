import '../../../../core/error/failures.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLogoutSuccessState extends ProfileState {
  bool successFlag;

  ProfileLogoutSuccessState(this.successFlag);
}

class ProfileLogoutFailState extends ProfileState {
  Failures failures;

  ProfileLogoutFailState(this.failures);
}

class ProfileLogoutLoadingState extends ProfileState {}

class ProfileEditUserDataSuccessState extends ProfileState {}

class ProfileEditUserDataFailState extends ProfileState {
  Failures failures;

  ProfileEditUserDataFailState(this.failures);
}

class ProfileEditUserDataLoadingState extends ProfileState {}
