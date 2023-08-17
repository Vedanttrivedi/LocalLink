import 'package:chatbotapp/models/user_model.dart';
import 'package:chatbotapp/services/database_service.dart';
import 'package:chatbotapp/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/helper_function.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> _user;
  static AuthController instance = Get.find();

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, intialScreen);
  }

  intialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/home");
    }
  }

  //login
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      DatabaseService dbService = DatabaseService(
          currentUserid: FirebaseAuth.instance.currentUser!.uid);
      QuerySnapshot snapshot = await dbService.getUserDetails(email);
      User? firebaseUser = result.user;
      String? username;
      if (firebaseUser != null) {
        await HelperFunction.saveUserName(snapshot.docs[0]["fullname"]);
        await HelperFunction.saveUserEmail(firebaseUser.email.toString());
        await HelperFunction.saveUserLoginStatus(firebaseUser.uid.toString());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      print(e.toString());
    }
  }

  //register
  Future registerUser(String email, String password, String username) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;

      //if user is successfully created save info to cloud firestore
      DatabaseService databaseService =
          DatabaseService(currentUserid: firebaseUser!.uid);
      CustomUser cu = CustomUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          fullname: username,
          deviceId: "",
          groups: []);
      await databaseService.saveUser(cu.toJson());
      //and save user info locally in shared preferences
      await HelperFunction.saveUserName(username.toString());
      await HelperFunction.saveUserEmail(firebaseUser.email.toString());
      await HelperFunction.saveUserLoginStatus(firebaseUser.uid.toString());
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e.toString());
    }
  }

  //logout
  Future logout() async {
    print("logout method called");
    await firebaseAuth.signOut();
    await HelperFunction.saveUserLoginStatus("").then((value) {
      //can do some work when user is loggedout
      //no need to write get.tonamed as we are managing state with getx
      //firebase current auth value will  be null
    });
  }
}
