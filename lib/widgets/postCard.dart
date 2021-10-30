import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/bottomSheets.dart';
import 'package:helpinghandsversion2/api/firebaseApi.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/notifiers/gps.dart';
import 'package:intl/intl.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:provider/provider.dart';
import 'bottomSheetPill.dart';

class PostCard extends StatelessWidget {
  PostDetails postDetails;
  PostCard({required this.postDetails});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/viewPatientDetails", arguments: {
          "postDetails": postDetails,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        child: Row(
          children: [
            FutureBuilder<String>(
                future: FirebaseApi.getProfileImage(postDetails.createdBy!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.red),
                    );
                  }
                  return Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                        child: CachedNetworkImage(
                      imageUrl: snapshot.data!,
                    )),
                    clipBehavior: Clip.hardEdge,
                  );
                }),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: postDetails.requiredBloodGrp,
                        style: TextStyle(color: CustomColors.red)),
                    TextSpan(
                        text: " " +
                            postDetails.requirementType +
                            " required for " +
                            postDetails.purpose,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp))
                  ])),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "${DateFormat('dd MMM yyyy').format(postDetails.bloodRequiredDateTime)}   |   ${postDetails.requiredUnits} units  | ${calculateDistance(lat1: postDetails.hospitalLocation.latitude, lat2: GpsLocation.lattidue, lon1: postDetails.hospitalLocation.longitude, lon2: GpsLocation.longnitude)}",
                            style: TextStyle(
                                color: CustomColors.grey, fontSize: 14.sp)),
                        TextSpan(
                            text: "", style: TextStyle(color: Colors.green))
                      ])),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  postBottomSheet(context);
                },
                icon: Icon(Icons.more_vert_outlined))
          ],
        ),
      ),
    );
  }

  String calculateDistance({lat1, lon1, lat2, lon2}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));
    if (distance > 1) {
      return distance.floor().toString() + " KM";
    } else {
      return (distance * 1000).floor().toString() + " m";
    }
  }

  postBottomSheet(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    TextStyle titleStyle = TextStyle(fontSize: 19.sp);
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                height: screenHeight * 0.31,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        PillContainer(),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Text(
                                  "View Requirement",
                                  style: titleStyle,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Text(
                                  "Share to...",
                                  style: titleStyle,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Text(
                                  "Copy",
                                  style: titleStyle,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: postDetails.createdBy ==
                              context.read<AuthProvider>().user!.uid
                          ? 10.h
                          : 0,
                    ),
                    postDetails.createdBy ==
                            context.read<AuthProvider>().user!.uid
                        ? Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    Get.offNamed("/updatePostForm",
                                        arguments: {'data': postDetails});
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Text(
                                        "Edit",
                                        style: titleStyle,
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 21.h,
                    ),
                  ],
                ),
              ),
            ));
  }
}
