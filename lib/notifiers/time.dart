import 'dart:async';
import 'dart:io';
import 'package:ntp/ntp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Time {
  int? offset;
  bool error = false;
  StreamController<DateTime> sc = StreamController();
  Time() {
    getTime();
  }

  Stream<DateTime> intStream() {
    return sc.stream;
  }

  void getTime() {
    Timer _timer;

    _timer = new Timer.periodic(
      Duration(seconds: 5),
      (Timer timer) async {
        DateTime startDate = DateTime.now();
        try {
          await NTP
              .getNtpOffset(localTime: startDate, timeout: Duration(seconds: 4))
              .then((value) {
            offset = value;
            if (offset != null) {
              // print("offset is not null");
              // print(offset);
              startDate = startDate.add(Duration(milliseconds: offset!));
            } else {
              // print("offset is null");
            }
            if (error == true) {
              Get.back();
              error = false;
            }
            sc.add(startDate);
          });
        } on SocketException {
          print("socket ex");
          print("error" + error.toString());
          if (error == false) {
            error = true;
            Get.toNamed('/noInternet');
          }
        }
      },
    );
  }

  DateTime getCurrentTime() {
    DateTime currentTime = DateTime.now();
    if (offset != null) {
      return currentTime.add(Duration(milliseconds: offset!));
    } else {
      return currentTime;
    }
  }

  Timestamp getCurrentTimeStamp() {
    Timestamp time = Timestamp.now();
    if (offset != null) {
      return Timestamp.fromDate(
          time.toDate().add(Duration(milliseconds: offset!)));
    } else {
      return time;
    }
  }
}
