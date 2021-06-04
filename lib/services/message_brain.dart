import 'package:flash_chat/services/message.dart';

class MessageBrain {
  final List<Message> _messages = [];

  void addMessage(String sender, String text, DateTime date, bool isMe) {
    Message newMessage = Message(sender: sender, text: text, date: date, isMe: isMe);
    _messages.add(newMessage);
  }

  void sortByDate() {
    _messages.sort((a, b) => b.date.compareTo(a.date));
  }

  List<Message> getMessageList() => _messages;

  void clearMessageList() => _messages.clear();
}
