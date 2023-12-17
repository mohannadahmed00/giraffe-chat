import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'config/injection/di.dart';
import 'config/routes/routes.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/observer.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  String route = await configureRoute();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp(
    route: route,
  )));
}

Future<String> configureRoute() async {
  return Routes.splash;
}
