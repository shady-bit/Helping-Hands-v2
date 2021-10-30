import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/constants/customInputDecoration.dart';
import 'package:helpinghandsversion2/constants/gender.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/widgets/buildDropDown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class BuildPatientDetails extends StatefulWidget {
  PostDetails? details;
  BuildPatientDetails(this.details);

  @override
  _BuildPatientDetailsState createState() => _BuildPatientDetailsState();
}

class _BuildPatientDetailsState extends State<BuildPatientDetails> {
  late PostFormProvider _postFormProvider;
  TextEditingController _patientNameController = new TextEditingController();
  TextEditingController _patientAgeController = new TextEditingController();
  bool genderExpanded = false;
  @override
  void initState() {
    if (widget.details != null) {
      _patientNameController.text = widget.details!.patientName;
      context
          .read<PostFormProvider>()
          .validatePatientName(_patientNameController.text, notify: false);
      _patientAgeController.text = widget.details!.patientAge;
       context
          .read<PostFormProvider>()
          .validatePatientAge(_patientAgeController.text, notify: false);
       context
          .read<PostFormProvider>()
          .validatePatientGender(widget.details!.gender, notify: false);    
          
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postFormProvider = Provider.of<PostFormProvider>(context);
    return Column(
      children: [
        buildPatientName(),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAge(),
        SizedBox(
          height: 10.h,
        ),
        BuildDropDown(title: "Gender", child: buildPatientGender()),
      ],
    );
  }

  Widget buildPatientName() {
    return TextFormField(
      maxLength: 25,
      controller: _patientNameController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Patient Name*",
          errorText:
              _postFormProvider.postFormValidatorModel.patientName.error),
      onChanged: (val) {
        _postFormProvider.validatePatientName(val);
      },
    );
  }

  Widget buildPatientAge() {
    return TextFormField(
      maxLength: 25,
      controller: _patientAgeController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Patient Age*",
          errorText: _postFormProvider.postFormValidatorModel.patientAge.error),
      onChanged: (val) {
        _postFormProvider.validatePatientAge(val);
      },
    );
  }

  Widget buildPatientGender() {
    return Consumer<DateTime>(builder: (context, time, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                genderExpanded = !genderExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    dense: true,
                    title:
                        _postFormProvider.postFormValidatorModel.gender.value !=
                                null
                            ? Text(_postFormProvider
                                .postFormValidatorModel.gender.value)
                            : Text(
                                "Select",
                                style: TextStyle(color: CustomColors.grey),
                              ),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                        title: Text(Gender.male),
                        onTap: () async {
                          genderExpanded = !genderExpanded;
                          _postFormProvider.validatePatientGender(Gender.male);
                        }),
                    ListTile(
                      title: Text(Gender.female),
                      onTap: () {
                        genderExpanded = !genderExpanded;
                        _postFormProvider.validatePatientGender(Gender.female);
                      },
                    ),
                  ],
                ),
                isExpanded: genderExpanded,
              ),
            ],
          ),
          _postFormProvider.postFormValidatorModel.gender.error != null
              ? Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    _postFormProvider.postFormValidatorModel.gender.error!,
                    style: TextStyle(color: CustomColors.red, fontSize: 35),
                    textAlign: TextAlign.start,
                  ))
              : Container(),
        ],
      );
    });
  }
}
