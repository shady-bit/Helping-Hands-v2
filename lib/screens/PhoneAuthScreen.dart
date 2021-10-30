import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'OTPScreen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String? phoneNum;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "images/phoneAuth.png",
                  height: 240.h,
                  // color: Colors.red,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Mobile Verification",
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              RichText(
                text: TextSpan(
                    text: "We will send you an ",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: " One Time Password\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: " on this mobile number",
                          style: TextStyle(color: Colors.grey)),
                    ]),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "+91",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Form(
                        key: _formKey,
                        child: Flexible(
                          child: TextFormField(
                            maxLength: 10,
                            autofocus: true,
                            validator: (val) {
                              if (val == null) {
                                return "error";
                              }
                              if (val.isEmpty) {
                                return "Enter your Phone number";
                              } else if (val.length < 10) {
                                return "Enter valid number";
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                phoneNum = val;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Enter Phone Number",
                                hintStyle: TextStyle()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: CustomButtonStyle.buildButtonStyle(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          showAlertDialog(context);
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text("Request OTP")),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text("For verification we will be sending OTP to this number",
              style: TextStyle(fontSize: 19.sp)),
          content: Text(
            "+91 " + phoneNum!,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder()),
              ),
              child: Text(
                "EDIT",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 18.sp),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder()),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(color: CustomColors.red, fontSize: 16.5),
                ),
                onPressed: () {
                  Get.back();
                  context
                      .read<AuthProvider>()
                      .verifyPhone(phoneNumber: "+91 " + phoneNum!);
                })
          ],
        );
      },
    );
  }
}
