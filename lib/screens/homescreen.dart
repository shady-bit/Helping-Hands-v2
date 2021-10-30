import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/UI/myAppBars.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/notifiers/post.dart';
import 'package:helpinghandsversion2/screens/viewPatientDetails.dart';
import 'package:helpinghandsversion2/widgets/postCard.dart';
import 'package:helpinghandsversion2/widgets/postFilterWidget.dart';
import 'package:helpinghandsversion2/widgets/storyCircle.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar.homeScreenAppBar(),
        body: Stack(
          children: [
            Container(
                child: Column(
              children: [
                Container(
                  height: 90.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: StoryCircle())),
                ),
                SizedBox(
                  height: 10.h,
                ),
                PostFilterWidget(),
                SizedBox(
                  height: 10,
                ),
                Consumer<PostProvider>(builder: (_, posts, __) {
                  return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, i) => PostCard(
                                postDetails: posts.postList[i],
                              ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: posts.postList.length));
                }),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                height: 43.h,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed("/myRequest");
                        },
                        style: CustomButtonStyle.buildOutlinedButtonStyle(),
                        child: Text(
                          "My Request",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: CustomButtonStyle.buildOutlinedButtonStyle(),
                        child: Text(
                          "Accepted Request",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
