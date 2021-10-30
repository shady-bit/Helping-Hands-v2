import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/notifiers/time.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<DateTime>(context);
    print("splash");
    print(model.toString());
    return Scaffold(
      body: Center(
        child: Center(child: Text("Splash screen")),
      ),
    );
  }
}
