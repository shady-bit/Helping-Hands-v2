import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';

class BloodGroupSelector extends StatefulWidget {
  String? selectedGroup;
  BloodGroupSelector({this.selectedGroup});

  @override
  _BloodGroupSelectorState createState() => _BloodGroupSelectorState();
}

class _BloodGroupSelectorState extends State<BloodGroupSelector> {
  Map<String, bool> _bloodGroups = {
    'A-': false,
    'B-': false,
    'AB-': false,
    "O-": false,
    "A+": false,
    "B+": false,
    "AB+": false,
    "O+": false
  };

  List<Widget> _list = [];

  @override
  void initState() {
    if (widget.selectedGroup != null) {
      _bloodGroups[widget.selectedGroup!] = true;
    }
    _bloodGroups.forEach((key, value) {
      _list.add(GestureDetector(
        onTap: () {
          Get.back(result: key);
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: value ? CustomColors.red : Colors.white,
              border: Border.all(color: CustomColors.red),
              borderRadius: BorderRadius.circular(80)),
          child: Text(
            key,
            style: TextStyle(
                fontSize: 18,
                color: value ? CustomColors.white : CustomColors.red,
                fontWeight: FontWeight.w700),
          ),
        ),
      ));
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Center(
                child: Text(
                  "Selected your Blood Group",
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: CustomColors.red, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                // color: Colors.green,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _list[0],
                        _list[1],
                        _list[2],
                        _list[3],
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _list[4],
                        _list[5],
                        _list[6],
                        _list[7],
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
