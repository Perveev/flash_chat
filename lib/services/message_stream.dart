import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/services/message_brain.dart';
import 'package:flash_chat/services/message_bubble.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessagesStream extends StatelessWidget {
  MessageBrain messageBrain = MessageBrain();
  final firestore;
  final String email;

  MessagesStream({this.firestore, @required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messagesWithData').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          );
        }
        final messages = snapshot.data.docs;
        List<Widget> messageBubbles = [];

        for (var message in messages) {
          Timestamp timestamp = message['date'];
          DateTime time = timestamp.toDate();
          messageBrain.addMessage(message['sender'], message['text'], time, email == message['sender']);
        }
        messageBrain.sortByDate();
        for (var message in messageBrain.getMessageList()) {
          final messageBubble = MessageBubble(message: message);
          messageBubbles.add(messageBubble);
        }
        messageBrain.clearMessageList();
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
