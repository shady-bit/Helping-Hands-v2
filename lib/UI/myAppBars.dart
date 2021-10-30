import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:helpinghandsversion2/constants/customColor.dart';

class MyAppBar {
  //HomeSCreen AppBar
  static AppBar homeScreenAppBar() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.add_circle_outline,
          color: CustomColors.darkGery,
        ),
        title: Text(
          "Helping Hands",
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.question_answer_outlined,
                color: CustomColors.red,
                size: 30,
              ),
              onPressed: () {}),
        ],
      );

  static AppBar postRequirementAppBar(
          {required String requirementText, List<Widget>? actions}) =>
      AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        actions: actions,
        title: Text(
          "Create $requirementText Request",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 21.sp),
        ),
      );

  static AppBar myRequestAppBar() => AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          "My Request",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 21.sp),
        ),
      );
}
