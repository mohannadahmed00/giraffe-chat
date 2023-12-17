import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giraffe_chat/core/utils/app_images.dart';
import 'package:giraffe_chat/core/utils/components.dart';
import 'package:giraffe_chat/features/login/presentation/manager/login_cubit.dart';
import 'package:giraffe_chat/features/login/presentation/manager/login_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (_, state) {
      if (state is LoginWithGoogleFailState) {
        showSnackBar(
            context: context,
            msg: state.failures.message,
            background: Colors.redAccent);
      } else if (state is LoginWithGoogleSuccessState) {
        CacheHelper.saveData(key: "userId", value: state.userCredential.user?.uid);
        CacheHelper.saveData(key: "email", value: state.userCredential.user?.email);
        CacheHelper.saveData(key: "displayName", value: state.userCredential.user?.displayName);
        CacheHelper.saveData(key: "photoURL", value: state.userCredential.user?.photoURL);
        LoginCubit.get(context).isUserExist();
      } else if (state is UserExistFailState) {
        showSnackBar(
            context: context,
            msg: state.failures.message,
            background: Colors.redAccent);
      } else if (state is UserExistSuccessState) {
        if (state.isExist) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (route) => false);
          showSnackBar(
              context: context,
              msg: "user logged in with google successfully",
              background: Colors.green);
        } else {
          LoginCubit.get(context).createUserWithGoogle();
        }
      } else if (state is CreateUserWithGoogleFailState) {
        showSnackBar(
            context: context,
            msg: state.failures.message,
            background: Colors.redAccent);
      } else if (state is CreateUserWithGoogleSuccessState) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
        showSnackBar(
            context: context,
            msg: "user is created with google successfully",
            background: Colors.green);
      }
    }, builder: (_, state) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.w)),
                      label: Text("Email")),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.w)),
                      label: Text("Password")),
                ),
                SizedBox(
                  height: 32.h,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), backgroundColor: Colors.green),
                  onPressed: () {},
                  icon: Icon(Icons.email),
                  label: Text("Sign in with Email",),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    LoginCubit.get(context).signInWithGoogle();
                  },
                  icon: Image.asset(
                    AppImages.google,
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: Text("Sign in with Google",style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
