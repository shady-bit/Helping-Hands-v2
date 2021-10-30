import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputDecoration {
  static InputDecoration buildInputDecoration(
      {String? labelText, String? errorText}) {
    return InputDecoration(
        border: OutlineInputBorder(),
        counterText: "",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.lightGrey)),
        contentPadding: EdgeInsets.symmetric(horizontal: 25.w),
        labelText: labelText,
        hintStyle: TextStyle(color: CustomColors.lightGrey),
        errorText: errorText,
        errorStyle: TextStyle(color: CustomColors.red, fontSize: 17.sp),
        labelStyle:
            TextStyle(fontSize: 18.sp, color: CustomColors.textInputColor));
  }
}
