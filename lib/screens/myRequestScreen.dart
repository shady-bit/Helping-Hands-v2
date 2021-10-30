import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/myAppBars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/util/utilFunctions.dart';
import 'package:helpinghandsversion2/widgets/myRequestPostCard.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({Key? key}) : super(key: key);

  @override
  _MyRequestScreenState createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar.myRequestAppBar(),
      backgroundColor: Colors.white,
      body: PaginateFirestore(
        key: UniqueKey(),
        isLive: true,
        itemsPerPage: 10,
        itemBuilderType: PaginateBuilderType.listView,
        separator: Divider(),
        itemBuilder: (index, context, documentSnapshot) {
          return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: MyRequestPostCard(
                postDetails: PostDetails.fromJson(documentSnapshot.id,
                    documentSnapshot.data() as Map<String, dynamic>),
              ));
        },
        emptyDisplay: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You haven't posted any requests yet!!",
              style: TextStyle(color: CustomColors.grey, fontSize: 45.sp),
            ),
            SizedBox(
              height: 17.h,
            ),
          ],
        )),

        // orderBy is compulsary to enable pagination
        query: FirebaseFirestore.instance
            .collection("Post")
            .where("createdBy", isEqualTo: authProvider.user!.uid)
            .orderBy("bloodRequiredDateTime", descending: true),
        // to fetch real-time data
      ),
    );
  }
}
