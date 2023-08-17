import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/views/home_page.dart';
import 'package:chatbotapp/views/login_page.dart';
import 'package:chatbotapp/views/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  void waitTime() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget build(BuildContext context) {
    waitTime();
    var controller = Get.put(AuthController());
    return Container(alignment: Alignment.center, child: SplashScreen());
  }
}
