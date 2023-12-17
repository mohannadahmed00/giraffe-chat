import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giraffe_chat/features/home/domian/entities/user_entity.dart';
import 'package:intl/intl.dart';
import 'text_styles.dart';

class DefaultButton extends StatelessWidget {
  final double? width;
  final double height;
  final Color background;
  final TextStyle textStyle;
  final bool isUpperCase;
  final double radius;
  final Function function;
  final String text;
  final IconData? icon;
  final Color? iconColor;

  const DefaultButton(
      {super.key,
      this.width,
      this.height = 40,
      required this.background,
      this.textStyle = const TextStyle(
        color: Colors.white,
      ),
      this.isUpperCase = true,
      this.radius = 32,
      required this.function,
      required this.text,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: width ?? constraints.maxWidth,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            color: background,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: MaterialButton(
            onPressed: function as void Function()?,
            child: icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(isUpperCase ? text.toUpperCase() : text,
                          style: textStyle),
                    ],
                  )
                : Text(isUpperCase ? text.toUpperCase() : text,
                    style: textStyle),
          ),
        );
      },
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final Function function;
  final String text;
  final TextStyle textStyle;

  const DefaultTextButton({
    super.key,
    required this.function,
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function as void Function()?,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String label;
  final IconData? suffix;
  final Color? suffixColor;
  final void Function()? suffixPressed;
  final bool isClickable;
  final Color? fillColor;
  final double borderRadius;
  final Color hintColor;
  final double contentPaddingH;
  final double contentPaddingV;
  final TextInputAction textInputAction;

  const DefaultFormField({
    super.key,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.isPassword = false,
    required this.validate,
    required this.label,
    this.suffix,
    this.suffixColor,
    this.suffixPressed,
    this.isClickable = true,
    this.fillColor,
    this.borderRadius = 32,
    this.hintColor = Colors.white,
    this.contentPaddingH = 24,
    this.contentPaddingV = 24,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textInputAction: textInputAction,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingH, vertical: contentPaddingV),
        hintText: label,
        hintStyle: openSans12W400(color: hintColor),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: suffixColor ?? Colors.white,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r)),
        fillColor: fillColor,
        filled: fillColor != null,
      ),
    );
  }
}

class DefaultDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? initialValue;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;
  final bool enabled;

  const DefaultDropdown({
    Key? key,
    required this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
      ),
      hint: Text(
        hintText,
        style: openSans14W400(color: Colors.black),
      ),
      items: items,
      validator: validator,
      onChanged: enabled ? onChanged : null,
      onSaved: onSaved,
      value: initialValue,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

void showSnackBar(
    {required BuildContext context,
    required String msg,
    Color background = Colors.grey}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: background,
    behavior: SnackBarBehavior.floating,
  ));
}

class UserCard extends StatelessWidget {
  final UserEntity userEntity;

  UserCard(this.userEntity);

  @override
  Widget build(BuildContext context) {
    print("imgUrl => ${userEntity.imgUrl}");
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
      child: ListTile(
        title: Text(userEntity.name??""),
        subtitle: Text(userEntity.email??""),
        trailing: Text(formatFirestoreTimestamp(userEntity.lastActive),textAlign: TextAlign.right,),
        leading: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  userEntity.imgUrl??""
                )),
            Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: (userEntity.isOnline??false)?Colors.greenAccent:Colors.redAccent,
                borderRadius: BorderRadius.circular(50.r)
              ),
            )
          ],
        )
      ),
    );
  }

  String formatFirestoreTimestamp(Timestamp? timestamp) {
    return timestamp!=null?DateFormat("HH:mm").format(timestamp.toDate())+"\n"+DateFormat("dd/MM/yyyy").format(timestamp.toDate())
        :"";
  }
}

