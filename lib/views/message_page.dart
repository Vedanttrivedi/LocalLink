import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String? sender;
  final String? message;
  final bool? sendByMe;
  final int? time;
  MessageWidget(this.sender, this.message, this.sendByMe, this.time);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = sendByMe! ? Colors.deepPurpleAccent : Colors.orange;
    Color textColor = sendByMe! ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.all(10),
      margin: sendByMe!
          ? EdgeInsets.fromLTRB(80, 10, 10, 10)
          : EdgeInsets.fromLTRB(10, 10, 80, 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              sender!,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            message!,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            dateTimeFromEpoch(time!),
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

String dateTimeFromEpoch(int epochMillis) {
  // ... (Keep the existing code for date formatting)
  return "";
}

String dateTimeInIndianFormat(DateTime dateTime) {
  // ... (Keep the existing code for Indian date format)
  return "";
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Container(
        color: Colors.black87, // Dark background color for the entire page
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  MessageWidget("John", "Hello there!", false, 1656512912000),
                  MessageWidget("Alice", "Hi John!", true, 1656512923000),
                  // Add more MessageWidget instances here for demonstration purposes
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors
                    .grey[800], // Dark background for the send message textbox
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.orange, // Color for the send icon button
                    ),
                    onPressed: () {
                      // Implement the sending functionality here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
