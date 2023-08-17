import 'package:chatbotapp/helper/text_field_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    bool isPasswordVisible = false;

    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 70),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login LocaLlink",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white, // Set the text color to white
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () {
                      controller.isTyping.value = true;
                    },
                    controller: controller.emailField.value,
                    decoration: formFieldStyle.copyWith(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color:
                            Colors.white, // Set the label text color to white
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors
                            .deepPurpleAccent, // Set the icon color to deepPurpleAccent
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors
                              .deepPurpleAccent, // Set the border color to deepPurpleAccent
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Add border radius to the text field
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors
                              .orange, // Set the focused border color to orange
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Add border radius to the text field
                      ),
                      hintStyle: TextStyle(
                        color: Colors
                            .white70, // Set the hint text color to white with opacity
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                    cursorColor: Colors.white, // Set the cursor color to white
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    onTap: () {
                      controller.isTyping.value = true;
                    },
                    controller: controller.passwordField.value,
                    obscureText: !isPasswordVisible,
                    decoration: formFieldStyle.copyWith(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color:
                            Colors.white, // Set the label text color to white
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.orange, // Set the icon color to orange
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors
                              .deepPurpleAccent, // Set the border color to deepPurpleAccent
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Add border radius to the text field
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors
                              .orange, // Set the focused border color to orange
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Add border radius to the text field
                      ),
                      hintStyle: TextStyle(
                        color: Colors
                            .white70, // Set the hint text color to white with opacity
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                    cursorColor: Colors.white, // Set the cursor color to white
                  ),
                  Obx(() {
                    if (controller.isTyping.value) {
                      return SizedBox(
                        height: 10,
                      );
                    } else {
                      return SizedBox(
                        height: 30,
                      );
                    }
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      if (controller.isVerifing.value) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            controller.validate();
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.orange, // Set the button color to orange
                            elevation:
                                8, // Add more elevation (shadow) to the button
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                            ), // Add padding to the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .black, // Set the button text color to black
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors
                                .deepPurpleAccent, // Set the link color to deepPurpleAccent
                          ),
                        ),
                        onTap: () {
                          print("register button clicked");
                          Get.toNamed("/register");

                          controller.isTyping.value = false;
                          controller.emailField.value.text = "";
                          controller.passwordField.value.text = "";
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

login() {}
