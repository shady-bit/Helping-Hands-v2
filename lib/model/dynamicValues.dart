import 'package:json_annotation/json_annotation.dart';
part 'dynamicValues.g.dart';

@JsonSerializable()
class DynamicValues {
  // ignore: non_constant_identifier_names
  int BloodToBloodF,
      BloodToBloodM,
      BloodToPlasma,
      BloodToPlatelets,
      PlasmaToBlood,
      PlasmaToPlasma,
      PlasmaToPlatelets,
      PlateletsToBlood,
      PlateletsToPlasma,
      PlateletsToPlatelets,
      checkRadius,
      donationPoints,
      referralPoints;
  DynamicValues(
      {required this.BloodToBloodF,
      required this.BloodToBloodM,
      required this.BloodToPlasma,
      required this.BloodToPlatelets,
      required this.PlasmaToBlood,
      required this.PlasmaToPlasma,
      required this.PlasmaToPlatelets,
      required this.PlateletsToBlood,
      required this.PlateletsToPlasma,
      required this.PlateletsToPlatelets,
      required this.checkRadius,
      required this.donationPoints,
      required this.referralPoints});

  factory DynamicValues.fromJson(Map<String, dynamic> json) =>
      _$DynamicValuesFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicValuesToJson(this);
}
