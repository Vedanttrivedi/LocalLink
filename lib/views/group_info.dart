import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final String groupId;
  const GroupInfo({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 237, 180, 88),
        child: Center(
          child: Text(
            "Group Info",
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
