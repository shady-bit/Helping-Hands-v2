import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/model/slide.dart';
import 'package:helpinghandsversion2/widgets/slideItem.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController pageController = PageController(initialPage: 0);

  _onChangeed(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TO-DO Roshan
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: slideList.length,
                      itemBuilder: (context, i) => SlideItem(i),
                      onPageChanged: _onChangeed,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 55.h),
                            child: AnimatedSmoothIndicator(
                              activeIndex: _currentPage,
                              count: 4,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 8.0,
                                  dotHeight: 8.0,
                                  spacing: 10.0,
                                  dotColor: CustomColors.lightGrey,
                                  activeDotColor: Colors.red),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: CustomButtonStyle.buildButtonStyle(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: Text("Continue",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          onPressed: pushToPhoneAuth,
                          // splashColor: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushToPhoneAuth() {
    Get.offNamed("/phoneAuth");
  }
}
