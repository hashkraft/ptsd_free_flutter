class UserAdd {
  static String username = "";
  static String zipcode = "";
  static String deviceid = "";

  static void setValues({
    required String user,
    required String zip,
    required String deviceId,
  }) {
    username = user;
    zipcode = zip;
    deviceid = deviceId;
  }
}
