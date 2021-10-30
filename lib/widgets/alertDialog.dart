import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  String title;


   AlertDialogBox({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
    
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text(title +"...")
          ],
        ),
      );
  }
}