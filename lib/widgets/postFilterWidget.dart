import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/bottomSheets.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/bloodGroup.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/notifiers/post.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:provider/provider.dart';

class PostFilterWidget extends StatefulWidget {
  const PostFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PostFilterWidgetState createState() => _PostFilterWidgetState();
}

class _PostFilterWidgetState extends State<PostFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              height: 50.h,
              color: CustomColors.veryLightGrey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    // child: Text(DateFormat.yMMMMEEEEd().format(time.getCurrentTime()()),style: TextStyle(fontWeight: FontWeight.w400),)),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          // height: 40,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 16.sp),
                              children: <TextSpan>[
                                // TextSpan(
                                //     text: context
                                //             .read<AuthProvider>()
                                //             .profile
                                //             .bloodGrp +
                                //         " ",
                                //     style: TextStyle(
                                //         color: CustomColors.red,
                                //         fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "You can donate to " +
                                        canDonate(context
                                            .read<AuthProvider>()
                                            .profile
                                            .bloodGrp),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp))
                              ],
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        filterBottomSheet(context);
                      },
                      icon: Icon(
                        Icons.tune_outlined,
                        size: 20,
                      ))
                ],
              )),
        ),
      ],
    );
  }

  String canDonate(String grp) {
    String _bloodStrings = "";
    BloodGrp.canGive[grp]!.forEach((element) {
      _bloodStrings = _bloodStrings + element;
      if (BloodGrp.canGive[grp]!.last != element) {
        _bloodStrings = _bloodStrings + ", ";
      }
    });
    return _bloodStrings;
  }

  filterBottomSheet(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    int _bloodTypeIndex = context.read<PostProvider>().any ? 0 : 1;
    double _distance = context.read<PostProvider>().radius;
    List<String> _bloodType = ["All Post", "I can donate"];
    List<String> _requirementType = ["All", "Blood", "Plasma", "Platelets"];
    int _requirementTypeIndex = !context.read<PostProvider>().allRequiremtType
        ? _requirementType.indexOf(context.read<PostProvider>().reuirementType)
        : 0;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setMode) {
              return Container(
                height: screenHeight * 0.42,
                child: Stack(
                  children: [
                    Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 0),
                        // height: screenHeight * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 23.h,
                            ),
                            Text(
                              "Filter by blood type",
                              style: TextStyle(fontSize: 19.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            FlutterToggleTab(
                              unSelectedBackgroundColors: [
                                CustomColors.lightGrey
                              ],
                              // width in percent, to set full width just set to 100
                              width: screenWidth * 0.1,
                              borderRadius: 30,
                              height: 30.h,
                              initialIndex: _bloodTypeIndex,

                              // selectedColors: [Colors.blue],
                              selectedTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700),
                              unSelectedTextStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              labels: _bloodType,
                              selectedLabelIndex: (index) {
                                _bloodTypeIndex = index;
                              },
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            Text(
                              "Filter by requirement type",
                              style: TextStyle(fontSize: 19.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            FlutterToggleTab(
                              unSelectedBackgroundColors: [
                                CustomColors.lightGrey
                              ],
                              // width in percent, to set full width just set to 100
                              width: screenWidth * 0.18,
                              borderRadius: 30,
                              height: 30.h,
                              initialIndex: _requirementTypeIndex,
                              // selectedColors: [Colors.blue],
                              selectedTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700),
                              unSelectedTextStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              labels: _requirementType,
                              selectedLabelIndex: (index) {
                                _requirementTypeIndex = index;
                              },
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            Text(
                              "Filter by distance (Km)",
                              style: TextStyle(fontSize: 19.sp),
                            ),
                            // Slider(
                            //   value: _bloodTypeIndex,
                            //   min: 0,
                            //   max: 100,
                            //   divisions: 5,
                            //   label: _bloodTypeIndex.round().toString(),
                            //   onChanged: (double value) {
                            //     setMode(() {
                            //       _bloodTypeIndex = value;
                            //     });
                            //   },
                            // ),
                            SfSlider(
                              min: 20.0,
                              max: 100.0,
                              value: _distance,
                              interval: 20,
                              showTicks: false,
                              stepSize: 20,
                              showLabels: true,
                              enableTooltip: true,
                              minorTicksPerInterval: 0,
                              onChanged: (dynamic value) {
                                setMode(() {
                                  _distance = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.h),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<PostProvider>().changeFilter(
                                      _bloodTypeIndex == 0
                                          ? "Any"
                                          : context
                                              .read<AuthProvider>()
                                              .profile
                                              .bloodGrp,
                                      _distance,
                                      _requirementType[_requirementTypeIndex]);
                                  Get.back();
                                },
                                child: Text("Apply"),
                                style: CustomButtonStyle.buildButtonStyle(),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
