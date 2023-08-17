import 'package:chatbotapp/models/user_model.dart';
import 'package:chatbotapp/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var emailField = TextEditingController().obs;
  var passwordField = TextEditingController().obs;
  var fullnameField = TextEditingController().obs;
  RxBool isTyping = false.obs;
  RxBool isVerifing = false.obs;
  RxBool agreeToTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  register() async {
    isVerifing.value = true;
    print("register method called from register controller");
    await AuthController.instance
        .registerUser(emailField.value.text, passwordField.value.text,
            fullnameField.value.text)
        .then((value) {
      if (value != null) {
        //save the user in cloud firestore database
        //also save the user locally in shared preferences and navigate to home page
      }
    });
    isVerifing.value = false;
    emailField.value.text = "";
    passwordField.value.text = "";
    fullnameField.value.text = "";
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
        "Please enter password",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (passwordField.value.text.length < 5) {
      Get.snackbar(
        "Error",
        "Password must be more than 5 characters",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (fullnameField.value.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter fullname",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (fullnameField.value.text.length < 5) {
      Get.snackbar(
        "Error",
        "Please enter fullname more than 5 characters",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      register();
    }
  }
}
