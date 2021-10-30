import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lableContainer.dart';

class buildPatientDetails extends StatelessWidget {
  final String patientName;
  final String patientAge;
  final String purpose;
  const buildPatientDetails(
      {Key? key,
      required this.patientAge,
      required this.patientName,
      required this.purpose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Patient Details",
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
              lableContainer(label: "Patient Name", fillText: patientName),
              lableContainer(label: "Age", fillText: patientAge),
              lableContainer(label: "Purpose", fillText: purpose),
            ],
          ),
        ],
      ),
    );
  }
}
