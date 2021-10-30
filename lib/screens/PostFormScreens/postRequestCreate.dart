import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/model/postFormValidator.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/notifiers/post.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/screens/PostFormScreens/buildHosptialLocation.dart';
import 'package:helpinghandsversion2/screens/PostFormScreens/buildPatientAttenderDetails.dart';
import 'package:helpinghandsversion2/screens/PostFormScreens/buildPatientDetails.dart';
import 'package:provider/provider.dart';
import 'package:helpinghandsversion2/UI/myAppBars.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'BuildRequirementType.dart';
import 'buildRequirementsDetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostRequestCreate extends StatefulWidget {
  PostDetails? details;
  String? requiremetntTpye;
  PostRequestCreate({this.details, this.requiremetntTpye});

  @override
  _PostRequestCreateState createState() => _PostRequestCreateState();
}

class _PostRequestCreateState extends State<PostRequestCreate> {
  @override
  void initState() {
    context.read<PostFormProvider>().clear();
    if (widget.details == null) {
      context
          .read<PostFormProvider>()
          .validateRequirementType(widget.requiremetntTpye, notify: false);
    } else {
      print(widget.details!.requirementType);
      context.read<PostFormProvider>().validateRequirementType(
          widget.details!.requirementType,
          notify: false);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: MyAppBar.postRequirementAppBar(
          requirementText: "requirement type",
          actions: [
            TextButton(
                onPressed: () {
                  if (widget.details == null) {
                    if (context.read<PostFormProvider>().validate()) {
                      PostFormValidatorModel _postFormValidatorModel = context
                          .read<PostFormProvider>()
                          .postFormValidatorModel;
                      User? _user = context.read<AuthProvider>().user;
                      if (_user != null) {
                        context
                            .read<PostProvider>()
                            .create(_postFormValidatorModel, _user);
                        Get.back();
                      }
                    }
                  }
                  else {
                     if (context.read<PostFormProvider>().validate()) {
                      PostFormValidatorModel _postFormValidatorModel = context
                          .read<PostFormProvider>()
                          .postFormValidatorModel;
                        context
                            .read<PostProvider>()
                            .update(_postFormValidatorModel , widget.details!.id!);
                        Get.back();
                      }
                    }
                  },
                child: Text(
                  widget.details != null ? "UPDATE" : "POST",
                  style: TextStyle(fontSize: 19.sp),
                ))
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.details != null ? BuildRequiementType() : Container(),
              SizedBox(
                height: 20.h,
              ),
              buildCatagory(
                "Patient Details",
                BuildPatientDetails(widget.details),
              ),
              buildCatagory(
                "Requirement Details",
                BuildRequirementDetails(widget.details),
              ),
              buildCatagory(
                "Location Details",
                BuildHospitalLocation(widget.details),
              ),
              buildCatagory(
                "Patient Attender Details",
                BuildPatientAttenderDetails(widget.details),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "You are done!!",
                style: TextStyle(color: CustomColors.textInputColor),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCatagory(String title, Widget _widget) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: _widget,
          ),
        ],
      ),
    );
  }
}
