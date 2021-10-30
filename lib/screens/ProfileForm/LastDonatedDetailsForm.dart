import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/constants/customString.dart';
import 'package:helpinghandsversion2/constants/lastDonatedBlood.dart';
import 'package:helpinghandsversion2/constants/lastPlasmaDonated.dart';
import 'package:helpinghandsversion2/constants/lastPlateletsDonated.dart';
import 'package:helpinghandsversion2/notifiers/profileFormValidator.dart';
import 'package:helpinghandsversion2/widgets/buildDropDown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LastDonatedFormDetails extends StatefulWidget {
  @override
  _LastDonatedFormDetailsState createState() => _LastDonatedFormDetailsState();
}

class _LastDonatedFormDetailsState extends State<LastDonatedFormDetails> {
  bool lastBloodDonatedExpaned = false;
  bool lastPlasmaDonatedExpaned = false;
  bool lastPlateletsDonatedExpaned = false;
  late ProfileFormProvider _profileFormProvider;

  @override
  Widget build(BuildContext context) {
    _profileFormProvider = Provider.of<ProfileFormProvider>(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.fromLTRB(7.w, 13.h, 7.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Donated Details",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans"),
            ),
            Text(
              "*You will not be able to change last donated details later.",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: CustomColors.grey,
                  fontWeight: FontWeight.w400
                  // fontStyle: FontStyle.italic
                  ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Divider(),
            SizedBox(
              height: 7.h,
            ),
            BuildDropDown(
                title: "Select Last blood Donated*",
                child: buildLastBloodDonation()),
            SizedBox(
              height: 15.h,
            ),
            BuildDropDown(
                title: "Select Last plasma Donated*",
                child: buildLastPlasmaDonation()),
            SizedBox(
              height: 15.h,
            ),
            BuildDropDown(
                title: "Select Last platelets Donated*",
                child: buildLastPlateletsDonation()),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLastBloodDonation() {
    return Consumer<DateTime>(builder: (context, time, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                lastBloodDonatedExpaned = !lastBloodDonatedExpaned;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    dense: true,
                    title: _profileFormProvider.profileFormValidatorModel
                                .lastBloodDonated.value !=
                            null
                        ? Text(_profileFormProvider.profileFormValidatorModel
                                    .lastBloodDonated.value.runtimeType ==
                                DateTime
                            ? DateFormat('dd MMM yyyy').format(
                                _profileFormProvider.profileFormValidatorModel
                                    .lastBloodDonated.value)
                            : _profileFormProvider.profileFormValidatorModel
                                .lastBloodDonated.value)
                        : Text(
                            "Select",
                            style: TextStyle(color: CustomColors.grey),
                          ),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                      title: Text(LastDonatedBlood.pickText),
                      subtitle: Text(LastDonatedBlood.subPickText),
                      onTap: () async {
                        DateTime? _selectedDate = await showDatePicker(
                          errorInvalidText: "error",
                          context: context,
                          initialDate: _profileFormProvider
                                      .profileFormValidatorModel
                                      .lastBloodDonated
                                      .value
                                      .runtimeType ==
                                  DateTime
                              ? _profileFormProvider.profileFormValidatorModel
                                  .lastBloodDonated.value
                              : time,
                          firstDate: DateTime(1900, 1),
                          lastDate: time,
                          locale: Locale("en", "IN"),
                          fieldHintText: "dd/mm/yyyy",
                          helpText: "SELECT LAST BLOOD DONATION DATE",
                        );

                        if (_selectedDate != null) {
                          lastBloodDonatedExpaned = !lastBloodDonatedExpaned;
                          _profileFormProvider
                              .validateLastBloodDonated(_selectedDate);
                        } else {
                          setState(() {
                            lastBloodDonatedExpaned = !lastBloodDonatedExpaned;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text(LastDonatedBlood.notDonatedText),
                      subtitle: Text(LastDonatedBlood.subNotDonatedText),
                      onTap: () {
                        lastBloodDonatedExpaned = !lastBloodDonatedExpaned;
                        _profileFormProvider.validateLastBloodDonated(
                            CustomString.iHaveNotDonated);
                      },
                    ),
                  ],
                ),
                isExpanded: lastBloodDonatedExpaned,
              ),
            ],
          ),
          _profileFormProvider
                      .profileFormValidatorModel.lastBloodDonated.error !=
                  null
              ? Padding(
                  padding: EdgeInsets.only(left: 15.h, top: 10.h),
                  child: Text(
                    _profileFormProvider
                        .profileFormValidatorModel.lastBloodDonated.error!,
                    style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                    textAlign: TextAlign.start,
                  ))
              : Container(),
        ],
      );
    });
  }

  Widget buildLastPlasmaDonation() {
    return Consumer<DateTime>(builder: (context, time, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                lastPlasmaDonatedExpaned = !lastPlasmaDonatedExpaned;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    dense: true,
                    title: _profileFormProvider.profileFormValidatorModel
                                .lastPlasmaDonated.value !=
                            null
                        ? Text(_profileFormProvider.profileFormValidatorModel
                                    .lastPlasmaDonated.value.runtimeType ==
                                DateTime
                            ? DateFormat('dd MMM yyyy').format(
                                _profileFormProvider.profileFormValidatorModel
                                    .lastPlasmaDonated.value)
                            : _profileFormProvider.profileFormValidatorModel
                                .lastPlasmaDonated.value)
                        : Text(
                            "Select",
                            style: TextStyle(color: CustomColors.grey),
                          ),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                      title: Text(LastDonatedPlasma.pickText),
                      subtitle: Text(LastDonatedPlasma.subPickText),
                      onTap: () async {
                        DateTime? _selectedDate = await showDatePicker(
                          errorInvalidText: "error",
                          context: context,
                          initialDate: _profileFormProvider
                                      .profileFormValidatorModel
                                      .lastPlasmaDonated
                                      .value
                                      .runtimeType ==
                                  DateTime
                              ? _profileFormProvider.profileFormValidatorModel
                                  .lastPlasmaDonated.value
                              : time,
                          firstDate: DateTime(1900, 1),
                          lastDate: time,
                          locale: Locale("en", "IN"),
                          fieldHintText: "dd/mm/yyyy",
                          helpText: "SELECT LAST PLASMA DONATION DATE",
                        );

                        if (_selectedDate != null) {
                          lastPlasmaDonatedExpaned = !lastPlasmaDonatedExpaned;
                          _profileFormProvider
                              .validateLastPlasmaDonated(_selectedDate);
                        } else {
                          setState(() {
                            lastPlasmaDonatedExpaned =
                                !lastPlasmaDonatedExpaned;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text(CustomString.iHaveNotDonated),
                      subtitle: Text(LastDonatedPlasma.subNotDonatedText),
                      onTap: () {
                        lastPlasmaDonatedExpaned = !lastPlasmaDonatedExpaned;
                        _profileFormProvider.validateLastPlasmaDonated(
                            CustomString.iHaveNotDonated);
                      },
                    ),
                  ],
                ),
                isExpanded: lastPlasmaDonatedExpaned,
              ),
            ],
          ),
          _profileFormProvider
                      .profileFormValidatorModel.lastPlasmaDonated.error !=
                  null
              ? Padding(
                  padding: EdgeInsets.only(left: 15.h, top: 10.h),
                  child: Text(
                    _profileFormProvider
                        .profileFormValidatorModel.lastPlasmaDonated.error!,
                    style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                    textAlign: TextAlign.start,
                  ))
              : Container(),
        ],
      );
    });
  }

  Widget buildLastPlateletsDonation() {
    return Consumer<DateTime>(builder: (context, time, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                lastPlateletsDonatedExpaned = !lastPlateletsDonatedExpaned;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    dense: true,
                    title: _profileFormProvider.profileFormValidatorModel
                                .lastPlateletsDonated.value !=
                            null
                        ? Text(_profileFormProvider.profileFormValidatorModel
                                    .lastPlateletsDonated.value.runtimeType ==
                                DateTime
                            ? DateFormat('dd MMM yyyy').format(
                                _profileFormProvider.profileFormValidatorModel
                                    .lastPlateletsDonated.value)
                            : _profileFormProvider.profileFormValidatorModel
                                .lastPlateletsDonated.value)
                        : Text(
                            "Select",
                            style: TextStyle(color: CustomColors.grey),
                          ),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                      title: Text(LastDonatedPlatelets.pickText),
                      subtitle: Text(LastDonatedPlatelets.subPickText),
                      onTap: () async {
                        DateTime? _selectedDate = await showDatePicker(
                          errorInvalidText: "error",
                          context: context,
                          initialDate: _profileFormProvider
                                      .profileFormValidatorModel
                                      .lastPlateletsDonated
                                      .value
                                      .runtimeType ==
                                  DateTime
                              ? _profileFormProvider.profileFormValidatorModel
                                  .lastPlateletsDonated.value
                              : time,
                          firstDate: DateTime(1900, 1),
                          lastDate: time,
                          locale: Locale("en", "IN"),
                          fieldHintText: "dd/mm/yyyy",
                          helpText: "SELECT LAST PLATELETS DONATION DATE",
                        );

                        if (_selectedDate != null) {
                          lastPlateletsDonatedExpaned =
                              !lastPlateletsDonatedExpaned;
                          _profileFormProvider
                              .validateLastPlateletsDonated(_selectedDate);
                        } else {
                          setState(() {
                            lastPlateletsDonatedExpaned =
                                !lastPlateletsDonatedExpaned;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text(CustomString.iHaveNotDonated),
                      subtitle: Text(LastDonatedPlatelets.subNotDonatedText),
                      onTap: () {
                        lastPlateletsDonatedExpaned =
                            !lastPlateletsDonatedExpaned;
                        _profileFormProvider.validateLastPlateletsDonated(
                            CustomString.iHaveNotDonated);
                      },
                    ),
                  ],
                ),
                isExpanded: lastPlateletsDonatedExpaned,
              ),
            ],
          ),
          _profileFormProvider
                      .profileFormValidatorModel.lastPlateletsDonated.error !=
                  null
              ? Padding(
                  padding: EdgeInsets.only(left: 15.h, top: 10.h),
                  child: Text(
                    _profileFormProvider
                        .profileFormValidatorModel.lastPlateletsDonated.error!,
                    style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                    textAlign: TextAlign.start,
                  ))
              : Container(),
        ],
      );
    });
  }
}
