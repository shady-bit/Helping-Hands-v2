import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpinghandsversion2/model/postFormValidator.dart';
import 'package:helpinghandsversion2/model/validationModel.dart';
import '../extensions/stringExtensions.dart';

class PostFormProvider extends ChangeNotifier {
  PostFormValidatorModel _postFormValidatorModel = new PostFormValidatorModel();

  PostFormValidatorModel get postFormValidatorModel => _postFormValidatorModel;

  void clear() {
    _postFormValidatorModel = new PostFormValidatorModel();
  }

  bool validateActive(bool? val) {
    if (val != null) {
      _postFormValidatorModel.setActive =
          ValidationModel(value: val, error: null);
      notifyListeners();
      return true;
    } else {
      print("a");
      _postFormValidatorModel.setActive =
          ValidationModel(value: null, error: 'invalid choice');
      notifyListeners();
      return false;
    }
  }

  validateRequirementType(String? val, {bool notify = true}) {
    if (val != null && val.isNotEmpty) {
      _postFormValidatorModel.setRequirementType =
          ValidationModel(value: val, error: null);
      if (notify) notifyListeners();
      return true;
    } else {
      print("b");
      _postFormValidatorModel.setRequirementType =
          ValidationModel(value: null, error: "invaild requirement Type");
      if (notify) notifyListeners();
      return false;
    }
  }

  validateBloodGroup(String? val,{bool notify = true}) {
    if (val != null && val.isNotEmpty) {
      print("blood sucess");
      _postFormValidatorModel.setBloodGroup =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("c");
      _postFormValidatorModel.setBloodGroup =
          ValidationModel(value: null, error: "choose blood Grp");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateUnits(String? val,{bool notify = true}) {
    if (val != null && val.isNotEmpty) {
      if (val.length <= 2) {
        _postFormValidatorModel.setUnits =
            ValidationModel(value: val, error: null);
        if(notify)    
        notifyListeners();
        return true;
      } else {
        print("d");
        _postFormValidatorModel.setUnits =
            ValidationModel(value: null, error: "Enter Valid Number");
        if(notify)    
        notifyListeners();
        return false;
      }
    } else {
      print("d");
      _postFormValidatorModel.setUnits =
          ValidationModel(value: null, error: "Please enter required units");
        if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateRequiredDateTime(DateTime? val,{bool notify = true}) {
    if (val != null) {
      print("blood sucess");
      _postFormValidatorModel.setRequiredDateTime =
          ValidationModel(value: val, error: null);
      if(notify)     
      notifyListeners();
      return true;
    } else {
      print("e");
      _postFormValidatorModel.setRequiredDateTime =
          ValidationModel(value: null, error: "choose valid date and time");
      if(notify)     
      notifyListeners();
      return false;
    }
  }

  validatePurpose(String? val , {bool notify = true}) {
    if (val != null && val.isNotEmpty) {
      if (val.length < 25) {
        _postFormValidatorModel.setPurpose =
            ValidationModel(value: val, error: null);

        if(notify)    
        notifyListeners();
        return true;
      } else {
        print("f");
        _postFormValidatorModel.setPurpose =
            ValidationModel(value: null, error: "max limit 25 char");
        if(notify)    
        notifyListeners();
        return false;
      }
    } else {
      print("f");
      _postFormValidatorModel.setPurpose =
          ValidationModel(value: null, error: "empty field");
        if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientName(String? val,{bool notify = true}) {
    if (val != null && val.isValidName) {
      _postFormValidatorModel.setPatientName =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("g");
      _postFormValidatorModel.setPatientName =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientAge(String? val,{bool notify = true}) {
    if (val != null) {
      if (val.length <= 3) {
        _postFormValidatorModel.setPatientAge =
            ValidationModel(value: val, error: null);
        if(notify)    
        notifyListeners();
        return true;
      } else {
        print("h");
        _postFormValidatorModel.setPatientAge =
            ValidationModel(value: null, error: "invalid");
        if(notify)    
        notifyListeners();
        return false;
      }
    } else {
      print("h");
      _postFormValidatorModel.setPatientAge =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientGender(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setGender =
          ValidationModel(value: val, error: null);
      
      if(notify)
       notifyListeners();
      return true;
    } else {
      print("k");
      _postFormValidatorModel.setGender =
          ValidationModel(value: null, error: "invalid");
      if(notify)
       notifyListeners();
      return false;
    }
  }

  validatePatientAttenderName1(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setPatientAttenderName1 =
          ValidationModel(value: val, error: null);

      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("l");
      _postFormValidatorModel.setPatientAttenderName1 =
          ValidationModel(value: null, error: "invalid");

      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientAttenderContact1(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setPatientAttenderContact1 =
          ValidationModel(value: val, error: null);

      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("m");
      _postFormValidatorModel.setPatientAttenderContact1 =
          ValidationModel(value: null, error: "invalid");

      if(notify)    
      notifyListeners();

      return false;
    }
  }

  validatePatientAttenderName2(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setPatientAttenderName2 =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("n");
      _postFormValidatorModel.setPatientAttenderName2 =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientAttenderContact2(String? val,{bool notify = true}) {
    if (val == null) {
      val = "";
    }
    if (val.isValidPhone || val.isEmpty) {
      _postFormValidatorModel.setPatientAttenderContact2 =
          ValidationModel(value: val, error: null);
      if(notify)         
      notifyListeners();
      return true;
    } else {
      print("o");
      _postFormValidatorModel.setPatientAttenderContact2 =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientAttenderName3(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setPatientAttenderName3 =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("p");
      _postFormValidatorModel.setPatientAttenderName3 =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validatePatientAttenderContact3(String? val,{bool notify = true}) {
    if (val == null) {
      val = "";
    }
    if (val.isEmpty || val.isValidPhone) {
      _postFormValidatorModel.setPatientAttenderContact3 =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("q");
      _postFormValidatorModel.setPatientAttenderContact3 =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateHosptialLocation(String? val, LatLng? l , {bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setHospitalLocation =
          ValidationModel(value: [val, l], error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("r");
      _postFormValidatorModel.setHospitalLocation =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateHosptialName(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setHospitalName =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("s");
      _postFormValidatorModel.setHospitalName =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateHosptialRoomNo(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setHospitalRoomNo =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("t");
      _postFormValidatorModel.setHospitalRoomNo =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateHosptialCity(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setHospitalCity =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("u");
      _postFormValidatorModel.setHospitalCity =
          ValidationModel(value: null, error: "invalid");
      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateHosptialAreaName(String? val,{bool notify = true}) {
    if (val != null) {
      _postFormValidatorModel.setHospitalAreaName =
          ValidationModel(value: val, error: null);
      if(notify)    
      notifyListeners();
      return true;
    } else {
      print("v");
      _postFormValidatorModel.setHospitalAreaName =
          ValidationModel(value: null, error: "invalid");

      if(notify)    
      notifyListeners();
      return false;
    }
  }

  validateOtherDetails(String? val,{bool notify = true}) {
    _postFormValidatorModel.setOtherDetails =
        ValidationModel(value: val, error: null);
    if(notify)    
    notifyListeners();
    return true;
  }

  bool validate() {
    validateActive(true);
    if (validateActive(_postFormValidatorModel.active.value) &
        validateRequirementType(_postFormValidatorModel.requirementType.value) &
        validateBloodGroup(_postFormValidatorModel.bloodGroup.value) &
        validateUnits(_postFormValidatorModel.units.value) &
        validateRequiredDateTime(
            _postFormValidatorModel.requiredDateTime.value) &
        validatePurpose(_postFormValidatorModel.purpose.value) &
        validatePatientName(_postFormValidatorModel.patientName.value) &
        validatePatientAge(_postFormValidatorModel.patientAge.value) &
        validatePatientGender(_postFormValidatorModel.gender.value) &
        validatePatientAttenderName1(
            _postFormValidatorModel.patientAttenderName1.value) &
        validatePatientAttenderContact1(
            _postFormValidatorModel.patientAttenderContact1.value) &
        validatePatientAttenderName2(
            _postFormValidatorModel.patientAttenderName2.value) &
        validatePatientAttenderContact2(
            _postFormValidatorModel.patientAttenderContact2.value) &
        validatePatientAttenderName3(
            _postFormValidatorModel.patientAttenderName3.value) &
        validatePatientAttenderContact3(
            _postFormValidatorModel.patientAttenderContact3.value) &
        validateHosptialLocation(
            _postFormValidatorModel.hospitalLocation.value?.first,
            _postFormValidatorModel.hospitalLocation.value?.last) &
        validateHosptialName(_postFormValidatorModel.hospitalName.value) &
        validateHosptialCity(_postFormValidatorModel.hospitalCity.value) &
        validateHosptialAreaName(
            _postFormValidatorModel.hospitalAreaName.value) &
        validateHosptialRoomNo(_postFormValidatorModel.hospitalRoomNo.value) &
        validateOtherDetails(_postFormValidatorModel.otherDetails.value)) {
      print("validatated");
      return true;
    } else {
      print("not validate");
      return false;
    }
  }
}
