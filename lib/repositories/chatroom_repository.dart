// @dart=2.9
// 36/41

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// UUID V4: universally unique identifier generated using random numbers.

class ChatroomRepository {
  final Firestore _firestore;
  final FirebaseStorage _firebaseStorage;
  String uuid = Uuid().v4();

  ChatroomRepository({
    FirebaseStorage firebaseStorage,
    Firestore firestore,
  })  : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        _firestore = firestore ?? Firestore.instance;

  // method to send a message 37/41
  Future sendMessage({MessageDetail messageDetail}) async {
    StorageUploadTask storageUploadTask;
    DocumentReference messageReference =
        _firestore.collection('messages').document();

    CollectionReference senderReference = _firestore
        .collection('users')
        .document(messageDetail.senderId)
        .collection('chats')
        .document(messageDetail.selectedUserId)
        .collection('messages');

    CollectionReference sendUserReference = _firestore
        .collection('users')
        .document(messageDetail.selectedUserId)
        .collection('chats')
        .document(messageDetail.senderId)
        .collection('messages');

    // 1A check if the message is containing a photo
    if (messageDetail.photo != null) {
      StorageReference photoReference = _firebaseStorage
          .ref()
          .child('messages')
          .child(messageReference.documentID)
          .child(uuid);

      storageUploadTask = photoReference.putFile(messageDetail.photo);

      // 1B await the photo download url for the other user
      await storageUploadTask.onComplete.then((photo) async {
        await photo.ref.getDownloadURL().then((photoUrl) async {
          await messageReference.setData({
            'senderNickname': messageDetail.senderNickname,
            'senderId': messageDetail.senderId,
            'text': null,
            'photoUrl': photoUrl,
            'timestamp': DateTime.now(),
            'marriageDocUrl': null,
            'voicenoteUrl': null,
          });
        });
      });

      // 1C store the timestamp when sending a photo
      senderReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      sendUserReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      await _firestore
          .collection('users')
          .document(messageDetail.senderId)
          .collection('chats')
          .document(messageDetail.selectedUserId)
          .updateData({
        'timestamp': DateTime.now(),
      });

      await _firestore
          .collection('users')
          .document(messageDetail.selectedUserId)
          .collection('chats')
          .document(messageDetail.senderId)
          .updateData({
        'timestamp': DateTime.now(),
      });
    }

    // 2A check if the message is containing a marriagedoc
    if (messageDetail.marriageDoc != null) {
      StorageReference docReference = _firebaseStorage
          .ref()
          .child('messages')
          .child(messageReference.documentID)
          .child(uuid);

      storageUploadTask = docReference.putFile(messageDetail.marriageDoc);

      // 2B await the marriagedoc download url for the other user
      await storageUploadTask.onComplete.then((marriageDoc) async {
        await marriageDoc.ref.getDownloadURL().then((marriageDocUrl) async {
          await messageReference.setData({
            'senderNickname': messageDetail.senderNickname,
            'senderId': messageDetail.senderId,
            'text': null,
            'photoUrl': null,
            'timestamp': DateTime.now(),
            'marriageDocUrl': marriageDocUrl,
            'voicenoteUrl': null,
          });
        });
      });

      // 2C store the timestamp when sending a marriage doc
      senderReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      sendUserReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      await _firestore
          .collection('users')
          .document(messageDetail.senderId)
          .collection('chats')
          .document(messageDetail.selectedUserId)
          .updateData({
        'timestamp': DateTime.now(),
      });

      await _firestore
          .collection('users')
          .document(messageDetail.selectedUserId)
          .collection('chats')
          .document(messageDetail.senderId)
          .updateData({
        'timestamp': DateTime.now(),
      });
    }

    // 3A check if the message is containing a voicenote
    if (messageDetail.voicenote != null) {
      StorageReference docReference = _firebaseStorage
          .ref()
          .child('messages')
          .child(messageReference.documentID)
          .child(uuid);

      storageUploadTask = docReference.putFile(messageDetail.voicenote);

      // 3B await the voicenote download url for the other user
      await storageUploadTask.onComplete.then((voicenote) async {
        await voicenote.ref.getDownloadURL().then((voicenoteUrl) async {
          await messageReference.setData({
            'senderNickname': messageDetail.senderNickname,
            'senderId': messageDetail.senderId,
            'text': null,
            'photoUrl': null,
            'timestamp': DateTime.now(),
            'marriageDocUrl': null,
            'voicenoteUrl': voicenoteUrl,
          });
        });
      });

      // 3C store the timestamp when sending a marriage doc
      senderReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      sendUserReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      await _firestore
          .collection('users')
          .document(messageDetail.senderId)
          .collection('chats')
          .document(messageDetail.selectedUserId)
          .updateData({
        'timestamp': DateTime.now(),
      });

      await _firestore
          .collection('users')
          .document(messageDetail.selectedUserId)
          .collection('chats')
          .document(messageDetail.senderId)
          .updateData({
        'timestamp': DateTime.now(),
      });
    }

    // 4A check if the message is containing a text
    if (messageDetail.text != null) {
      await messageReference.setData({
        'senderNickname': messageDetail.senderNickname,
        'senderId': messageDetail.senderId,
        'text': messageDetail.text,
        'photoUrl': null,
        'timestamp': DateTime.now(),
        'marriageDocUrl': null,
        'voicenoteUrl': null,
      });

      // 4B store the timestamp when sending a text
      senderReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      sendUserReference
          .document(messageReference.documentID)
          .setData({'timestamp': DateTime.now()});

      await _firestore
          .collection('users')
          .document(messageDetail.senderId)
          .collection('chats')
          .document(messageDetail.selectedUserId)
          .updateData({
        'timestamp': DateTime.now(),
      });

      await _firestore
          .collection('users')
          .document(messageDetail.selectedUserId)
          .collection('chats')
          .document(messageDetail.senderId)
          .updateData({
        'timestamp': DateTime.now(),
      });
    }
  }

  // 5 method to receive a message by timestamp 37/41
  Stream<QuerySnapshot> getMessages({currentUserId, selectedUserId}) {
    return _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chats')
        .document(selectedUserId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // 6 method to see the details of the message 37/41
  Future<MessageDetail> getMessageDetail({messageId}) async {
    MessageDetail _messageDetail = MessageDetail();
    await _firestore
        .collection('messages')
        .document(messageId)
        .get()
        .then((messageDetail) {
      // prev message
      _messageDetail.senderId = messageDetail['senderId'];
      _messageDetail.senderNickname = messageDetail['senderNickname'];
      _messageDetail.timestamp = messageDetail['timestamp'];
      _messageDetail.text = messageDetail['text'];
      _messageDetail.photoUrl = messageDetail['photoUrl'];
      _messageDetail.marriageDocUrl = messageDetail['marriageDocUrl'];
      _messageDetail.voicenoteUrl = messageDetail['voicenoteUrl'];
    });

    return _messageDetail;
  }
}

// 37/41