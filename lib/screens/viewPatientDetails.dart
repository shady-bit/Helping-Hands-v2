import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/buildLocationDetails.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/buildPatientAttenders.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/buildPatientDetails.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/buildRequiredDetails.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/buildUserPostedMeta.dart';
import 'package:helpinghandsversion2/UI/ViewPatientDetailsWidget/lableContainer.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/model/patientAttender.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';

class ViewPatientDetails extends StatefulWidget {
  final PostDetails postDetails;
  const ViewPatientDetails({Key? key, required this.postDetails})
      : super(key: key);

  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState();
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {
  late String uid;

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var details = widget.postDetails;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Patient Details",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(25.w, 10.h, 10.w, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8.5,
                                        width: 8.5,
                                        decoration: details.expired == false
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: details.active == true
                                                    ? Colors.greenAccent
                                                    : CustomColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50))
                                            : BoxDecoration(
                                                color: Colors.yellow,
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: details.expired == false
                                            ? Text(
                                                details.active == true
                                                    ? "Active"
                                                    : "Not active",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                              )
                                            : Text(
                                                "Expired",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                              ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          buildRequiredDetails(
                            requirementType: details.requirementType,
                            requiredDateTime: UtilFuctions.timeStampToDate(
                                details.bloodRequiredDateTime),
                            requiredUnits: details.requiredUnits,
                            bloodGrpRequired: details.requiredBloodGrp,
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          buildPatientDetails(
                            patientName: details.patientName,
                            patientAge: details.patientAge,
                            purpose: details.purpose,
                          ),
                          // buildPatientDetails(),
                          SizedBox(
                            height: 13.h,
                          ),
                          buildPatientAttenders(
                            attender1: PatientAttender(
                              attenderName: details.patientAttenderName1,
                              attenderContact:
                                  "+91" + details.patientAttenderContact1,
                            ),
                            attender2: PatientAttender(
                              attenderName: details.patientAttenderName2,
                              attenderContact:
                                  "+91" + details.patientAttenderContact2!,
                            ),
                            attender3: PatientAttender(
                              attenderName: details.patientAttenderName3,
                              attenderContact:
                                  "+91" + details.patientAttenderContact3!,
                            ),
                          ),
                          //     buildPatientAttenders()
                          buildLocationDetails(
                            hospitalName: details.hospitalName,
                            hospitalCity: details.hospitalCity,
                            hospitalArea: details.hospitalArea,
                            hospitalLatLng: LatLng(
                                details.hospitalLocation.latitude,
                                details.hospitalLocation.longitude),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          details.createdBy != uid
                              ? buildUserPostedMeta(
                                  userUid: details.createdBy!,
                                )
                              : Container(),
                          SizedBox(
                            height: 150.h,
                          )
                        ]))),
            details.createdBy != uid
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: ElevatedButton(
                              style: CustomButtonStyle.buildButtonStyle(),
                              onPressed: () {},
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text("Raise Donation Request")),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ));
  }
}
