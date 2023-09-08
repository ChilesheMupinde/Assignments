import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../methods/AuthenticationMethods.dart';
import '../methods/FirestoreMethods.dart';
import '../models/Usermodel.dart';

class SignUPController extends GetxController {
  static SignUPController get Instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();

  final Datarep = Get.put(DatabaseMeth());

  void registerUser(String email, String password) {
    AuthMethods.instance.createuserwithemailandpassword(email, password);
  }

//used to create a new user
  void createUser(Usermodel user) {
    Datarep.createUser(user);
    registerUser(user.email, user.password);
  }
}
