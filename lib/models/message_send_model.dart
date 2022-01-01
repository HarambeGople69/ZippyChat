import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageSendModel {
  String? senderId;
  String? type;
  String? messageText;
  String? imageUrl;
  MessageSendModel({
    this.senderId,
    this.type,
    this.messageText,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'type': type,
      'messageText': messageText,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.now(),
    };
  }

  factory MessageSendModel.fromMap(Map<String, dynamic> querySnapshot) {
    return MessageSendModel(
      senderId: querySnapshot['senderId'],
      type: querySnapshot['type'],
      messageText: querySnapshot['messageText'],
      imageUrl: querySnapshot['imageUrl'],
      // timestamp: querySnapshot["timestamp"]
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageSendModel.fromJson(String source) =>
      MessageSendModel.fromMap(json.decode(source));
}
