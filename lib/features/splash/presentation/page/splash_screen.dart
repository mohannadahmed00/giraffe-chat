import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giraffe_chat/core/utils/app_colors.dart';
import 'package:giraffe_chat/core/utils/app_images.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/cache_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initState(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            width: 500.w,
            height: 500.h,
          ),
          CircularProgressIndicator(
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }

  void initState(BuildContext context) {
    Future.delayed(Duration(milliseconds: 5000), () {
      String? userId = CacheHelper.getData("userId");
      if (userId != null && userId.isNotEmpty) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false);
      }
    });
  }
}
