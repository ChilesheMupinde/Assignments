import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Usermodel.dart';

class DatabaseMeth extends GetxController {
  static DatabaseMeth get instance => Get.find();

  final _db = FirebaseFirestore.instance;

//used to add a new user to firebase
  createUser(Usermodel User) async {
    //awiat means the cpu waits for the querry to be done before going to the next one
    await _db
        .collection("Users")
        .doc(User.id)
        .set(User.toJSon())
        .whenComplete(() => Get.snackbar(
              "Success",
              "Your User Account has been created",
              snackPosition: SnackPosition.BOTTOM,
            ))
        .catchError((Error, StackTrace) {
      Get.snackbar("error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  Future<Usermodel> getUserDetail(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => Usermodel.fromSnapshot(e)).single;
    return userData;
  }

//displays user details
  Future<List<Usermodel>> allUserDetail() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => Usermodel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> UpdateUserDetails(Usermodel usermodel) async {
    await _db.collection("Users").doc(usermodel.id).update(usermodel.toJSon());
  }
}
