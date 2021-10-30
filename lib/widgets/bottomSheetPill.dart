import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';

class PillContainer extends StatelessWidget {
  const PillContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: 80.w,
      decoration: BoxDecoration(
          color: CustomColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
