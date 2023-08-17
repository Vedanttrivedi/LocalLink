import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowChat {
  String? groupName;
  String? groupIcon;
  String? admin;
  List<dynamic>? members;
  String? groupId;
  String? recentMessage;
  String? recentMessageSender;
  String? groupDescription;
  String? activity;

  ShowChat(
      {this.groupName,
      this.groupIcon,
      this.admin,
      this.members,
      this.groupId,
      this.recentMessage,
      this.recentMessageSender,
      this.groupDescription,
      this.activity});

  ShowChat.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    groupIcon = json['groupIcon'];
    admin = json['admin'];
    members = json['members'];
    groupId = json['groupId'];
    recentMessage = json['recentMessage'];
    recentMessageSender = json['recentMessageSender'];
    groupDescription = json["groupDescription"];
    activity = json["activity"];
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'groupIcon': groupIcon,
      'admin': admin,
      'members': members,
      'groupId': groupId,
      'recentMessage': recentMessage,
      'recentMessageSender': recentMessageSender,
      "groupDescription": groupDescription,
      "activity": activity
    };
  }

  ShowChat.fromDocumentSnapShot(DocumentSnapshot snapshot) {
    groupName = snapshot['groupName'];
    groupIcon = snapshot['groupIcon'];
    admin = snapshot['admin'];
    members = snapshot['members'];
    groupId = snapshot['groupId'];
    recentMessage = snapshot['recentMessage'];
    recentMessageSender = snapshot['recentMessageSender'];
  }
}
