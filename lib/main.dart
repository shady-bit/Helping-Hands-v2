import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/notifiers/gps.dart';
import 'package:helpinghandsversion2/notifiers/post.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/notifiers/profileFormValidator.dart';
import 'package:helpinghandsversion2/notifiers/time.dart';
import 'package:helpinghandsversion2/routes.dart';
import 'package:helpinghandsversion2/screens/PostFormScreens/postRequestCreate.dart';
import 'package:helpinghandsversion2/screens/OTPScreen.dart';
import 'package:helpinghandsversion2/screens/PhoneAuthScreen.dart';
import 'package:helpinghandsversion2/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:trust_location/trust_location.dart';

import 'screens/ProfileForm/EditUserDetails.dart';
import 'screens/ProfileForm/PersonDetailsForm.dart';
import 'widgets/noInternet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
//  final AuthProvider _authProvider = new AuthProvider();
  Time _time = new Time();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(433, 921),
      builder: () => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              lazy: false,
            ),
            ChangeNotifierProvider(create: (_) => ProfileFormProvider()),
            ChangeNotifierProvider(create: (_) => PostFormProvider()),
             ChangeNotifierProvider(create: (_) => PostProvider(),),
            StreamProvider<DateTime>.value(
              value: _time.intStream(),
              initialData: DateTime.now(),
            )
          ],
          child: GetMaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'IN'),
            ],
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context), // Add the locale here
            builder: DevicePreview.appBuilder,
            onReady: () {
              // _authProvider.listenForAuthChanges();
              requestLocationPermission();
              TrustLocation.start(5);
              getLocaion();
            },
            title: 'Helping Hands',
            theme:
                ThemeData(primarySwatch: Colors.red, buttonColor: Colors.red),
            home: SplashScreen(),
            // home: PostRequestCreate(),
            onGenerateRoute: Routes.fn,
            navigatorKey: Get.key,
            onDispose: () {
              TrustLocation.stop();
            },
          )),
    );
  }

  void getLocaion() {
    try {
      TrustLocation.onChange.listen((values) {
        print("location");
        print(values.latitude);
        print(values.longitude);
        print(values.isMockLocation);
        if (values.latitude != null &&
            values.longitude != null &&
            values.isMockLocation != null) {
          GpsLocation.setValues(double.parse(values.latitude!),
              double.parse(values.longitude!), values.isMockLocation);
        }
      });
    } on PlatformException catch (e) {
      print('PlatformException $e');
    }
  }

  void requestLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    print('permissions: $permission');
    if (permission != PermissionStatus.granted) {
      requestLocationPermission();
    }
  }
}
