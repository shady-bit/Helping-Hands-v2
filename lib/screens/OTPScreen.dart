import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/otpPinDecoration.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  // final String phone;
  // OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final databaseReference = FirebaseFirestore.instance;

  bool dataExist = false;

  bool codeSent = false;
  String? pin;

  @override
  void initState() {
    super.initState();
  }

  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/message.png",
                  height: 205.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "OTP Verification",
                  style:
                      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: "Enter the OTP sent to ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                            text: "${authProvider.phoneNo}\n",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: PinPut(
                    eachFieldWidth: 32.w,
                    eachFieldHeight: 32.h,
                    autofocus: true,
                    withCursor: true,
                    fieldsCount: 6,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration:
                        OtpPinDecoration.buildPinDecoration(),
                    selectedFieldDecoration:
                        OtpPinDecoration.buildPinDecoration(),
                    followingFieldDecoration:
                        OtpPinDecoration.buildPinDecoration(),
                    pinAnimationType: PinAnimationType.scale,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                    onChanged: (text) {
                      pin = text;
                    },
                  ),
                ),
                Consumer<AuthProvider>(
                  builder: (_, auth, __) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 20.w, top: 5.h),
                              child: Text(
                                "00:${auth.remainingTime} sec",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 17.sp),
                                textAlign: TextAlign.end,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: auth.remainingTime != 0
                            ? () {}
                            : () {
                                authProvider.verifyPhone(
                                    phoneNumber: authProvider.phoneNo,
                                    resending: true);
                                // startTimer();
                              },
                        child: RichText(
                            text: TextSpan(
                                text: "Did'nt receive the verification OTP?",
                                style: TextStyle(color: Colors.grey),
                                children: [
                              TextSpan(
                                text: " RESEND OTP",
                                style: TextStyle(
                                    color: auth.remainingTime != 0
                                        ? Colors.grey
                                        : Colors.red),
                              )
                            ])),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ElevatedButton(
                          style: CustomButtonStyle.buildButtonStyle(),
                          onPressed: () {
                            print("submit");
                            print(authProvider.account.toString());
                            authProvider.verifyOtp(otp: pin!);
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              child: Text("VERIFY AND PROCEED")),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
