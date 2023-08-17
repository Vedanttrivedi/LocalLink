import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sender;
  String message;
  int time;

  Message(this.sender, this.message, this.time);

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "message": message,
      "time": DateTime.now().microsecondsSinceEpoch,
    };
  }

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      json["sender"],
      json["message"],
      json["time"],
    );
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(map["sender"], map['message'], map["time"]);
  }
}
