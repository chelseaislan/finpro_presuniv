// @dart=2.9
// 32/41 02

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:finpro_max/models/user.dart';

class MessageRepository {
  final Firestore _firestore;

  MessageRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  // Get chats from user collection, according to the user id, the messages
  // sorted by descending
  Stream<QuerySnapshot> getChats({userId}) {
    return _firestore
        .collection('users')
        .document(userId)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Delete message
  Future deleteChat({currentUserId, selectedUserId}) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chats')
        .document(selectedUserId)
        .delete();
    // await _firestore
    //     .collection('users')
    //     .document(selectedUserId)
    //     .collection('chats')
    //     .document(currentUserId)
    //     .delete();
  }

  // 6+3+9
  Future<User> getUserDetail({userId}) async {
    User _user = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _user.uid = user.documentID;
      _user.photo = user['photoUrl'];
      _user.photoKtp = user['photoKtp'];
      _user.photoOtherID = user['photoOtherID'];
      _user.name = user['name'];
      _user.location = user['location'];
      _user.gender = user['gender'];
      _user.interestedIn = user['interestedIn'];
      _user.dob = user['dob'];
      _user.age = user['age'];
      _user.nickname = user['nickname'];
      _user.currentJob = user['currentJob'];
      _user.jobPosition = user['jobPosition'];
      _user.hobby = user['hobby'];
      _user.accountType = user['accountType'];
      _user.sholat = user['sholat'];
      _user.sSunnah = user['sSunnah'];
      _user.fasting = user['fasting'];
      _user.fSunnah = user['fSunnah'];
      _user.pilgrimage = user['pilgrimage'];
      _user.quranLevel = user['quranLevel'];
      _user.province = user['province'];
      _user.education = user['education'];
      _user.marriageStatus = user['marriageStatus'];
      _user.haveKids = user['haveKids'];
      _user.childPreference = user['childPreference'];
      _user.salaryRange = user['salaryRange'];
      _user.financials = user['financials'];
      _user.personality = user['personality'];
      _user.pets = user['pets'];
      _user.smoke = user['smoke'];
      _user.tattoo = user['tattoo'];
      _user.target = user['target'];
      _user.marriageA = user['marriageA'];
      _user.marriageB = user['marriageB'];
      _user.marriageC = user['marriageC'];
      _user.marriageD = user['marriageD'];
      _user.taarufWith = user['taarufWith'];
      _user.taarufChecklist = user['taarufCheck'];
      _user.blurAvatar = user['blurAvatar'];
      _user.userChosen = user['userChosen'];
      _user.userMatched = user['userMatched'];
    });
    return _user;
  }

  Future<MessageDetail> getLastMessage({currentUserId, selectedUserId}) async {
    MessageDetail _messageDetail = MessageDetail();
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chats')
        .document(selectedUserId)
        .collection('messages') // prev chats
        .orderBy('timestamp', descending: true)
        .snapshots()
        .first
        .then((doc) async {
      await _firestore
          .collection('messages') // prev chats
          .document(doc.documents.first.documentID)
          .get()
          .then((messageDetail) {
        _messageDetail.text = messageDetail['text'];
        _messageDetail.photoUrl = messageDetail['photoUrl'];
        _messageDetail.timestamp = messageDetail['timestamp'];
        _messageDetail.marriageDocUrl = messageDetail['marriageDocUrl'];
        _messageDetail.voicenoteUrl = messageDetail['voicenoteUrl']; // new
      });
    });
    return _messageDetail;
  }
}

// 32/41 END