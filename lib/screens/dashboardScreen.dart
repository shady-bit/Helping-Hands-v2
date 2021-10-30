import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/bottomSheets.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/notifiers/post.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/widgets/bottomSheetPill.dart';
import 'package:helpinghandsversion2/widgets/requirementTypeSelector.dart';
import 'homescreen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  List<Widget> _bottomNavigationScreens = [
    HomeScreen(),
    HomeScreen(),
    Container(),
    HomeScreen(),
    HomeScreen(),
  ];

  double iconHeight = 26.h;
  @override
  void initState() {
    context.read<PostProvider>().getStream();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _bottomNavigationScreens.length,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 20,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              // backgroundColor: CustomColor.red,
              icon: Image.asset(
                "images/icons/drop.png",
                height: iconHeight,
                color: CustomColors.grey,
                alignment: Alignment.center,
              ),
              title: Text(""),
              activeIcon: Image.asset(
                "images/icons/drop.png",
                height: iconHeight,
                color: CustomColors.red,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              // backgroundColor: CustomColor.red,
              icon: Image.asset(
                "images/icons/loupe.png",
                height: iconHeight,
                color: CustomColors.grey,
                alignment: Alignment.center,
              ),
              title: Text(""),
              activeIcon: Image.asset(
                "images/icons/loupe.png",
                height: iconHeight,
                color: CustomColors.red,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              // backgroundColor: CustomColor.red,
              icon: Image.asset(
                "images/icons/plus.png",
                height: iconHeight,
                color: CustomColors.grey,
                alignment: Alignment.center,
              ),
              title: Text(""),
              activeIcon: Image.asset(
                "images/icons/plus.png",
                height: iconHeight,
                color: CustomColors.red,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              // backgroundColor: CustomColor.red,
              icon: Image.asset(
                "images/icons/bell.png",
                height: iconHeight,
                color: CustomColors.grey,
                alignment: Alignment.center,
              ),
              title: Text(""),
              activeIcon: Image.asset(
                "images/icons/bell.png",
                height: iconHeight,
                color: CustomColors.red,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              // backgroundColor: CustomColor.red,
              icon: Image.asset(
                "images/icons/user.png",
                height: iconHeight,
                color: CustomColors.grey,
                alignment: Alignment.center,
              ),
              title: Text(""),
              activeIcon: Image.asset(
                "images/icons/user.png",
                height: iconHeight,
                color: CustomColors.red,
                alignment: Alignment.center,
              ),
            ),
          ],
          onTap: (index) async {
            if (index == 2) {
              // Get.toNamed("/postForm");
              print(index);
              selectRequiTypeBottomSheet(context);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ),
        body: _bottomNavigationScreens[_currentIndex],
      ),
    );
  }

  selectRequiTypeBottomSheet(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                height: screenHeight * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PillContainer(),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Post Requirement",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RequirementTypeSelector(
                          image: "images/icons/blood.png",
                          title: "Blood",
                          onPress: () {
                            Get.back();
                            Get.toNamed("/createPostForm" , arguments: {"requirement": 'blood'});
                          },
                        ),
                        SizedBox(
                          width: screenWidth * 0.13,
                        ),
                        RequirementTypeSelector(
                          image: "images/icons/plasma.png",
                          title: "Plasma",
                          onPress: () {
                            Get.back();
                            Get.toNamed("/createPostForm" , arguments: {"requirement": 'plasma'});

                          },
                        ),
                        SizedBox(
                          width: screenWidth * 0.13,
                        ),
                        RequirementTypeSelector(
                          image: "images/icons/platelet.png",
                          title: "Platelet",
                          onPress: () {
                           
                            Get.back();
                            Get.toNamed("/createPostForm" , arguments: {"requirement": 'platelets'});

                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
