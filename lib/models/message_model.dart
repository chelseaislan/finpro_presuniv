// @dart=2.9
// 34/41 02

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String nickname,
      photoUrl,
      lastMessagePhoto,
      lastMessage,
      lastMessageCV,
      marriageDocUrl;
  Timestamp timestamp;
  MessageModel({
    this.nickname,
    this.photoUrl,
    this.lastMessagePhoto,
    this.lastMessage,
    this.timestamp,
    this.lastMessageCV,
    this.marriageDocUrl,
  });
}
