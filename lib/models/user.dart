class UserAdd {
  static String username = "";
  static String password = "";
  static String zipcode = "";
  static String deviceid = "";

  static void setValues({
    required String user,
    required String pass,
    required String zip,
    required String deviceId,
  }) {
    username = user;
    password = pass;
    zipcode = zip;
    deviceid = deviceId;
  }
}
