import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'dart:developer' as developer;

class MiddlewareCheck {
  Future<bool> checkIfUserRegistered() async {
    String deviceId = (await getId()) ?? "";
    developer.log(deviceId);
    final result = await FirebaseFirestore.instance
        .collection("users-data")
        .where("deviceId", isEqualTo: deviceId)
        .get();

    final record = await result.docs;
    if (record.isEmpty) {
      developer.log("No records");
      return false;
    } else {
      for (var docSnapshot in record) {
        developer
            .log('Data found : ${docSnapshot.id} => ${docSnapshot.data()}');
        UserAdd.setValues(
          user: docSnapshot.data()['username'],
          zip: docSnapshot.data()['zipcode'],
          deviceId: deviceId,
        );
        return true;
      }
    }
    // .then((value) {
    // if (value.docs.isEmpty) {
    //   // developer.log("No records");
    //   // return false;
    // } else {
    //   for (var docSnapshot in value.docs) {
    //     developer
    //         .log('Data found : ${docSnapshot.id} => ${docSnapshot.data()}');
    //     UserAdd.setValues(
    //       user: docSnapshot.data()['username'],
    //       zip: docSnapshot.data()['zipcode'],
    //       deviceId: deviceId,
    //     );
    //     return true;
    //   }
    // }
    // });
    // developer.log(result.toString());
    // if(result.docs.){

    // }
    return result.docs.isNotEmpty;
  }
}
