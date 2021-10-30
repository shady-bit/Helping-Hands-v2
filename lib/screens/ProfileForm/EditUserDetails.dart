import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/UI/customButtonStyle.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/notifiers/profileFormValidator.dart';
import 'package:helpinghandsversion2/screens/ProfileForm/PersonDetailsForm.dart';
import 'package:helpinghandsversion2/screens/ProfileForm/donationAvailibilityForm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'LastDonatedDetailsForm.dart';

class ProfileForm extends StatefulWidget {
  String? displayName, email;
  File? url;
  ProfileForm({this.displayName, this.email, this.url});
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late ProfileFormProvider _profileFormProvider;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _profileFormProvider =
        Provider.of<ProfileFormProvider>(context, listen: false);
    if (widget.url != null) {
      _image = widget.url;
      if (_image != null) {
        _profileFormProvider.profileFormValidatorModel.setProfilePicFile =
            _image!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TO-DO Roshan
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              children: [
                buildPhotoCard(),
                SizedBox(
                  height: 20.h,
                ),
                BuildPersonalFormDetails(),
                SizedBox(
                  height: 20.h,
                ),
                LastDonatedFormDetails(),
                SizedBox(
                  height: 20.h,
                ),
                DonationAvailabilty(),
                SizedBox(
                  height: 20.h,
                ),
                SaveButton(),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SaveButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: CustomButtonStyle.buildButtonStyle(),
              onPressed: () async {
                _profileFormProvider.submit();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Text("Save",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildPhotoCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(),
        child: Padding(
            padding: EdgeInsets.fromLTRB(2.w, 10.h, 2.w, 0),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color(0xffC9D6FF),
                        Color(0xffE2E2E2),
                      ])),
                  // color: Colors.blue.shade200,
                  // padding: EdgeInsets.only(bottom: 30.h),
                  alignment: Alignment.center,
                  // height: widget.data != null ? 460.h : 580.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      buildPhoto(context),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // chooseSourceImage(context);
                      bottomSheetForImagePick();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 37.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("Edit")
                          ],
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _profileFormProvider.profileFormValidatorModel.setProfilePicFile =
            _image!;
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future getImageCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _profileFormProvider.profileFormValidatorModel.setProfilePicFile =
            _image!;
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future<Widget?> bottomSheetForImagePick() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(40.w, 20.h, 30.w, 0),
            height: MediaQuery.of(context).size.height * 0.33,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 10.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.lightGrey,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 38.h,
                      ),
                      Text(
                        "Change Profile Photo",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                          // fontFamily: "OpenSans"
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Column(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: getImageCamera,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      size: 35,
                                      color: Color(0xff596275),
                                    ),
                                    SizedBox(
                                      width: 20.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontSize: 27.sp,
                                          ),
                                        ),
                                        Text(
                                          "Quickly take a picture from camera.",
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: CustomColors.grey),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: getImageFromGallery,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 35,
                                      color: Color(0xff596275),
                                    ),
                                    SizedBox(
                                      width: 20.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                            fontSize: 27.sp,
                                          ),
                                        ),
                                        Text(
                                          "Pick a picture from gallery.",
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              color: CustomColors.grey),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildPhoto(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: CustomColors.grey,
              blurRadius: 10.0,
              offset: Offset(0, 0),
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        child:
            // _image == null  ? CachedNetworkImage(
            //       fit: BoxFit.fill,
            //       useOldImageOnUrlChange: true,
            //       imageUrl: widget.url,
            //       progressIndicatorBuilder: (context, url, _) {
            //         return CircularProfileAvatar(
            //           widget.data["profilePic"],
            //           backgroundColor: Colors.white,
            //           child: Shimmer.fromColors(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(42),
            //                     color: Colors.white),
            //               ),
            //               baseColor: CustomColors.grey,
            //               highlightColor: CustomColors.lightGrey),
            //         );
            //       },
            //     ) :
            Image.file(
          _image!,
          fit: BoxFit.cover,
          height: 110,
        ),
      ),
    );
  }
}
