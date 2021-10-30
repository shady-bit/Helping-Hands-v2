import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/notifiers/profileFormValidator.dart';
import 'package:helpinghandsversion2/widgets/buildDropDown.dart';
import 'package:provider/provider.dart';

class DonationAvailabilty extends StatefulWidget {
  @override
  _DonationAvailabiltyState createState() => _DonationAvailabiltyState();
}

class _DonationAvailabiltyState extends State<DonationAvailabilty> {
  bool donateBloodExpand = false;
  bool donatePlasmaExpand = false;
  bool donatePlateletsExpand = false;
  late ProfileFormProvider _profileFormProvider;

  @override
  Widget build(BuildContext context) {
    _profileFormProvider = Provider.of<ProfileFormProvider>(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.fromLTRB(7.w, 13.h, 7.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Donation Availibility Details",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans"),
            ),
            Divider(),
            SizedBox(
              height: 15.h,
            ),
            BuildDropDown(
                title: "Would you like to donate blood? *",
                child: buildBloodDonationAvailabily()),
            SizedBox(
              height: 15.h,
            ),
            BuildDropDown(
                title: "Would you like donate plasma? *",
                child: buildPlasmaDonationAvailabily()),
            SizedBox(
              height: 15.h,
            ),
            BuildDropDown(
                title: "Would you like to donate Platelets? *",
                child: buildPlateletsDonationAvailabily()),
          ],
        ),
      ),
    );
  }

  Widget buildBloodDonationAvailabily() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionPanelList(
          elevation: 1,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              donateBloodExpand = !donateBloodExpand;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: _profileFormProvider
                              .profileFormValidatorModel.donateBlood.value !=
                          null
                      ? Text(_profileFormProvider
                              .profileFormValidatorModel.donateBlood.value
                          ? "Yes"
                          : "No")
                      : Text(
                          "Select",
                          style: TextStyle(color: CustomColors.grey),
                        ),
                );
              },
              body: Column(
                children: [
                  _profileFormProvider.profileFormValidatorModel.donateBlood
                                  .value ==
                              null ||
                          !_profileFormProvider
                              .profileFormValidatorModel.donateBlood.value
                      ? ListTile(
                          title: Text("Yes"),
                          onTap: () async {
                            donateBloodExpand = !donateBloodExpand;
                            _profileFormProvider.validateDonateBlood(true);
                          },
                        )
                      : Container(),
                  _profileFormProvider.profileFormValidatorModel.donateBlood
                                  .value ==
                              null ||
                          _profileFormProvider
                              .profileFormValidatorModel.donateBlood.value
                      ? ListTile(
                          title: Text("No"),
                          onTap: () {
                            donateBloodExpand = !donateBloodExpand;
                            _profileFormProvider.validateDonateBlood(false);
                          },
                        )
                      : Container(),
                ],
              ),
              isExpanded: donateBloodExpand,
            ),
          ],
        ),
        _profileFormProvider.profileFormValidatorModel.donateBlood.error != null
            ? Padding(
                padding: EdgeInsets.only(left: 15.h, top: 10.h),
                child: Text(
                  _profileFormProvider
                      .profileFormValidatorModel.donateBlood.error!,
                  style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                  textAlign: TextAlign.start,
                ))
            : Container(),
      ],
    );
  }

  Widget buildPlasmaDonationAvailabily() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionPanelList(
          elevation: 1,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              donatePlasmaExpand = !donatePlasmaExpand;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: _profileFormProvider
                              .profileFormValidatorModel.donatePlasma.value !=
                          null
                      ? Text(_profileFormProvider
                              .profileFormValidatorModel.donatePlasma.value
                          ? "Yes"
                          : "No")
                      : Text(
                          "Select",
                          style: TextStyle(color: CustomColors.grey),
                        ),
                );
              },
              body: Column(
                children: [
                  _profileFormProvider.profileFormValidatorModel.donatePlasma
                                  .value ==
                              null ||
                          !_profileFormProvider
                              .profileFormValidatorModel.donatePlasma.value
                      ? ListTile(
                          title: Text("Yes"),
                          onTap: () async {
                            donatePlasmaExpand = !donatePlasmaExpand;
                            _profileFormProvider.validateDonatePlasma(true);
                          },
                        )
                      : Container(),
                  _profileFormProvider.profileFormValidatorModel.donatePlasma
                                  .value ==
                              null ||
                          _profileFormProvider
                              .profileFormValidatorModel.donatePlasma.value
                      ? ListTile(
                          title: Text("No"),
                          onTap: () {
                            donatePlasmaExpand = !donatePlasmaExpand;
                            _profileFormProvider.validateDonatePlasma(false);
                          },
                        )
                      : Container(),
                ],
              ),
              isExpanded: donatePlasmaExpand,
            ),
          ],
        ),
        _profileFormProvider.profileFormValidatorModel.donatePlasma.error !=
                null
            ? Padding(
                padding: EdgeInsets.only(left: 15.h, top: 10.h),
                child: Text(
                  _profileFormProvider
                      .profileFormValidatorModel.donatePlasma.error!,
                  style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                  textAlign: TextAlign.start,
                ))
            : Container(),
      ],
    );
  }

  Widget buildPlateletsDonationAvailabily() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionPanelList(
          elevation: 1,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              donatePlateletsExpand = !donatePlateletsExpand;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: _profileFormProvider.profileFormValidatorModel
                              .donatePlatelets.value !=
                          null
                      ? Text(_profileFormProvider
                              .profileFormValidatorModel.donatePlatelets.value
                          ? "Yes"
                          : "No")
                      : Text(
                          "Select",
                          style: TextStyle(color: CustomColors.grey),
                        ),
                );
              },
              body: Column(
                children: [
                  _profileFormProvider.profileFormValidatorModel.donatePlatelets
                                  .value ==
                              null ||
                          !_profileFormProvider
                              .profileFormValidatorModel.donatePlatelets.value
                      ? ListTile(
                          title: Text("Yes"),
                          onTap: () async {
                            donatePlateletsExpand = !donatePlateletsExpand;
                            _profileFormProvider.validateDonatePlatelets(true);
                          },
                        )
                      : Container(),
                  _profileFormProvider.profileFormValidatorModel.donatePlatelets
                                  .value ==
                              null ||
                          _profileFormProvider
                              .profileFormValidatorModel.donatePlatelets.value
                      ? ListTile(
                          title: Text("No"),
                          onTap: () {
                            donatePlateletsExpand = !donatePlateletsExpand;
                            _profileFormProvider.validateDonatePlatelets(false);
                          },
                        )
                      : Container(),
                ],
              ),
              isExpanded: donatePlateletsExpand,
            ),
          ],
        ),
        _profileFormProvider.profileFormValidatorModel.donatePlatelets.error !=
                null
            ? Padding(
                padding: EdgeInsets.only(left: 15.h, top: 10.h),
                child: Text(
                  _profileFormProvider
                      .profileFormValidatorModel.donatePlatelets.error!,
                  style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                  textAlign: TextAlign.start,
                ))
            : Container(),
      ],
    );
  }
}
