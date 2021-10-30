import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonStyle {
  static ButtonStyle buildButtonStyle() => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0),
                side: BorderSide(color: Colors.red))),
      );

  static ButtonStyle buildOutlinedButtonStyle() => OutlinedButton.styleFrom(
        // backgroundColor: CustomColors.red,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: CustomColors.red),
        textStyle: const TextStyle(fontSize: 14, color: Colors.black),
      );
}
