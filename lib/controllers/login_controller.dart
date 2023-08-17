import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/helper_function.dart';

class LoginController extends GetxController {
  var emailField = TextEditingController().obs;
  var passwordField = TextEditingController().obs;
  RxBool isTyping = false.obs;
  RxBool isVerifing = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  login() async {
    isVerifing.value = true;
    await AuthController.instance
        .loginUser(emailField.value.text, passwordField.value.text)
        .then((value) async {
      if (value != null) {
        //user is logged in navigate to home page
        //save the data locally in shared preferences
      }
    });
    print("login method called from login controller");

    isVerifing.value = false;
    emailField.value.text = "";
    passwordField.value.text = "";
  }

  validate() {
    if (emailField.value.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (passwordField.value.text.isEmpty) {
      Get.snackbar(
        "Error",
        " Please enter password",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      login();
    }
  }
}
