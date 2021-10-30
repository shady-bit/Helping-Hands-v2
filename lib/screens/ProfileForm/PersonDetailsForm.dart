import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/constants/customInputDecoration.dart';
import 'package:helpinghandsversion2/constants/gender.dart';
import 'package:helpinghandsversion2/constants/lastPlasmaDonated.dart';
import 'package:helpinghandsversion2/constants/lastPlateletsDonated.dart';
import 'package:helpinghandsversion2/notifiers/profileFormValidator.dart';
import 'package:helpinghandsversion2/notifiers/time.dart';
import 'package:helpinghandsversion2/widgets/bloodGroupSelector.dart';
import 'package:helpinghandsversion2/widgets/buildDropDown.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BuildPersonalFormDetails extends StatefulWidget {
  const BuildPersonalFormDetails({
    Key? key,
  }) : super(key: key);

  @override
  _BuildPersonalFormDetailsState createState() =>
      _BuildPersonalFormDetailsState();
}

class _BuildPersonalFormDetailsState extends State<BuildPersonalFormDetails> {
  late ProfileFormProvider _profileFormProvider;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _dateOfBirthController = new TextEditingController();
  TextEditingController _bloodGroupController = new TextEditingController();
  TextEditingController _emergency1Controller = new TextEditingController();
  TextEditingController _emergency2Controller = new TextEditingController();
  bool expandedGenderList = false;

  @override
  Widget build(BuildContext context) {
    _profileFormProvider = Provider.of<ProfileFormProvider>(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.fromLTRB(7.w, 13.h, 7.w, 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Details",
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans"),
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              buildFullNameField(),
              SizedBox(
                height: 18.h,
              ),
              buildDateOfBirth(),
              SizedBox(
                height: 18.h,
              ),
              buildBloodGroup(),
              SizedBox(
                height: 18.h,
              ),
              buildEmergencyContact1(),
              SizedBox(
                height: 18.h,
              ),
              buildEmergencyContact2(),
              SizedBox(
                height: 18.h,
              ),
              buildPatientGender(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBloodGroup() {
    return GestureDetector(
      onTap: () async {
        String? selectedBloodGroup = await showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17))),
            context: context,
            builder: (context) {
              return BloodGroupSelector(
                  selectedGroup: _profileFormProvider
                      .profileFormValidatorModel.bloodGroup.value);
            });
        _profileFormProvider.validateBloodGroup(selectedBloodGroup);
        if (selectedBloodGroup != null) {
          _bloodGroupController.text = selectedBloodGroup;
        }
      },
      child: TextFormField(
        enabled: false,
        controller: _bloodGroupController,
        decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Your blood group*",
          errorText:
              _profileFormProvider.profileFormValidatorModel.bloodGroup.error,
        ),
        readOnly: true,
      ),
    );
  }

  Widget buildFullNameField() {
    return TextFormField(
      maxLength: 25,
      controller: _nameController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Full Name*",
          errorText: _profileFormProvider.profileFormValidatorModel.name.error),
      onChanged: (val) {
        _profileFormProvider.validateName(val: val);
      },
    );
  }

  Widget buildDateOfBirth() {
    return Consumer<DateTime>(builder: (context, DateTime time, child) {
      return GestureDetector(
        onTap: () async {
          DateTime? _dateOfBirth = await showDatePicker(
            errorInvalidText: "Minimum age should be 18 years.",
            context: context,
            locale: Locale("en", "IN"),
            fieldHintText: "DD/MM/YYYY",
            helpText: "SELECT DATE OF BIRTH",
            initialDate: _profileFormProvider
                    .profileFormValidatorModel.dateOfBirth.value ??
                DateTime(time.year - 18, time.month, time.day),
            firstDate: DateTime(1900, 1),
            lastDate: DateTime(time.year - 18, time.month, time.day),
          );
          _profileFormProvider.validateDateOfBirth(_dateOfBirth);
          if (_dateOfBirth != null) {
            _dateOfBirthController.text =
                DateFormat('dd MMM yyyy').format(_dateOfBirth);
          }
        },
        child: TextFormField(
          controller: _dateOfBirthController,
          enabled: false,
          decoration: CustomInputDecoration.buildInputDecoration(
              labelText: "Date of Birth*",
              errorText: _profileFormProvider
                  .profileFormValidatorModel.dateOfBirth.error),
        ),
      );
    });
  }

  Widget buildEmergencyContact1() {
    return TextFormField(
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      controller: _emergency1Controller,
      decoration: CustomInputDecoration.buildInputDecoration(
        labelText: "Emergency Contact 1*",
        errorText: _profileFormProvider
            .profileFormValidatorModel.emergencyContact1.error,
      ),
      onChanged: (val) {
        _profileFormProvider.validateEmergencyContact1(val);
      },
    );
  }

  Widget buildEmergencyContact2() {
    return TextFormField(
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Emergency Contact 2",
          errorText: _profileFormProvider
              .profileFormValidatorModel.emergecyContact2.error),
      onChanged: (val) {
        _profileFormProvider.validateEmergencyContact2(val);
      },
      controller: _emergency2Controller,
    );
  }

  Widget buildPatientGender() {
    return BuildDropDown(
      title: "Gender*",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                expandedGenderList = !expandedGenderList;
              });
            },
            children: [
              ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: _profileFormProvider
                                  .profileFormValidatorModel.gender.value !=
                              null
                          ? Text(
                              _profileFormProvider
                                  .profileFormValidatorModel.gender.value,
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              "Gender*",
                              style: TextStyle(color: CustomColors.grey),
                            ),
                    );
                  },
                  body: Column(
                    children: [
                      _profileFormProvider
                                  .profileFormValidatorModel.gender.value !=
                              Gender.male
                          ? ListTile(
                              title: Text(Gender.male),
                              onTap: () async {
                                expandedGenderList = !expandedGenderList;
                                _profileFormProvider
                                    .validateGender(Gender.male);
                              },
                            )
                          : Container(),
                      _profileFormProvider
                                  .profileFormValidatorModel.gender.value !=
                              Gender.female
                          ? ListTile(
                              title: Text(Gender.female),
                              onTap: () {
                                expandedGenderList = !expandedGenderList;
                                _profileFormProvider
                                    .validateGender(Gender.female);
                              },
                            )
                          : Container(),
                    ],
                  ),
                  isExpanded: expandedGenderList),
            ],
          ),
          _profileFormProvider.profileFormValidatorModel.gender.error != null
              ? Padding(
                  padding: EdgeInsets.only(left: 15.h, top: 10.h),
                  child: Text(
                    _profileFormProvider
                        .profileFormValidatorModel.gender.error!,
                    style: TextStyle(color: CustomColors.red, fontSize: 17.sp),
                    textAlign: TextAlign.start,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
