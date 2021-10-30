import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpinghandsversion2/api/firebaseApi.dart';
import 'package:helpinghandsversion2/model/profileFormValidatorModel.dart';
import 'package:helpinghandsversion2/model/validationModel.dart';
import 'package:helpinghandsversion2/widgets/alertDialog.dart';
import '../extensions/stringExtensions.dart';

class ProfileFormProvider extends ChangeNotifier {
  ProfileFormValidatorModel _profileFormValidatorModel =
      new ProfileFormValidatorModel();

  ProfileFormValidatorModel get profileFormValidatorModel =>
      _profileFormValidatorModel;

  bool validateName({String? val, bool check = false}) {
    if (val != null && val.isValidName) {
      _profileFormValidatorModel.setName =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setName =
          ValidationModel(value: null, error: 'Name is mandatory');
      notifyListeners();
      return false;
    }
  }

  validateBloodGroup(String? val) {
    if (val != null) {
      print("blood sucess");
      _profileFormValidatorModel.setBloodGroup =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setBloodGroup =
          ValidationModel(value: null, error: "Blood group is mandatory");
      notifyListeners();
      return false;
    }
  }

  validateDateOfBirth(DateTime? val) {
    if (val != null) {
      _profileFormValidatorModel.setDateOfBirth =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setDateOfBirth =
          ValidationModel(value: null, error: "Date of birth is mandatory");
      notifyListeners();
      return false;
    }
  }

  validateGender(String? val) {
    if (val != null) {
      _profileFormValidatorModel.setGender =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setGender =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateEmergencyContact1(String? val) {
    if (val != null && val.isValidPhone) {
      _profileFormValidatorModel.setEmergencyContact1 =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setEmergencyContact1 =
          ValidationModel(value: null, error: "invalid");
      notifyListeners();
      return false;
    }
  }

  validateEmergencyContact2(String? val) {
    if (val == null) {
      val = "";
    }
    if ((val.isValidPhone || val.isEmpty)) {
      _profileFormValidatorModel.setEmergencyContact2 =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setEmergencyContact2 =
          ValidationModel(value: null, error: "invalid");
      notifyListeners();
      return false;
    }
  }

  validateLastBloodDonated(dynamic val) {
    if (val != null) {
      _profileFormValidatorModel.setLastBloodDonated =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setLastBloodDonated =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateLastPlasmaDonated(dynamic val) {
    if (val != null) {
      _profileFormValidatorModel.setLastPlasmaDonated =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setLastPlasmaDonated =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateLastPlateletsDonated(dynamic val) {
    if (val != null) {
      _profileFormValidatorModel.setLastPlateletsDonated =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setLastPlateletsDonated =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateDonateBlood(bool? val) {
    if (val != null) {
      _profileFormValidatorModel.setDonateBlood =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setDonateBlood =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateDonatePlasma(bool? val) {
    if (val != null) {
      _profileFormValidatorModel.setDonatePlasma =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setDonatePlasma =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  validateDonatePlatelets(bool? val) {
    if (val != null) {
      _profileFormValidatorModel.setDonatePlatelets =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      _profileFormValidatorModel.setDonatePlatelets =
          ValidationModel(value: null, error: "*Mandatory");
      notifyListeners();
      return false;
    }
  }

  Future<bool> validateReferral(String code) async {
    if (code.length == 6) {
      Get.dialog(AlertDialogBox(
        title: "verifying",
      ));
      QuerySnapshot<Map<String, dynamic>> _isExist =
          await FirebaseApi.checkIfRefferalExists(code: code);

      if (_isExist.docs.length != 0) {
        _profileFormValidatorModel.setReferral =
            ValidationModel(value: _isExist.docs.first.id, error: null);
        print("friend " + _isExist.docs.first.id);
        Get.back();
        notifyListeners();
        return true;
      } else {
        _profileFormValidatorModel.setReferral =
            ValidationModel(value: null, error: "invalid refferal code");
        Get.back();
        notifyListeners();
        return false;
      }
    } else {
      _profileFormValidatorModel.setReferral =
          ValidationModel(value: null, error: "code should be atleat 6 digit.");
      Get.back();
      notifyListeners();
      return false;
    }
  }

  void submit() {
    if (validateName(val: _profileFormValidatorModel.name.value) &
        validateDateOfBirth(_profileFormValidatorModel.dateOfBirth.value) &
        validateBloodGroup(_profileFormValidatorModel.bloodGroup.value) &
        validateEmergencyContact1(
            _profileFormValidatorModel.emergencyContact1.value) &
        validateEmergencyContact2(
            _profileFormValidatorModel.emergecyContact2.value) &
        validateGender(_profileFormValidatorModel.gender.value) &
        validateLastBloodDonated(
            _profileFormValidatorModel.lastBloodDonated.value) &
        validateLastPlasmaDonated(
            _profileFormValidatorModel.lastPlasmaDonated.value) &
        validateLastPlateletsDonated(
            _profileFormValidatorModel.lastPlateletsDonated.value) &
        validateDonateBlood(_profileFormValidatorModel.donateBlood.value) &
        validateDonatePlasma(_profileFormValidatorModel.donatePlasma.value) &
        validateDonatePlatelets(
            _profileFormValidatorModel.donatePlatelets.value)) {
      Get.toNamed("/referral");
      print("validatated");
    } else {
      print("not validate");
    }
  }
}
