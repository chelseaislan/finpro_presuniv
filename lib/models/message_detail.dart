// @dart=2.9
// 32/41 01

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDetail {
  String senderNickname,
      senderId,
      selectedUserId,
      text,
      photoUrl,
      marriageDocUrl,
      voicenoteUrl; // new
  File photo, marriageDoc, voicenote; // new
  Timestamp timestamp;
  MessageDetail({
    this.senderNickname,
    this.senderId,
    this.selectedUserId,
    this.text,
    this.photoUrl,
    this.marriageDocUrl,
    this.voicenoteUrl, // new
    this.photo,
    this.marriageDoc,
    this.voicenote, // new
    this.timestamp,
  });
}
