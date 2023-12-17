import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giraffe_chat/features/profile/presentation/manager/profile_cubit.dart';
import 'package:giraffe_chat/features/profile/presentation/manager/profile_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (_, state) {
      if (state is ProfileLogoutSuccessState) {
        CacheHelper.saveData(key: "userId", value: "");
        CacheHelper.saveData(key: "email", value: "");
        CacheHelper.saveData(key: "displayName", value: "");
        CacheHelper.saveData(key: "photoURL", value: "");
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false);
      } else if (state is ProfileLogoutFailState) {
        showSnackBar(
            context: context,
            msg: state.failures.message,
            background: Colors.redAccent);
      }
    }, builder: (_, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text("${CacheHelper.getData("displayName")}'s Profile"),
        ),
        body: Form(
          key: ProfileCubit
              .get(context)
              .formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                          image: NetworkImage(CacheHelper.getData("photoURL")),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    CacheHelper.getData("email"),
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextFormField(
                    controller: ProfileCubit
                        .get(context)
                        .nameController,
                    //onSaved: (val)=>CacheHelper.saveData(key: "displayName", value: val),
                    validator: (val) =>
                    val != null && val.isNotEmpty
                        ? null
                        : "Required Field",
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.w)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20.w)),
                      hintText: "eg. Mohannad Ahmed",
                      label: Text("Name"),
                      floatingLabelStyle: TextStyle(
                          color: Colors.grey),
                      prefixIconColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextFormField(
                    controller: ProfileCubit.get(context).aboutController,
                    //onSaved: (val)=>CacheHelper.saveData(key: "displayName", value: val),
                    validator: (val) =>
                    val != null && val.isNotEmpty
                        ? null
                        : "Required Field",
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.w)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20.w)),
                      hintText: "eg. Feeling Happy",
                      label: Text("About"),
                      floatingLabelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIconColor:Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: StadiumBorder(),
                          backgroundColor: Colors.green),
                      onPressed: () {
                        if (ProfileCubit
                            .get(context)
                            .formKey
                            .currentState!
                            .validate()) {
                          print("valid data");
                          ProfileCubit.get(context).editUserData();
                        } else {
                          print("invalid data");
                        }
                      },
                      child: Text(
                        "Edit",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ProfileCubit.get(context).logout();
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.logout),
        ),
      );
    });
  }
}
