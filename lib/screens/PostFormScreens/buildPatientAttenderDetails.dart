import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpinghandsversion2/constants/customInputDecoration.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class BuildPatientAttenderDetails extends StatefulWidget {
  PostDetails? details;
  BuildPatientAttenderDetails(this.details);
  @override
  _BuildPatientAttenderDetailsState createState() =>
      _BuildPatientAttenderDetailsState();
}

class _BuildPatientAttenderDetailsState
    extends State<BuildPatientAttenderDetails> {
  late PostFormProvider _postFormProvider;
  TextEditingController _patientAttenderName1Controller =
      new TextEditingController();
  TextEditingController _patientAttenderName2Controller =
      new TextEditingController();
  TextEditingController _patientAttenderName3Controller =
      new TextEditingController();
  TextEditingController _patientAttenderContact1Controller =
      new TextEditingController();
  TextEditingController _patientAttenderContact2Controller =
      new TextEditingController();
  TextEditingController _patientAttenderContact3Controller =
      new TextEditingController();

  @override
  void initState() {
    if (widget.details != null) {
      _patientAttenderName1Controller.text =
          widget.details!.patientAttenderName1;
      context.read<PostFormProvider>().validatePatientAttenderName1(
          _patientAttenderName1Controller.text,
          notify: false);

      _patientAttenderContact1Controller.text =
          widget.details!.patientAttenderContact1;
      context.read<PostFormProvider>().validatePatientAttenderContact1(
          _patientAttenderContact1Controller.text,
          notify: false);    

          _patientAttenderName2Controller.text =
          widget.details!.patientAttenderName2 ?? "";
      context.read<PostFormProvider>().validatePatientAttenderName2(
          _patientAttenderName2Controller.text,
          notify: false);

      _patientAttenderContact2Controller.text =
          widget.details!.patientAttenderContact2 ?? "";
      context.read<PostFormProvider>().validatePatientAttenderContact2(
          _patientAttenderContact2Controller.text,
          notify: false);   


          _patientAttenderName3Controller.text =
          widget.details!.patientAttenderName3 ?? "";
      context.read<PostFormProvider>().validatePatientAttenderName3(
          _patientAttenderName3Controller.text,
          notify: false);

      _patientAttenderContact3Controller.text =
          widget.details!.patientAttenderContact3 ?? "";
      context.read<PostFormProvider>().validatePatientAttenderContact3(
          _patientAttenderContact3Controller.text,
          notify: false);   
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postFormProvider = Provider.of<PostFormProvider>(context);

    return Column(
      children: [
        buildPatientAttenderName(
            controller: _patientAttenderName1Controller,
            validator: _postFormProvider.validatePatientAttenderName1,
            labelText: "Patient Attender Name 1 *",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderName1.error),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAttenderContact(
            controller: _patientAttenderContact1Controller,
            validator: _postFormProvider.validatePatientAttenderContact1,
            labelText: "Patient Attender Contact 1*",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderContact1.error),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAttenderName(
            controller: _patientAttenderName2Controller,
            validator: _postFormProvider.validatePatientAttenderName2,
            labelText: "Patient Attender Name 2",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderName2.error),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAttenderContact(
            controller: _patientAttenderContact2Controller,
            validator: _postFormProvider.validatePatientAttenderContact2,
            labelText: "Patient Attender Contact 2",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderContact2.error),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAttenderName(
            controller: _patientAttenderName3Controller,
            validator: _postFormProvider.validatePatientAttenderName3,
            labelText: "Patient Attender Name 3",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderName3.error),
        SizedBox(
          height: 10.h,
        ),
        buildPatientAttenderContact(
            controller: _patientAttenderContact3Controller,
            validator: _postFormProvider.validatePatientAttenderContact3,
            labelText: "Patient Attender Contact 3",
            errorText: _postFormProvider
                .postFormValidatorModel.patientAttenderContact3.error)
      ],
    );
  }

  Widget buildPatientAttenderName(
      {required TextEditingController controller,
      required Function validator,
      String? errorText,
      required String labelText}) {
    return TextFormField(
      maxLength: 25,
      controller: controller,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: labelText, errorText: errorText),
      onChanged: (val) {
        validator(val);
      },
    );
  }

  Widget buildPatientAttenderContact(
      {required TextEditingController controller,
      required Function validator,
      String? errorText,
      required String labelText}) {
    return TextFormField(
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      controller: controller,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: labelText, errorText: errorText),
      onChanged: (val) {
        validator(val);
      },
    );
  }
}
