import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';

class BuildDropDown extends StatelessWidget {
  final String title;
  final Widget child;
  BuildDropDown({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CustomColors.veryLightGrey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(
            height: 10,
          ),
          child
        ],
      ),
    );
  }
}
