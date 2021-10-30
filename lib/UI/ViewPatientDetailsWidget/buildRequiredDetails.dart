import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lableContainer.dart';

class buildRequiredDetails extends StatelessWidget {
  final String requiredDateTime;
  final String bloodGrpRequired;
  final String requiredUnits;
  final String requirementType;
  const buildRequiredDetails(
      {Key? key,
      required this.requiredDateTime,
      required this.bloodGrpRequired,
      required this.requiredUnits,
      required this.requirementType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Requirement Details",
            style: TextStyle(
                color: CustomColors.red,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer(
                label: "Requirement",
                fillText: requirementType,
              ),
              lableContainer(
                  label: "Reqt. Date & Time", fillText: requiredDateTime),
              lableContainer(
                  label: "Reqt. Blood Group", fillText: bloodGrpRequired),
              lableContainer(label: "Reqt. Units", fillText: requiredUnits),
            ],
          ),
        ],
      ),
    );
  }
}
