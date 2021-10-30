import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';

import 'lableContainer.dart';

class buildLocationDetails extends StatelessWidget {
  final String hospitalName;
  final String hospitalCity;
  final String hospitalArea;
  final String? otherDetails;
  final String? roomNumber;
  final LatLng hospitalLatLng;
  const buildLocationDetails(
      {Key? key,
      required this.hospitalLatLng,
      required this.hospitalArea,
      required this.hospitalCity,
      required this.hospitalName,
      this.roomNumber,
      this.otherDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Location Details",
            style: TextStyle(
                color: CustomColors.red,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer(label: "Hospital Name", fillText: hospitalName),
              lableContainer(label: "Hosp. City Name", fillText: hospitalCity),
              lableContainer(label: "Hosp. Area Name", fillText: hospitalArea),
              roomNumber != null && roomNumber != ""
                  ? lableContainer(
                      label: "Hosp. Room No.", fillText: roomNumber)
                  : Container(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Hosp. Address",
                        style: TextStyle(
                          // color: subTextColor,
                          fontSize: 18.sp,
                        ),
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
                      padding: EdgeInsets.only(right: 130.h),
                      width: MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            UtilFuctions.launchMapsUrl(hospitalLatLng.latitude,
                                hospitalLatLng.longitude);
                          },
                          child: Icon(
                            Icons.directions,
                            color: CustomColors.red,
                            size: 23,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              otherDetails != null && otherDetails != ""
                  ? Padding(
                      padding: EdgeInsets.only(top: 0.h),
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                "Other Details",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Container(
                                height: 90.h,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  otherDetails.toString(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
