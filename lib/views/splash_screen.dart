import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlue),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chatbot App",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Chat With  Your Clients",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
