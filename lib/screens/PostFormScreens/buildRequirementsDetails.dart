import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpinghandsversion2/constants/customInputDecoration.dart';
import 'package:helpinghandsversion2/model/postDetails.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:helpinghandsversion2/widgets/bloodGroupSelector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BuildRequirementDetails extends StatefulWidget {
  PostDetails? details;
  BuildRequirementDetails(this.details);

  @override
  _BuildRequirementDetailsState createState() =>
      _BuildRequirementDetailsState();
}

class _BuildRequirementDetailsState extends State<BuildRequirementDetails> {
  TextEditingController _bloodGroupController = new TextEditingController();
  TextEditingController _requiredUnitsController = new TextEditingController();
  TextEditingController _requiredDateAndTimeController =
      new TextEditingController();
  TextEditingController _purposeController = new TextEditingController();
  late PostFormProvider _postFormProvider;

  @override
  void initState() {
    if (widget.details != null) {
      _bloodGroupController.text = widget.details!.requiredBloodGrp;
      context
          .read<PostFormProvider>()
          .validateBloodGroup(_bloodGroupController.text, notify: false);
      _requiredUnitsController.text = widget.details!.requiredUnits;
      context
          .read<PostFormProvider>()
          .validateUnits(_requiredUnitsController.text, notify: false);

      _requiredDateAndTimeController.text = DateFormat('dd MMM yyyy')
          .format(widget.details!.bloodRequiredDateTime);

      context.read<PostFormProvider>().validateRequiredDateTime(
          widget.details!.bloodRequiredDateTime,
          notify: false);

      _purposeController.text = widget.details!.purpose;
      context
          .read<PostFormProvider>()
          .validatePurpose(_purposeController.text, notify: false);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postFormProvider = Provider.of<PostFormProvider>(context);
    return Column(
      children: [
        buildBloodGroup(),
        SizedBox(
          height: 10.h,
        ),
        buildRequiredUnits(),
        SizedBox(
          height: 10.h,
        ),
        buildRequiredDateAndTime(),
        SizedBox(
          height: 10.h,
        ),
        purpose(),
      ],
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
                  selectedGroup: _postFormProvider
                      .postFormValidatorModel.bloodGroup.value);
            });
        _postFormProvider.validateBloodGroup(selectedBloodGroup);
        if (selectedBloodGroup != null) {
          _bloodGroupController.text = selectedBloodGroup;
        }
      },
      child: TextFormField(
        enabled: false,
        controller: _bloodGroupController,
        decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Your blood group*",
          errorText: _postFormProvider.postFormValidatorModel.bloodGroup.error,
        ),
        readOnly: true,
      ),
    );
  }

  Widget buildRequiredUnits() {
    return TextFormField(
      maxLength: 25,
      controller: _requiredUnitsController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Required Units*",
          errorText: _postFormProvider.postFormValidatorModel.units.error),
      onChanged: (val) {
        _postFormProvider.validateUnits(val);
      },
    );
  }

  Widget buildRequiredDateAndTime() {
    return Consumer<DateTime>(builder: (context, DateTime time, child) {
      return GestureDetector(
        onTap: () async {
          DateTime? _requiredDateAndTime = await showDatePicker(
            errorInvalidText: "Minimum age should be 18 years.",
            context: context,
            locale: Locale("en", "IN"),
            fieldHintText: "DD/MM/YYYY",
            helpText: "SELECT REQUIRED DATE & TIME",
            initialDate:
                // _postFormProvider
                //         .postFormValidatorModel.requiredDateTime.value ??
                DateTime(time.year, time.month, time.day),
            firstDate: DateTime(time.year, time.month, time.day),
            lastDate: DateTime(2030),
          );
          _postFormProvider.validateRequiredDateTime(_requiredDateAndTime);
          if (_requiredDateAndTime != null) {
            _requiredDateAndTimeController.text =
                DateFormat('dd MMM yyyy').format(_requiredDateAndTime);
          }
        },
        child: TextFormField(
          controller: _requiredDateAndTimeController,
          enabled: false,
          decoration: CustomInputDecoration.buildInputDecoration(
              labelText: "Required Date & Time*",
              errorText: _postFormProvider
                  .postFormValidatorModel.requiredDateTime.error),
        ),
      );
    });
  }

  Widget purpose() {
    return TextFormField(
      maxLength: 25,
      controller: _purposeController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: CustomInputDecoration.buildInputDecoration(
          labelText: "Purpose*",
          errorText: _postFormProvider.postFormValidatorModel.purpose.error),
      onChanged: (val) {
        _postFormProvider.validatePurpose(val);
      },
    );
  }
}
