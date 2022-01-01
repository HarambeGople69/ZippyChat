import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? phone_no;
  String? user_name;
  String? image_url;
  String? bio;
  int? connection_count;
  int? request_count;
  List? connection;
  List? request;
  List? pending;
  List? searchfrom;
  List? chatroomIds;

  Timestamp? created_at;

  UserModel(
      {required this.id,
      required this.phone_no,
      required this.user_name,
      required this.image_url,
      required this.bio,
      required this.connection_count,
      required this.request_count,
      required this.connection,
      required this.request,
      required this.pending,
      required this.created_at,
      required this.searchfrom,
      required this.chatroomIds});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'phone_no': phone_no,
  //     'user_name': user_name,
  //     'image_url': image_url,
  //     'bio': bio,
  //     'connection_count': connection_count,
  //     'request_count': request_count,
  //     'connection': connection,
  //     'request': request,
  //     'pending': pending,
  //     'created_at': created_at,
  //   };
  // }

  factory UserModel.fromMap(DocumentSnapshot querySnapshot) {
    return UserModel(
      id: querySnapshot['id'] ?? '',
      phone_no: querySnapshot['phone_no'] ?? '',
      user_name: querySnapshot['user_name'] ?? '',
      image_url: querySnapshot['image_url'] ?? '',
      bio: querySnapshot['bio'] ?? '',
      connection_count: querySnapshot['connection_count'] ?? '',
      request_count: querySnapshot['request_count'] ?? '',
      connection: List.from(querySnapshot['connection']),
      request: List.from(querySnapshot['request']),
      pending: List.from(querySnapshot['pending']),
      created_at: querySnapshot['created_at'] ?? '',
      searchfrom: List.from(
        querySnapshot['searchfrom'],
      ),
      chatroomIds: List.from(
        querySnapshot['chatroomIds'],
      ),
    );
  }

  // String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
