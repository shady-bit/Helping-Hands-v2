import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/api/firebaseApi.dart';
import 'package:helpinghandsversion2/constants/bloodGroup.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/model/postFormValidator.dart';
import 'package:helpinghandsversion2/notifiers/auth.dart';
import 'package:helpinghandsversion2/notifiers/gps.dart';
import 'package:rxdart/rxdart.dart';

class PostProvider extends ChangeNotifier {
  final _geoflutterfire = Geoflutterfire();
  Stream<List<DocumentSnapshot>>? stream;
  List<double> _radius = [20, 40, 60, 80, 100];
  bool any = true;
  bool allRequiremtType = true;
  double radius = 20.0;
  String reuirementType = 'All';
  Map<String, dynamic> filters = {
    'radius': 20.0,
    'bloodGroups': ['A-', 'B-', 'O-', 'AB-', 'A+', 'B+', 'O+', 'AB+'],
    'type': '',
  };
  late BehaviorSubject<Map<String, dynamic>> filterRx;
  List<PostDetails> _postList = [];

  List<PostDetails> get postList => _postList;

  // Map<String, bool> _bloodGroups = {
  //   'Any': false,
  //   'A-': false,
  //   'B-': false,
  //   'AB-': false,
  //   "O-": false,
  //   "A+": false,
  //   "B+": false,
  //   "AB+": false,
  //   "O+": false
  // };

  PostProvider() {
    filterRx = BehaviorSubject<Map<String, dynamic>>.seeded(filters);
  }

  void create(PostFormValidatorModel _postFormValidatorModel, User _user) {
    PostDetails _postDetails = PostDetails(
      active: true,
      bloodRequiredDateTime: _postFormValidatorModel.requiredDateTime.value,
      bloodRequiredDateTimeFirst:
          _postFormValidatorModel.requiredDateTime.value,
      createdBy: _user.uid,
      createdTime: FieldValue.serverTimestamp(),
      expired: false,
      gender: _postFormValidatorModel.gender.value,
      hospitalAddr: _postFormValidatorModel.hospitalLocation.value.first,
      hospitalArea: _postFormValidatorModel.hospitalAreaName.value,
      hospitalCity: _postFormValidatorModel.hospitalCity.value,
      hospitalLocation: _postFormValidatorModel.hospitalLocation.value.last,
      hospitalName: _postFormValidatorModel.hospitalName.value,
      hospitalRoomNo: _postFormValidatorModel.hospitalRoomNo.value,
      otherDetails: _postFormValidatorModel.otherDetails.value,
      patientAge: _postFormValidatorModel.patientAge.value,
      patientAttenderContact1:
          _postFormValidatorModel.patientAttenderContact1.value,
      patientAttenderContact2:
          _postFormValidatorModel.patientAttenderContact2.value,
      patientAttenderContact3:
          _postFormValidatorModel.patientAttenderContact3.value,
      patientAttenderName1: _postFormValidatorModel.patientAttenderName1.value,
      patientAttenderName2: _postFormValidatorModel.patientAttenderName2.value,
      patientAttenderName3: _postFormValidatorModel.patientAttenderName3.value,
      requiredBloodGrp: _postFormValidatorModel.bloodGroup.value,
      requiredUnits: _postFormValidatorModel.units.value,
      patientName: _postFormValidatorModel.patientName.value,
      purpose: _postFormValidatorModel.purpose.value,
      requirementType: _postFormValidatorModel.requirementType.value.toString().toLowerCase(),
    );
    FirebaseApi.uploadData("Post", null, _postDetails.toJson(update:  false));
  }

  void update(PostFormValidatorModel _postFormValidatorModel,String docId) {
    PostDetails _postDetails = PostDetails(
      active: true,
      bloodRequiredDateTime: _postFormValidatorModel.requiredDateTime.value,
      expired: false,
      bloodRequiredDateTimeFirst: _postFormValidatorModel.requiredDateTime.value,
      gender: _postFormValidatorModel.gender.value,
      hospitalAddr: _postFormValidatorModel.hospitalLocation.value.first,
      hospitalArea: _postFormValidatorModel.hospitalAreaName.value,
      hospitalCity: _postFormValidatorModel.hospitalCity.value,
      hospitalLocation: _postFormValidatorModel.hospitalLocation.value.last,
      hospitalName: _postFormValidatorModel.hospitalName.value,
      hospitalRoomNo: _postFormValidatorModel.hospitalRoomNo.value,
      otherDetails: _postFormValidatorModel.otherDetails.value,
      patientAge: _postFormValidatorModel.patientAge.value,
      patientAttenderContact1:
          _postFormValidatorModel.patientAttenderContact1.value,
      patientAttenderContact2:
          _postFormValidatorModel.patientAttenderContact2.value,
      patientAttenderContact3:
          _postFormValidatorModel.patientAttenderContact3.value,
      patientAttenderName1: _postFormValidatorModel.patientAttenderName1.value,
      patientAttenderName2: _postFormValidatorModel.patientAttenderName2.value,
      patientAttenderName3: _postFormValidatorModel.patientAttenderName3.value,
      requiredBloodGrp: _postFormValidatorModel.bloodGroup.value,
      requiredUnits: _postFormValidatorModel.units.value,
      patientName: _postFormValidatorModel.patientName.value,
      purpose: _postFormValidatorModel.purpose.value,
      requirementType: _postFormValidatorModel.requirementType.value.toString().toLowerCase(),
    );
    FirebaseApi.updateData(collection: "Post", doc: docId, data: _postDetails.toJson(update: true));
  }

  getStream() async {
    GeoFirePoint _center = _geoflutterfire.point(
        latitude: GpsLocation.lattidue!, longitude: GpsLocation.longnitude!);

    stream = filterRx.switchMap((filter) {
      var collectionReference = !allRequiremtType
          ? FirebaseApi.firestore
              .collection('Post')
              .where("active", isEqualTo: true)
              .where(
                "requirementType",
                isEqualTo: filter['type'],
              )
              .where("requiredBloodGrp", whereIn: filter['bloodGroups'])
          : FirebaseApi.firestore
              .collection('Post')
              .where("active", isEqualTo: true)
              .where("requiredBloodGrp", whereIn: filter['bloodGroups']);
      return _geoflutterfire
          .collection(collectionRef: collectionReference)
          .within(
              center: _center,
              radius: filter["radius"],
              field: 'hospitalLocation',
              strictMode: true);
    });
    getPosts();
  }

  void getPosts() async {
    stream!.listen((List<DocumentSnapshot> documentList) {
      print("change in filter");
      print(filters);
      print("called");
      _postList.clear();
      print("length");
      print(documentList.length);
      List<DocumentSnapshot> _lists = documentList;
      //remove if already donated
      // _lists.removeWhere((element) {
      //   List<dynamic> donors = element.data()["donors"];
      //   if (donors != null) {
      //     if (donors.contains(FirebaseAuth.instance.currentUser.uid)) {
      //       return true;
      //     }
      //   }
      //   return false;
      // });
      //sorting
      // _lists.sort((a, b) {
      //   Timestamp aStamp = a.data()["bloodRequiredDateTime"];
      //   Timestamp bStamp = b.data()["bloodRequiredDateTime"];
      //   if (aStamp.millisecondsSinceEpoch > bStamp.millisecondsSinceEpoch) {
      //     return 1;
      //   }
      //   return 0;
      // });

      _lists.forEach((element) {
        _postList.add(PostDetails.fromJson(
            element.id, element.data() as Map<String, dynamic>));
      });
      notifyListeners();
    });

    // print("Inside getPostsList");
    // List finalListofPosts = [];
    // DataSnapshot snap;
    // var postsList = [];
    // try {
    //   snap = await databaseReference.child("Post").once();
    //   bloodGrpList.add("Any");
    //   print(snap.value);
    //   if (snap != null && snap.value != null) {
    //     for (var key in (snap.value as Map).keys) {
    //       if (bloodGrpList.contains(snap.value[key]["requiredBloodGrp"]) &&
    //           snap.value[key]["status"] == true) {
    //         postsList.add(snap.value[key]);
    //       }
    //     }
    //     print("1::");
    //     for (var j = 0; j < acceptedRequestArray.length; j++) {
    //       for (var k = 0; k < postsList.length; k++) {
    //         if (postsList[k]["postId"] == acceptedRequestArray[j]) {
    //           postsList[k]["myPost"] = "No";
    //           postsList.removeAt(k);
    //         }
    //       }
    //     }
    //     print("2::");
    //     for (var j = 0; j < myRequestArray.length; j++) {
    //       for (var k = 0; k < postsList.length; k++) {
    //         if (postsList[k]["postId"] == myRequestArray[j]) {
    //           postsList[k]["myPost"] = "Yes";
    //         }
    //       }
    //     }
    //     // for(var g = 0; g < postsList.length; g++){
    //     //   if(postsList[g]["status"] == true){
    //     //     finalListofPosts.add(postsList[g]);
    //     //   }
    //     // }
    //     print("3::");
    //     for (var x = 0; x < postsList.length; x++) {
    //       if (dateArray.contains(_commonUtilFunctions
    //           .convertDateTimeDisplay(postsList[x]["bloodRequiredDate"]))) {
    //         finalListofPosts.add(postsList[x]);
    //       }
    //     }
    //     finalListofPosts.sort((a, b) {
    //       return a["bloodRequiredDate"].compareTo(b["bloodRequiredDate"]);
    //     });
    //     print("Total relevant posts: ${finalListofPosts.length}");

    //     setState(() {
    //       snapshot = snap;
    //       this.postsList = finalListofPosts;
    //       loaded = true;
    //     });
    //   }
    //   // return postsList;
    // } catch (e) {
    //   print(e);
    //   setState(() {
    //     loaded = true;
    //   });
    //   // return [];
    // }
  }

  void changeFilter(String grp, double _radius, String _type) {
    changeBloodGrp(grp);
    changeRadius(_radius);
    changeRequirementType(_type);
    filterRx.add(filters);
    notifyListeners();
  }

  void changeBloodGrp(String grp) {
    if (grp == 'Any') {
      any = true;
      filters["bloodGroups"] = [
        'A-',
        'B-',
        'O-',
        'AB-',
        'A+',
        'B+',
        'O+',
        'AB+'
      ];
    } else {
      any = false;
      filters["bloodGroups"] = BloodGrp.canGive[grp]!;
    }
  }

  void changeRadius(double _radius) {
    radius = _radius;
    filters["radius"] = radius;
  }

  void changeRequirementType(String _type) {
    if (_type == "All") {
      allRequiremtType = true;
      reuirementType = "";
    } else {
      allRequiremtType = false;
      reuirementType = _type;
    }
    filters['type'] = reuirementType.toLowerCase();
  }
}
