import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/config/injection/di.dart';
import 'package:giraffe_chat/features/home/domian/entities/user_entity.dart';
import 'package:giraffe_chat/features/login/domian/use_cases/create_user_use_case.dart';
import 'package:giraffe_chat/features/login/domian/use_cases/login_with_google_use_case.dart';
import 'package:giraffe_chat/features/login/domian/use_cases/user_exist_use_case.dart';
import 'package:giraffe_chat/features/login/presentation/manager/login_cubit.dart';
import 'package:giraffe_chat/features/login/presentation/page/login_screen.dart';
import 'package:giraffe_chat/features/profile/domian/use_cases/edit_user_data_use_case.dart';
import 'package:giraffe_chat/features/profile/presentation/manager/profile_cubit.dart';
import 'package:giraffe_chat/features/profile/presentation/page/profile_screen.dart';
import 'package:giraffe_chat/features/splash/presentation/manager/splash_cubit.dart';
import 'package:giraffe_chat/features/splash/presentation/page/splash_screen.dart';
import '../../features/home/domian/use_cases/get_users_use_case.dart';
import '../../features/profile/domian/use_cases/logout_use_case.dart';
import '../../features/home/presentation/manager/home_cubit.dart';
import '../../features/home/presentation/page/home_screen.dart';
import 'routes.dart';

class AppRoutes {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        //var user = routeSettings.arguments as UserEntity?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit(getIt<GetUsersUseCase>())
              ..getUsers(),
            child: HomeScreen(),
          ),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(getIt<LoginWithGoogleUseCase>(),
                getIt<CreateUserWithGoogleUseCase>(), getIt<UserExistUseCase>()),
            child: const LoginScreen(),
          ),
        );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashCubit(),
            child: const SplashScreen(),
          ),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProfileCubit(getIt<LogoutUseCase>(),getIt<EditUserDataUseCase>()),
            child: ProfileScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
