import 'dart:io';
import 'package:helpinghandsversion2/model/validationModel.dart';

class PostFormValidatorModel {
  ValidationModel _active = ValidationModel();
  ValidationModel _requirementType = ValidationModel();
  ValidationModel _bloodGroup = ValidationModel();
  ValidationModel _units = ValidationModel();
  ValidationModel _requiredDateTime = ValidationModel();
  ValidationModel _purpose = ValidationModel();
  ValidationModel _patientName = ValidationModel();
  ValidationModel _patientAge = ValidationModel();
  ValidationModel _gender = ValidationModel();
  ValidationModel _patientAttenderName1 = ValidationModel();
  ValidationModel _patientAttenderContact1 = ValidationModel();
  ValidationModel _patientAttenderName2 = ValidationModel();
  ValidationModel _patientAttenderContact2 = ValidationModel();
  ValidationModel _patientAttenderName3 = ValidationModel();
  ValidationModel _patientAttenderContact3 = ValidationModel();
  ValidationModel _hospitalLocation = ValidationModel();
  ValidationModel _hospitalName = ValidationModel();
  ValidationModel _hospitalCity = ValidationModel();
  ValidationModel _hospitalAreaName = ValidationModel();
  ValidationModel _hospitalRoomNo = ValidationModel();
  ValidationModel _otherDetails = ValidationModel();

  ValidationModel get active => _active;
  ValidationModel get requirementType => _requirementType;
  ValidationModel get bloodGroup => _bloodGroup;
  ValidationModel get units => _units;
  ValidationModel get requiredDateTime => _requiredDateTime;
  ValidationModel get purpose => _purpose;

  ValidationModel get patientName => _patientName;
  ValidationModel get patientAge => _patientAge;
  ValidationModel get gender => _gender;

  ValidationModel get patientAttenderName1 => _patientAttenderName1;
  ValidationModel get patientAttenderContact1 => _patientAttenderContact1;
  ValidationModel get patientAttenderName2 => _patientAttenderName2;
  ValidationModel get patientAttenderContact2 => _patientAttenderContact2;
  ValidationModel get patientAttenderName3 => _patientAttenderName3;
  ValidationModel get patientAttenderContact3 => _patientAttenderContact3;


  ValidationModel get hospitalLocation => _hospitalLocation;
  ValidationModel get hospitalName => _hospitalName;
  ValidationModel get hospitalCity => _hospitalCity;
  ValidationModel get hospitalAreaName => _hospitalAreaName;
  ValidationModel get hospitalRoomNo => _hospitalRoomNo;
  ValidationModel get otherDetails => _otherDetails;

  


  set setActive(ValidationModel temp) {
    _active = temp;
  }

  set setRequirementType(ValidationModel temp) {
    _requirementType = temp;
  }

  set setBloodGroup(ValidationModel temp) {
    _bloodGroup = temp;
  }

  set setUnits(ValidationModel temp) {
    _units = temp;
  }

  set setRequiredDateTime(ValidationModel temp) {
    _requiredDateTime = temp;
  }

  set setPurpose(ValidationModel temp) {
    _purpose = temp;
  }

  set setPatientName(ValidationModel temp) {
    _patientName = temp;
  }

  set setPatientAge(ValidationModel temp) {
    _patientAge = temp;
  }

  set setGender(ValidationModel temp) {
    _gender = temp;
  }

  set setPatientAttenderName1(ValidationModel temp) {
    _patientAttenderName1 = temp;
  }

  set setPatientAttenderContact1(ValidationModel temp) {
    _patientAttenderContact1 = temp;
  }

  set setPatientAttenderName2(ValidationModel temp) {
    _patientAttenderName2 = temp;
  }

  set setPatientAttenderContact2(ValidationModel temp) {
    _patientAttenderContact2 = temp;
  }


  set setPatientAttenderName3(ValidationModel temp) {
    _patientAttenderName3 = temp;
  }

  set setPatientAttenderContact3(ValidationModel temp) {
    _patientAttenderContact3 = temp;
  }

  set setHospitalLocation(ValidationModel temp) {
    _hospitalLocation = temp;
  }

  set setHospitalName(ValidationModel temp) {
    _hospitalName = temp;
  }

   set setHospitalCity(ValidationModel temp) {
    _hospitalCity = temp;
  }

  set setHospitalAreaName(ValidationModel temp) {
    _hospitalAreaName = temp;
  }

   set setHospitalRoomNo(ValidationModel temp) {
    _hospitalRoomNo = temp;
  }

   set setOtherDetails(ValidationModel temp) {
    _otherDetails = temp;
  }
}
