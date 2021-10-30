import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';

class MyRequestPostCard extends StatelessWidget {
  final PostDetails postDetails;

  const MyRequestPostCard({
    Key? key,
    required this.postDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/viewPatientDetails", arguments: {
          "postDetails": postDetails,
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      width: 50.h,
                      decoration: BoxDecoration(
                          color: postDetails.expired
                              ? CustomColors.grey
                              : CustomColors.red,
                          border: Border.all(
                            color: postDetails.expired
                                ? CustomColors.grey
                                : CustomColors.red,
                          ),
                          borderRadius: BorderRadius.circular(80)),
                      child: Text(
                        postDetails.requiredBloodGrp,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Requirement",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "Required Date",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "Required Units",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "Patient Name",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "Purpose",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "City Name",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        ),
                        Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: postDetails.expired
                                  ? CustomColors.grey
                                  : Colors.black),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: postDetails.expired
                                    ? CustomColors.grey
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Padding(
                        padding: EdgeInsets.only(left: 28.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postDetails.requirementType,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            Text(
                              UtilFuctions.timeStampToDate(
                                  postDetails.bloodRequiredDateTime),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            Text(
                              postDetails.requiredUnits,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            Text(
                              postDetails.patientName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            Text(
                              postDetails.purpose,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            Text(
                              postDetails.hospitalCity,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: postDetails.expired
                                      ? CustomColors.grey
                                      : Colors.black),
                            ),
                            postDetails.active == null ||
                                    postDetails.active == true
                                ? Row(
                                    children: [
                                      Container(
                                        height: 6.h,
                                        width: 6.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: postDetails.active == true
                                              ? Colors.greenAccent
                                              : CustomColors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        postDetails.active == true
                                            ? "Active"
                                            : "Not Active",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: postDetails.expired
                                                ? CustomColors.grey
                                                : Colors.black),
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        height: 8.h,
                                        width: 8.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "Not active",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: postDetails.expired
                                                ? CustomColors.grey
                                                : Colors.black),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {},
                        child: Image.asset(
                          "images/icons/donorIcon.png",
                          height: 25.h,
                          // color: donors
                          //     ? CustomColors.red
                          //     : CustomColors.grey,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    !postDetails.expired
                        ? GestureDetector(
                            onTap: () {
                              // Get.to(
                              //   () =>
                              //       PostRequirement(snapshot, postDetails.expired),
                              // );
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: CustomColors.darkGery,
                            ))
                        : Container(),
                    postDetails.active == true
                        ? GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.share_outlined,
                              size: 20,
                              color: CustomColors.darkGery,
                            ))
                        : Container(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
