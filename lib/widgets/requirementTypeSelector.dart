import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequirementTypeSelector extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onPress;
  const RequirementTypeSelector({
    required this.image,
    required this.title,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: CustomColors.textInputColor)),
            child: Image.asset(
              image,
              // fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}
