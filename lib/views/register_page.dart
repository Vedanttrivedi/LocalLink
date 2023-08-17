import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';
import '../helper/text_field_style.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Join LocalLink",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white, // White text color
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onTap: () {
                        controller.isTyping.value = true;
                      },
                      controller: controller.fullnameField.value,
                      style: TextStyle(
                        color:
                            Colors.white, // White text color for the input text
                      ),
                      decoration: formFieldStyle.copyWith(
                        labelText: "Full Name",
                        prefixIcon:
                            Icon(Icons.person, color: Colors.deepPurpleAccent),
                        labelStyle: TextStyle(
                          color: Colors.white, // White hint text color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white70, // White hint text color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onTap: () {
                        controller.isTyping.value = true;
                      },
                      controller: controller.emailField.value,
                      style: TextStyle(
                        color:
                            Colors.white, // White text color for the input text
                      ),
                      decoration: formFieldStyle.copyWith(
                        labelText: "Email",
                        prefixIcon:
                            Icon(Icons.email, color: Colors.deepPurpleAccent),
                        labelStyle: TextStyle(
                          color: Colors.white, // White hint text color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white70, // White hint text color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onTap: () {
                        controller.isTyping.value = true;
                      },
                      controller: controller.passwordField.value,
                      obscureText: true,
                      style: TextStyle(
                        color:
                            Colors.white, // White text color for the input text
                      ),
                      decoration: formFieldStyle.copyWith(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.deepOrange),
                        labelStyle: TextStyle(
                          color: Colors.white, // White hint text color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white70, // White hint text color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors
                                .white, // White color when the checkbox is unchecked
                          ),
                          child: Obx(() {
                            return Checkbox(
                              value: controller.agreeToTerms.value,
                              onChanged: (newValue) {
                                controller.agreeToTerms.value =
                                    newValue ?? false;
                              },
                              activeColor: Colors
                                  .deepPurpleAccent, // Purple color when the checkbox is checked
                            );
                          }),
                        ),
                        Text(
                          "I agree to the terms and conditions",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // White text color
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        if (controller.isVerifing.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orange, // Orange background color
                              foregroundColor: Colors.black,
                              elevation:
                                  8, // Add elevation (shadow) to the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: controller.validate,
                            child: Text("Register"),
                          );
                        }
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have An Account?",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white, // White text color
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          onTap: () {
                            print("login button clicked");
                            Get.toNamed("/login");
                            controller.isTyping.value = false;
                            controller.emailField.value.clear();
                            controller.passwordField.value.clear();
                            controller.fullnameField.value.clear();
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
      ),
    );
  }
}
