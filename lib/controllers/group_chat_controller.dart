import 'package:chatbotapp/models/message.dart';
import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/show_chats_models.dart';

class GroupChatController extends GetxController {
  final String groupId;
  GroupChatController(this.groupId);
  Rx<TextEditingController> msgField = TextEditingController().obs;

  Rx<ShowChat> groupInfo = ShowChat().obs;
  var messages = [].obs;
  @override
  void onInit() {
    super.onInit();
    //fetch group data

    FirebaseFirestore _db = FirebaseFirestore.instance;
    _db.collection("groups").doc(groupId).get().then((value) {
      Map<String, dynamic> map = value.data() as Map<String, dynamic>;
      groupInfo.value = ShowChat.fromJson(map);
    });
    //fetch message data
    _db
        .collection("groups")
        .doc(groupId)
        .collection("message")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      messages.value = event.docs.map((doc) {
        return Message(doc["sender"], doc["message"], doc["time"]);
      }).toList();
    });
  }

  Rx<String>? userid;
  Rx<String>? groupName;

  send(String groupId, String sender, String userid) async {
    print("message send");
    if (msgField.value.text.isEmpty) {
      return;
    }
    await DatabaseService(currentUserid: userid)
        .sendMessage(groupId, sender, msgField.value.text.toString());
    msgField.value.clear();
  }
}

//what should happen when the this controller is loaded
//whenever this controller  is loaded i want whole group data
//and map that data to my model