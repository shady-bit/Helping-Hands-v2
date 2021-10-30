class BloodGrp {
  static Map<String, List<String>> canGive = {
    'A-': ['A-','AB-','A+','AB+'],
    'B-': ['B-','AB-','B+','AB+'],
    'AB-': ['AB-','AB+'],
    "O-": ['A-','B-','AB-','O-','A+','B+','AB+','O+'],
    "A+": ['A+','AB+'],
    "B+": ['B+','AB+'],
    "AB+": ['AB+'],
    "O+": ['A+','B+','AB+','O+']
  };
}