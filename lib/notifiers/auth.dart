import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpinghandsversion2/customUtil.dart';
import 'package:helpinghandsversion2/model/profileFormValidatorModel.dart';
import 'package:helpinghandsversion2/notifiers/gps.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/api/firebaseApi.dart';
import 'package:helpinghandsversion2/model/profile.dart';
import 'package:helpinghandsversion2/widgets/alertDialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  String? _verificationId;
  int? _forceResendingToken;
  late String _phoneNo;
  Timer? _timer;
  int _start = 60;
  late Profile _profile;
  GoogleSignInAccount? _account;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  AuthProvider() {
    listenForAuthChanges();
  }

  GoogleSignInAccount? get account => _account;
  int get remainingTime => _start;
  String get phoneNo => _phoneNo;
  User? get user => _user;
  Profile get profile => _profile;
  void startTimer() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _start = 0;
          _timer!.cancel();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }

  Future<bool> checkUserDataExist(String uid) async {
    print(":::::::Entered Function to check for data::::::UID: $uid");
    DocumentSnapshot<Map<String, dynamic>> snap;
    snap = await FirebaseApi.getUserData(uid);
    if (snap.exists) {
      _profile = Profile.fromJson(snap.data()!);
      return true;
    } else {
      return false;
    }
  }

  listenForAuthChanges() {
    print("auth");
    _firebaseAuth.authStateChanges().listen((event) async {
      print("in auth listen");
      _user = event;
      if (_user != null) {
        if (_timer != null) {
          _timer!.cancel();
        }
        bool isUserExists = await checkUserDataExist(_user!.uid);
        if (isUserExists) {
          for (;;) {
            if (GpsLocation.lattidue != null) {
              break;
            }
            await Future.delayed(Duration(milliseconds: 500));
          }
          Get.offAllNamed("/dashboard");
        } else {
          _account = null;
          for (;;) {
            _account = await _handleSignIn();
            print("sign in");
            print(_account.toString());
            if (_account != null) {
              break;
            }
          }
          if (_account != null) {
            File url = await _asyncMethod(_account!.photoUrl!);
            Get.offAllNamed('/createProfile', arguments: {
              'name': _account!.displayName,
              'email': _account!.email,
              'url': url
            });
          }
        }
      } else {
        Get.offAllNamed("/gettingStarted");
      }
    });
  }

  Future<File> _asyncMethod(String url) async {
    print("url");
    print(url);
    var response = await get(Uri.parse(url)); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = new File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes, flush: true); // <-- 3
    return file2;
  }

  Future<GoogleSignInAccount?> _handleSignIn() async {
    try {
      GoogleSignInAccount? _account = await _googleSignIn.signIn();
      return _account;
    } catch (error) {
      print(error);
    }
    return null;
  }

  void verifyPhone({required String phoneNumber, bool resending = false}) {
    Get.dialog(AlertDialogBox(
      title: "Sending",
    ));
    _phoneNo = phoneNumber;
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        print("in verification completed");
        print(phoneAuthCredential.smsCode);
      },
      verificationFailed: (verificationFailed) {
        print("in Verification failed");
        print(verificationFailed.toString());
      },
      codeSent: (id, token) {
        print("in code Sent");
        _verificationId = id;
        _forceResendingToken = token;
        startTimer();
        if (!resending)
          Get.offAllNamed("/otp");
        else
          Get.back();
      },
      codeAutoRetrievalTimeout: (_) {
        print("Auto Retrieval timeout");
      },
      // autoRetrievedSmsCodeForTesting: ,
      forceResendingToken: _forceResendingToken,
    );
  }

  void verifyOtp({required String otp}) async {
    UserCredential? _userCred;
    Get.dialog(AlertDialogBox(
      title: "verifying",
    ));
    if (_verificationId != null) {
      FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationId!, smsCode: otp))
          .then((value) {
        _userCred = value;
      }, onError: (e, s) {
        Get.back();
        Get.snackbar("wrong otp", "invalid otp");
      });
    }
  }

  Future<String> getRefferal() async {
    for (;;) {
      String code = CustomUtil.getRandomString(6);
      QuerySnapshot<Map<String, dynamic>> _docs =
          await FirebaseApi.checkIfRefferalExists(code: code);
      if (_docs.docs.isEmpty) {
        return code;
      }
    }
  }

  void createProfile(ProfileFormValidatorModel _profileFormValidator) async {
    Get.dialog(AlertDialogBox(
      title: "creating",
    ));
    print("saving");
    String? _deviceToken = await FirebaseApi.getDeviceToken();
    print(_deviceToken);

    String _email = _account!.email;
    print(_account!.toString());
    String _profilePicUrl = await FirebaseApi.uploadPic(
        folder: "Profile",
        fileName: _user!.uid,
        image: _profileFormValidator.profilePicFile);
    print(_profilePicUrl);
    String _refferalCode = await getRefferal();
    print(_refferalCode);
    late LatLng l;
    late String? _userAddr;
    if (GpsLocation.lattidue != null && GpsLocation.longnitude != null) {
      l = LatLng(GpsLocation.lattidue!, GpsLocation.longnitude!);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(l.latitude, l.longitude);

      String name = placemarks.first.name ?? "";
      String subLocality = placemarks.first.subLocality ?? "";
      String locality = placemarks.first.locality ?? "";
      String administrativeArea = placemarks.first.administrativeArea ?? "";
      String postalCode = placemarks.first.postalCode ?? "";
      String country = placemarks.first.country ?? "";
      _userAddr =
          "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
    }
    Profile p = new Profile(
        name: _profileFormValidator.name.value,
        email: _email,
        bloodGrp: _profileFormValidator.bloodGroup.value,
        deviceToken: _deviceToken!,
        dob: _profileFormValidator.dateOfBirth.value,
        emergency1: _profileFormValidator.emergencyContact1.value,
        emergency2: _profileFormValidator.emergecyContact2.value,
        lifePoints: 0,
        phone: _user!.phoneNumber!,
        profilePic: _profilePicUrl,
        referralCode: _refferalCode,
        uid: _user!.uid,
        userAddress: _userAddr ?? "null",
        donateBlood: _profileFormValidator.donateBlood.value,
        donatePlasma: _profileFormValidator.donatePlasma.value,
        donatePlatlets: _profileFormValidator.donatePlatelets.value,
        lastOpened: FieldValue.serverTimestamp(),
        latLng: l,
        friend: _profileFormValidator.referral.value,
        lastDonated:
            _profileFormValidator.lastBloodDonated.value.runtimeType == DateTime
                ? _profileFormValidator.lastBloodDonated.value
                : null,
        lastPlasmaDonated:
            _profileFormValidator.lastPlasmaDonated.value.runtimeType ==
                    DateTime
                ? _profileFormValidator.lastPlasmaDonated.value
                : null,
        lastPlateletsDonated:
            _profileFormValidator.lastPlateletsDonated.value.runtimeType ==
                    DateTime
                ? _profileFormValidator.lastPlateletsDonated.value
                : null);
    FirebaseApi.uploadData("Profile", _user!.uid, p.toJson());
    _profile = p;
    Get.offAllNamed("/homeScreen");
  }
}
