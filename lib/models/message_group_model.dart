import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageGroupModel {
  final String uid;
  final List members;
  final Timestamp timestamp;
  final List messages;
  MessageGroupModel(
      {required this.uid,
      required this.members,
      required this.timestamp,
      required this.messages});

  factory MessageGroupModel.fromMap(DocumentSnapshot querySnapshot) {
    return MessageGroupModel(
      uid: querySnapshot['uid'] ?? '',
      members: List.from(querySnapshot['members']),
      timestamp: querySnapshot['timestamp'] ?? '',
      messages: List.from(querySnapshot['messages']),
    );
  }

  factory MessageGroupModel.fromJson(String source) =>
      MessageGroupModel.fromMap(json.decode(source));
}
