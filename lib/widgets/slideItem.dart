import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 280,
          height: 280,
          child: Image.asset(slideList[index].imageUrl, height: 280),
        ),
        SizedBox(
          height: 60.h,
        ),
        new Text(
          slideList[index].title,
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
          style: TextStyle(color: CustomColors.grey, fontSize: 22.sp),
        ),
      ],
    );
  }
}
