import 'dart:io';

import 'package:helpinghandsversion2/model/validationModel.dart';

class ProfileFormValidatorModel {
  late File _profilePicFile;
  ValidationModel _dateOfBirth = ValidationModel();
  ValidationModel _name = ValidationModel();
  ValidationModel _gender = ValidationModel();
  ValidationModel _bloodGroup = ValidationModel();
  ValidationModel _emergencyContact1 = ValidationModel();
  ValidationModel _emergencyContact2 = ValidationModel();
  ValidationModel _lastBloodDonated = ValidationModel();
  ValidationModel _lastPlasmaDonated = ValidationModel();
  ValidationModel _lastPlateletsDonated = ValidationModel();
  ValidationModel _donateBlood = ValidationModel();
  ValidationModel _donatePlasma = ValidationModel();
  ValidationModel _donatePlatelets = ValidationModel();
  ValidationModel _referral = ValidationModel();

  File get profilePicFile => _profilePicFile;

  ValidationModel get name => _name;
  ValidationModel get dateOfBirth => _dateOfBirth;
  ValidationModel get bloodGroup => _bloodGroup;
  ValidationModel get emergencyContact1 => _emergencyContact1;
  ValidationModel get emergecyContact2 => _emergencyContact2;
  ValidationModel get gender => _gender;

  ValidationModel get lastBloodDonated => _lastBloodDonated;
  ValidationModel get lastPlasmaDonated => _lastPlasmaDonated;
  ValidationModel get lastPlateletsDonated => _lastPlateletsDonated;

  ValidationModel get donateBlood => _donateBlood;
  ValidationModel get donatePlasma => _donatePlasma;
  ValidationModel get donatePlatelets => _donatePlatelets;

  ValidationModel get referral => _referral;

  set setName(ValidationModel temp) {
    _name = temp;
  }

  set setDateOfBirth(ValidationModel temp) {
    _dateOfBirth = temp;
  }

  set setGender(ValidationModel temp) {
    _gender = temp;
  }

  set setBloodGroup(ValidationModel temp) {
    _bloodGroup = temp;
  }

  set setEmergencyContact1(ValidationModel temp) {
    _emergencyContact1 = temp;
  }

  set setEmergencyContact2(ValidationModel temp) {
    _emergencyContact2 = temp;
  }

  set setLastBloodDonated(ValidationModel temp) {
    _lastBloodDonated = temp;
  }

  set setLastPlasmaDonated(ValidationModel temp) {
    _lastPlasmaDonated = temp;
  }

  set setLastPlateletsDonated(ValidationModel temp) {
    _lastPlateletsDonated = temp;
  }

  set setDonateBlood(ValidationModel temp) {
    _donateBlood = temp;
  }

  set setDonatePlasma(ValidationModel temp) {
    _donatePlasma = temp;
  }

  set setDonatePlatelets(ValidationModel temp) {
    _donatePlatelets = temp;
  }

  set setReferral(ValidationModel temp) {
    _referral = temp;
  }

  set setProfilePicFile(File _file) {
    _profilePicFile = _file;
  }
}
