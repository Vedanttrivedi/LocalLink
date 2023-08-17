import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/services/notification_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  RxBool loginStatus = false.obs;
  NotificationServices services = NotificationServices();
  @override
  void onInit() async {
    super.onInit();
    services.requestNotificationPermission();
    if (getUserLoginStatus().toString().isEmpty) {
      loginStatus.value = false;
    } else {
      loginStatus.value = true;
    }
  }

  static Future<String?> getUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userLoggedInKey")) return "";
    return prefs.getString("userLoggedInKey");
  }
}
