import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/features/splash/presentation/manager/splash_state.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);
}