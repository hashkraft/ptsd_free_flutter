class UserAdd {
  static String username = "";
  static String password = "";
  static String zipcode = "";
  static String deviceid = "";
  static bool push = false;
  static bool randomPTSD = false;

  static void setValues({
    required String user,
    required String pass,
    required String zip,
    required String deviceId,
    required bool push1,
    required bool randomPTSD1,
  }) {
    username = user;
    password = pass;
    zipcode = zip;
    deviceid = deviceId;
    push = push1;
    randomPTSD = randomPTSD1;
  }
}
