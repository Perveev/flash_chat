import 'package:flash_chat/constants.dart';
import 'package:flash_chat/services/message.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  Message message;

  MessageBubble({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: senderLabelTextStyle,
          ),
          Material(
            borderRadius: message.isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            color: message.isMe ? Colors.lightBlueAccent : Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                message.text,
                style: message.isMe ? myMessageTextStyle : messageTextStyle,
              ),
            ),
          ),
          Text(
            "${message.date.hour}:${message.date.minute}  ${message.date.day}.${message.date.month}",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
