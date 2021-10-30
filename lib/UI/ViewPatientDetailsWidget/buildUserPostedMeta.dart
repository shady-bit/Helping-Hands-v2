import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';

class buildUserPostedMeta extends StatefulWidget {
  final String userUid;
  const buildUserPostedMeta({Key? key, required this.userUid})
      : super(key: key);

  @override
  _buildUserPostedMetaState createState() => _buildUserPostedMetaState();
}

class _buildUserPostedMetaState extends State<buildUserPostedMeta> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("Profile")
            .doc(widget.userUid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: CustomColors.red,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: snapshot.data!["profilePic"] != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: "images/person.png",
                                  image: snapshot.data!["profilePic"],
                                  height: 325.h,
                                  width: 325.w,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "images/person.png",
                                  height: 130.h,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Posted By",
                      style:
                          TextStyle(color: CustomColors.grey, fontSize: 15.sp),
                    ),
                    Text(
                      snapshot.data!["name"],
                      style: TextStyle(
                          color: CustomColors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    )
                  ],
                ),
                SizedBox(
                  width: 30.w,
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    height: 40,
                    width: 40,
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
                      Icons.question_answer_outlined,
                      color: CustomColors.red,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    UtilFuctions.makePhoneCall(snapshot.data!["phone"], false);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
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
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
