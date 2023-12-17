import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_route.dart';

class MyApp extends StatelessWidget {
  final String route;
  const MyApp({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 937),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: route,
          onGenerateRoute: (settings) => AppRoutes.onGenerate(settings),
        );
      },
    );
  }
}
