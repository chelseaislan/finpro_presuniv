// @dart=2.9
// 27/41 01

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/user.dart';

class MatchesRepository {
  final Firestore _firestore;

  MatchesRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  // To get which other users you have matched
  Stream<QuerySnapshot> getMatchedList(userId) {
    return _firestore
        .collection('users')
        .document(userId)
        .collection('matchedList')
        .snapshots();
  }

  // To see which other users that chooses you
  Stream<QuerySnapshot> getSelectedList(userId) {
    return _firestore
        .collection('users')
        .document(userId)
        .collection('selectedList')
        .snapshots();
  }

  Future<User> getUserDetails(userId) async {
    User _user = User();
    await _firestore.collection('users').document(userId).get().then(
      (user) {
        // 6+3+9
        _user.uid = user.documentID;
        _user.photo = user['photoUrl'];
        _user.location = user['location'];
        _user.gender = user['gender'];
        _user.interestedIn = user['interestedIn'];
        _user.dob = user['dob'];
        _user.age = user['age'];
        _user.nickname = user['nickname'];
        _user.currentJob = user['currentJob'];
        _user.jobPosition = user['jobPosition'];
        _user.hobby = user['hobby'];
        _user.aboutMe = user['aboutMe'];
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
        _user.blurAvatar = user['blurAvatar'];
      },
    );
    return _user;
  }

  // To chat after matched, and each other can initiate the chat
  Future openChat({currentUserId, selectedUserId}) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chats')
        .document(selectedUserId)
        .setData({'timestamp': DateTime.now()});
    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('chats')
        .document(currentUserId)
        .setData({'timestamp': DateTime.now()});
    // await _firestore.collection('messages').document().setData({
    //   'senderNickname': null,
    //   'senderId': null,
    //   'text': null,
    //   'photoUrl': null,
    //   'timestamp': DateTime.now(),
    //   'marriageDocUrl': null,
    // });
  }

  // Dislike user in "matches to look for"
  void deleteUser(currentUserId, selectedUserId) async {
    return await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('selectedList')
        .document(selectedUserId)
        .delete();
  }

  // Delete user after matched
  void deleteMatchedUser(currentUserId, selectedUserId) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('matchedList')
        .document(selectedUserId)
        .delete();
    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('matchedList')
        .document(currentUserId)
        .delete();
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chats')
        .document(selectedUserId)
        .delete();
    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('chats')
        .document(currentUserId)
        .delete();
  }

  Future selectUser(
    currentUserId,
    selectedUserId,
    currentUserNickname,
    currentUserPhotoUrl,
    selectedUserNickname,
    selectedUserPhotoUrl,
    currentUserBlur,
    selectedUserBlur,
    currentUserAge,
    selectedUserAge,
  ) async {
    deleteUser(
        currentUserId, selectedUserId); // remove from bottom and add to top
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('matchedList')
        .document(selectedUserId)
        .setData({
      'nickname': selectedUserNickname,
      'photoUrl': selectedUserPhotoUrl,
      'age': selectedUserAge,
      'blurAvatar': selectedUserBlur,
    });
    return await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('matchedList')
        .document(currentUserId)
        .setData({
      'nickname': currentUserNickname,
      'photoUrl': currentUserPhotoUrl,
      'age': currentUserAge,
      'blurAvatar': currentUserBlur,
    });
  }
}

// END 27/41 01