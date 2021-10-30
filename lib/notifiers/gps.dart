class GpsLocation {
  static double? lattidue;
  static double? longnitude;
  static bool? isMock;
  static void setValues(double? lat, double? long, bool? _isMock) {
    lattidue = lat;
    longnitude = long;
    isMock = _isMock;
  }

  double? get lat => lattidue;
  double? get long => long;
}
