import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/model/patientAttender.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';

class buildPatientAttenders extends StatelessWidget {
  final PatientAttender attender1;
  final PatientAttender? attender2;
  final PatientAttender? attender3;
  const buildPatientAttenders(
      {Key? key, required this.attender1, this.attender2, this.attender3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Patient Attenders",
            style: TextStyle(
                color: CustomColors.red,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      attender1.attenderName!,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        UtilFuctions.makePhoneCall(
                            attender1.attenderContact!, false);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: Icon(
                          Icons.call,
                          color: CustomColors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: (attender1.attenderName != null &&
                          attender1.attenderName != "")
                      ? 8.h
                      : 0,
                ),
                attender2!.attenderName != null && attender2!.attenderName != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            attender2!.attenderName!,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          GestureDetector(
                            onTap: () {
                              UtilFuctions.makePhoneCall(
                                  attender2!.attenderContact!, false);
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]),
                              child: Icon(
                                Icons.call,
                                color: CustomColors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: (attender3!.attenderName != null &&
                          attender3!.attenderName != "")
                      ? 8.h
                      : 0,
                ),
                (attender3!.attenderName != null &&
                        attender3!.attenderName != "")
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            attender3!.attenderName!,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          GestureDetector(
                            onTap: () {
                              UtilFuctions.makePhoneCall(
                                  attender3!.attenderContact!, false);
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]),
                              child: Icon(
                                Icons.call,
                                color: CustomColors.red,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
