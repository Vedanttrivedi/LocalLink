import 'dart:convert';

import 'package:chatbotapp/models/message.dart';
import 'package:chatbotapp/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/show_chats_models.dart';

class DatabaseService {
  String? currentUserid;
  NotificationServices services = NotificationServices();

  DatabaseService({this.currentUserid});
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  saveUser(Map<String, dynamic> userDataMap) async {
    await userCollection.doc(currentUserid).set(userDataMap);

    //set device  id in firebase
    await services.getDeviceToken().then((value) {
      print("saving the user ${value}");
      userCollection.doc(currentUserid).update({"deviceid": value});
    });
  }

  Future<QuerySnapshot> getUserDetails(String? email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    return snapshot;
  }

  getUserGroups() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserid)
        .get();
  }

  getGroupChats(String groupId) async {
    return await groupCollection.doc(groupId).collection("message").snapshots();
  }

  Future createGroup(
      String? userName, String? groupName, String? gd, String? act) async {
    print("create group called");
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupDescription": gd,
      "activity": act,
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${currentUserid}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${currentUserid}_${userName}"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(currentUserid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  Future<List<ShowChat>> getByGroupNames() async {
    final usersRef = FirebaseFirestore.instance.collection('groups');
    final snapshot = await usersRef.get();
    final allgroups = snapshot.docs.map((doc) {
      return ShowChat.fromJson(doc.data());
    }).toList();
    return allgroups;
  }

  addUserInGroup(String userName, String userId, String groupId,
      String groupName, String admin) async {
    String fullUserName = userId + "_" + userName;
    DocumentReference userRef = userCollection.doc(currentUserid);
    DocumentReference groupRef = groupCollection.doc(groupId);

    DocumentSnapshot snapshot = await userRef.get();

    List<dynamic> groups = await snapshot["groups"];
    if (listContainsStringer(groups, groupId + "_" + groupName)) {
      await userCollection.doc(currentUserid).update({
        "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
      });
      await groupCollection.doc(groupId).update({
        "members": FieldValue.arrayRemove(["${userId}_${userName}"])
      });

      //if admin is leaving the group delete the group
    } else {
      //add the group in user
      await userCollection.doc(currentUserid).update({
        "groups": FieldValue.arrayUnion(["${groupId}_${groupName}"])
      });
      //remove user from group
      await groupCollection.doc(groupId).update({
        "members": FieldValue.arrayUnion(["${userId}_${userName}"])
      });
    }
  }

  sendMessage(String groupId, String username, String message) async {
    Message msg =
        Message(username, message, DateTime.now().microsecondsSinceEpoch);
    await groupCollection.doc(groupId).collection("message").add(msg.toJson());
    await groupCollection.doc(groupId).update({
      "recentMessage": message,
      "recentMessageSender": username,
    });
  }

  getGroupMessages(String groupId) async {
    CollectionReference messageCollection = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('message');

    Stream<QuerySnapshot> messagesStream = messageCollection.snapshots();

    messagesStream.listen((snapshot) {
      snapshot.docs.map((doc) {});
    });
  }

  bool listContainsStringer(List<dynamic> list, String string) {
    for (var item in list) {
      print("string ${item} and matching user ${string} ");
      if (item == string) {
        return true;
      }
    }
    return false;
  }
}
