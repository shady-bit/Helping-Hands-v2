import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpinghandsversion2/constants/customInputDecoration.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/screens/GoogleMapScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BuildHospitalLocation extends StatefulWidget {
  PostDetails? details;
  BuildHospitalLocation(this.details);

  @override
  _BuildHospitalLocationState createState() => _BuildHospitalLocationState();
}

class _BuildHospitalLocationState extends State<BuildHospitalLocation> {
  late PostFormProvider _postFormProvider;
  TextEditingController _hospitalLocationController =
      new TextEditingController();
  TextEditingController _hospitalNameController = new TextEditingController();

  TextEditingController _hospitalCityController = new TextEditingController();

  TextEditingController _hospitalAreaNameController =
      new TextEditingController();

  TextEditingController _hospitalRoomNoController = new TextEditingController();

  TextEditingController _hospitalOtherDetailsController =
      new TextEditingController();

  LatLng? l;

  @override
  void initState() {
    if (widget.details != null) {
      _hospitalLocationController.text = widget.details!.hospitalAddr;
      context.read<PostFormProvider>().validateHosptialLocation(
          widget.details!.hospitalAddr, widget.details!.hospitalLocation,
          notify: false);

      _hospitalNameController.text = widget.details!.hospitalName;
      context
          .read<PostFormProvider>()
          .validateHosptialName(_hospitalNameController.text, notify: false);

      _hospitalCityController.text = widget.details!.hospitalCity;
      context
          .read<PostFormProvider>()
          .validateHosptialCity(_hospitalCityController.text, notify: false);

      _hospitalAreaNameController.text = widget.details!.hospitalArea;
      context.read<PostFormProvider>().validateHosptialAreaName(
          _hospitalAreaNameController.text,
          notify: false);

      _hospitalRoomNoController.text = widget.details!.hospitalRoomNo;
      context.read<PostFormProvider>().validateHosptialRoomNo(
          _hospitalRoomNoController.text,
          notify: false);

      _hospitalOtherDetailsController.text = widget.details!.otherDetails ?? "";
      context.read<PostFormProvider>().validateOtherDetails(
          _hospitalOtherDetailsController.text,
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
        buildHospitalLocationField(),
        SizedBox(
          height: 10.h,
        ),
        buildCommonTextField(
            controller: _hospitalNameController,
            validator: _postFormProvider.validateHosptialName,
            labelText: "Hospital Name",
            errorText:
                _postFormProvider.postFormValidatorModel.hospitalName.error),
        SizedBox(
          height: 10.h,
        ),
        buildCommonTextField(
            controller: _hospitalCityController,
            validator: _postFormProvider.validateHosptialCity,
            labelText: "Hospital City",
            errorText:
                _postFormProvider.postFormValidatorModel.hospitalCity.error),
        SizedBox(
          height: 10.h,
        ),
        buildCommonTextField(
            controller: _hospitalAreaNameController,
            validator: _postFormProvider.validateHosptialAreaName,
            labelText: "Hospital Area Name",
            errorText: _postFormProvider
                .postFormValidatorModel.hospitalAreaName.error),
        SizedBox(
          height: 10.h,
        ),
        buildCommonTextField(
            controller: _hospitalRoomNoController,
            validator: _postFormProvider.validateHosptialRoomNo,
            labelText: "Hospital Room No",
            errorText:
                _postFormProvider.postFormValidatorModel.hospitalRoomNo.error),
        SizedBox(
          height: 10.h,
        ),
        buildCommonTextField(
            controller: _hospitalOtherDetailsController,
            validator: _postFormProvider.validateOtherDetails,
            labelText: "Other Details",
            errorText:
                _postFormProvider.postFormValidatorModel.otherDetails.error,
            maxLength: 100),
      ],
    );
  }

  Widget buildCommonTextField(
      {required TextEditingController controller,
      required Function validator,
      String? errorText,
      required String labelText,
      int maxLength = 25}) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: labelText, errorText: errorText),
      onChanged: (val) {
        validator(val);
      },
    );
  }

  Widget buildHospitalLocationField() {
    return GestureDetector(
      onTap: () async {
        final res = await Get.to(GoogleMapScreen(
            _postFormProvider.postFormValidatorModel.hospitalLocation.value ??
                null));
        if (res != null) {
          _hospitalLocationController.text = res[0];
          _postFormProvider.validateHosptialLocation(res[0], res[1]);
        }
      },
      child: TextFormField(
        enabled: false,
        controller: _hospitalLocationController,
        decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Hospital Location*",
          errorText:
              _postFormProvider.postFormValidatorModel.hospitalName.error,
        ),
        readOnly: true,
      ),
    );
  }
}
