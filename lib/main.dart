import 'package:chatbotapp/utils/routes.dart';
import 'package:chatbotapp/utils/webConstant.dart';
import 'package:chatbotapp/views/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

@pragma('vm:entry-point')
Future<void> _handleBackgroundNotifications(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotifications);

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: WebFirebaseData.apiKey,
            appId: WebFirebaseData.appId,
            messagingSenderId: WebFirebaseData.messagingSenderId,
            projectId: WebFirebaseData.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainPage(),
      getPages: AppRoutes.routes,
      initialRoute: "/",
    );
  }
}
