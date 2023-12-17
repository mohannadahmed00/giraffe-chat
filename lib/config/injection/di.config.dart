// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/api/api_service.dart' as _i3;
import '../../features/home/data/data_sources/home_data_source.dart' as _i5;
import '../../features/home/data/data_sources/remote_home_data_source.dart'
    as _i6;
import '../../features/home/data/repositories/home_data_repo.dart' as _i8;
import '../../features/home/domian/repositories/home_domain_repo.dart' as _i7;
import '../../features/home/domian/use_cases/get_users_use_case.dart' as _i21;
import '../../features/login/data/data_sources/login_data_source.dart' as _i9;
import '../../features/login/data/data_sources/login_remote_data_source.dart'
    as _i10;
import '../../features/login/data/repositories/login_data_repo.dart' as _i12;
import '../../features/login/domian/repositories/login_domain_repo.dart'
    as _i11;
import '../../features/login/domian/use_cases/create_user_use_case.dart'
    as _i19;
import '../../features/login/domian/use_cases/login_with_google_use_case.dart'
    as _i13;
import '../../features/login/domian/use_cases/user_exist_use_case.dart' as _i18;
import '../../features/profile/data/data_sources/profile_data_source.dart'
    as _i14;
import '../../features/profile/data/data_sources/remote_profile_data_source.dart'
    as _i15;
import '../../features/profile/data/repositories/profile_data_repo.dart'
    as _i17;
import '../../features/profile/domian/repositories/profile_domain_repo.dart'
    as _i16;
import '../../features/profile/domian/use_cases/edit_user_data_use_case.dart'
    as _i20;
import '../../features/profile/domian/use_cases/logout_use_case.dart' as _i22;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService(gh<_i4.Dio>()));
    gh.lazySingleton<_i5.HomeDataSource>(() => _i6.RemoteHomeDataSource());
    gh.lazySingleton<_i7.HomeDomainRepo>(
        () => _i8.HomeDataRepo(gh<_i5.HomeDataSource>()));
    gh.lazySingleton<_i9.LoginDataSource>(() => _i10.LoginRemoteDataSource());
    gh.lazySingleton<_i11.LoginDomainRepo>(
        () => _i12.LoginDataRepo(gh<_i9.LoginDataSource>()));
    gh.lazySingleton<_i13.LoginWithGoogleUseCase>(
        () => _i13.LoginWithGoogleUseCase(gh<_i11.LoginDomainRepo>()));
    gh.lazySingleton<_i14.ProfileDataSource>(
        () => _i15.RemoteProfileDataSource());
    gh.lazySingleton<_i16.ProfileDomainRepo>(
        () => _i17.ProfileDataRepo(gh<_i14.ProfileDataSource>()));
    gh.lazySingleton<_i18.UserExistUseCase>(
        () => _i18.UserExistUseCase(gh<_i11.LoginDomainRepo>()));
    gh.lazySingleton<_i19.CreateUserWithGoogleUseCase>(
        () => _i19.CreateUserWithGoogleUseCase(gh<_i11.LoginDomainRepo>()));
    gh.lazySingleton<_i20.EditUserDataUseCase>(
        () => _i20.EditUserDataUseCase(gh<_i16.ProfileDomainRepo>()));
    gh.lazySingleton<_i21.GetUsersUseCase>(
        () => _i21.GetUsersUseCase(gh<_i7.HomeDomainRepo>()));
    gh.lazySingleton<_i22.LogoutUseCase>(
        () => _i22.LogoutUseCase(gh<_i16.ProfileDomainRepo>()));
    return this;
  }
}
