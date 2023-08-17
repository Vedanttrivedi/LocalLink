import 'package:chatbotapp/views/group_chat_page.dart';
import 'package:chatbotapp/views/group_info.dart';
import 'package:chatbotapp/views/home_page.dart';
import 'package:chatbotapp/views/login_page.dart';
import 'package:chatbotapp/views/main_page.dart';
import 'package:chatbotapp/views/search_group.dart';
import 'package:get/get.dart';

import '../views/register_page.dart';

class AppRoutes {
  static var routes = [
    GetPage(name: '/', page: () => const MainPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: "/register", page: () => RegisterPage()),
    GetPage(name: '/search', page: () => SearchGroup("", "")),
    GetPage(name: '/chat', page: () => GroupChatPage()),
  ];
}
