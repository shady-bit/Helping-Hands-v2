import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/model/story.dart';
import 'package:helpinghandsversion2/model/userStoryMeta.dart';
import 'package:helpinghandsversion2/screens/storyScreen.dart';

class StoryCircle extends StatelessWidget {
  const StoryCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Story> stories = [
      Story(
          duration: Duration(seconds: 3),
          url:
              "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg",
          user: User(
              name: "Roshan Singh",
              profileImageUrl:
                  "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg")),
      // Story(
      //     duration: Duration(seconds: 3),
      //     url:
      //         "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg",
      //     user: User(
      //         name: "dd",
      //         profileImageUrl:
      //             "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg")),
      // Story(
      //     duration: Duration(seconds: 3),
      //     url:
      //         "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg",
      //     user: User(
      //         name: "dd",
      //         profileImageUrl:
      //             "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg")),
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => StoryScreen(stories: stories)));
      },
      child: Container(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 27.w,
                  backgroundColor: Colors.grey,
                ),
                Text(
                  "Name",
                  style: TextStyle(fontSize: 15.sp),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
