import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/screens/GettingStartedScreens/GettingStartedScreen.dart';
import 'package:helpinghandsversion2/screens/OTPScreen.dart';
import 'package:helpinghandsversion2/screens/PhoneAuthScreen.dart';
import 'package:helpinghandsversion2/screens/ProfileForm/EditUserDetails.dart';
import 'package:helpinghandsversion2/screens/ProfileForm/PersonDetailsForm.dart';
import 'package:helpinghandsversion2/screens/dashboardScreen.dart';
import 'package:helpinghandsversion2/screens/homeScreen.dart';
import 'package:helpinghandsversion2/screens/PostFormScreens/postRequestCreate.dart';
import 'package:helpinghandsversion2/screens/myRequestScreen.dart';
import 'package:helpinghandsversion2/screens/referral.dart';
import 'package:helpinghandsversion2/screens/splashScreen.dart';
import 'package:helpinghandsversion2/screens/viewPatientDetails.dart';
import 'package:helpinghandsversion2/widgets/noInternet.dart';

class Routes {
  static Route<dynamic>? fn(RouteSettings settings) {
    final Map<String, dynamic> arguments;
    if (settings.arguments == null) {
      arguments = {};
    } else {
      arguments = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (context) => PostRequestCreate());

      case '/splashscreen':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/dashboard':
        return MaterialPageRoute(builder: (context) => DashboardScreen());

      case '/gettingStarted':
        return MaterialPageRoute(builder: (context) => GettingStartedScreen());

      case '/phoneAuth':
        return MaterialPageRoute(builder: (context) => PhoneAuthScreen());

      case '/otp':
        return MaterialPageRoute(builder: (context) => OTPScreen());

      case '/homeScreen':
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case '/createProfile':
        return MaterialPageRoute(
            builder: (context) => ProfileForm(
                displayName: arguments['name'],
                email: arguments['email'],
                url: arguments['url']));

      case '/noInternet':
        return MaterialPageRoute(builder: (context) => NoInternet());

      case '/referral':
        return MaterialPageRoute(builder: (context) => ReffaralPage());

      case '/viewPatientDetails':
        return MaterialPageRoute(
            builder: (context) => ViewPatientDetails(
                  postDetails: arguments["postDetails"],
                ));

      case '/createPostForm':
        return MaterialPageRoute(
            builder: (context) => PostRequestCreate(
                  requiremetntTpye: arguments["requirement"],
                ));

      case '/updatePostForm':
        return MaterialPageRoute(
            builder: (context) => PostRequestCreate(
                  details: arguments["data"],
                ));

      case '/myRequest':
        return MaterialPageRoute(builder: (context) => MyRequestScreen());
      // case '/homeScreen':
      //   return MaterialPageRoute(builder: (context) => HomeScreen());

      // case '/postForm':
      //   return MaterialPageRoute(
      //       builder: (context) => PostRequestCreate(
      //             requirementType: "Platelet",
      //           ));
    }
  }
}
