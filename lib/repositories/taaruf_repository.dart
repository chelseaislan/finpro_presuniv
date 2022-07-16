// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/user.dart';

class TaarufRepository {
  final Firestore _firestore;

  TaarufRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  // Load both users with get selected & current user details
  Future<User> getSelectedUserDetails({userId}) async {
    User selectedUser = User();
    await _firestore.collection('users').document(userId).get().then(
      (user) {
        // 6+3+9
        selectedUser.uid = user.documentID;
        selectedUser.photo = user['photoUrl'];
        selectedUser.gender = user['gender'];
        selectedUser.age = user['age'];
        selectedUser.nickname = user['nickname'];
        selectedUser.taarufWith = user['taarufWith'];
        selectedUser.taarufChecklist = user['taarufCheck'];
        selectedUser.marriageA = user['marriageA'];
        selectedUser.marriageB = user['marriageB'];
        selectedUser.marriageC = user['marriageC'];
        selectedUser.marriageD = user['marriageD'];
        selectedUser.accountType = user['accountType']; // add
        selectedUser.marriageStatus = user['marriageStatus']; // add
      },
    );
    return selectedUser;
  }

  Future getCurrentUserDetails(userId) async {
    User currentUser = User();
    // check if the current user can match with the selected user
    await _firestore.collection('users').document(userId).get().then((user) {
      currentUser.uid = user.documentID;
      currentUser.photo = user['photoUrl'];
      currentUser.gender = user['gender'];
      currentUser.age = user['age'];
      currentUser.nickname = user['nickname'];
      currentUser.taarufWith = user['taarufWith'];
      currentUser.taarufChecklist = user['taarufCheck'];
      currentUser.marriageA = user['marriageA'];
      currentUser.marriageB = user['marriageB'];
      currentUser.marriageC = user['marriageC'];
      currentUser.marriageD = user['marriageD'];
      currentUser.accountType = user['accountType']; // add
      currentUser.marriageStatus = user['marriageStatus']; // add
    });
    return currentUser;
  }

  Future getTaarufChecklist(userId) async {
    User currentUser = User();
    // check if the current user can match with the selected user
    await _firestore.collection('users').document(userId).get().then((user) {
      currentUser.taarufChecklist = user['taarufCheck'];
    });
    return currentUser;
  }

  Future<User> cancelTaaruf(
    currentUserId,
    selectedUserId,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('taarufList')
        .document(selectedUserId)
        .delete();

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('taarufList')
        .document(currentUserId)
        .delete();

    await _firestore.collection('users').document(currentUserId).updateData({
      'marriageA': null,
      'marriageB': null,
      'marriageC': null,
      'marriageD': null,
      'taarufCheck': 0,
      'taarufWith': null,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'marriageA': null,
      'marriageB': null,
      'marriageC': null,
      'marriageD': null,
      'taarufCheck': 0,
      'taarufWith': null,
    });
    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> addCalendarA(
    currentUserId,
    selectedUserId,
    taarufWithCurrentUser,
    taarufWithSelectedUser,
    taarufCheck,
    marriageA,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('taarufList')
        .document(selectedUserId)
        .setData({});

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('taarufList')
        .document(currentUserId)
        .setData({});

    await _firestore.collection('users').document(currentUserId).updateData({
      'taarufWith': taarufWithCurrentUser,
      'taarufCheck': taarufCheck,
      'marriageA': marriageA,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'taarufWith': taarufWithSelectedUser,
      'taarufCheck': taarufCheck,
      'marriageA': marriageA,
    });
    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> addCalendarB(
    currentUserId,
    selectedUserId,
    taarufCheck,
    marriageB,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageB': marriageB,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageB': marriageB,
    });

    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> addChecklistThree(
    currentUserId,
    selectedUserId,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'taarufCheck': 3,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'taarufCheck': 3,
    });

    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> addCalendarC(
    currentUserId,
    selectedUserId,
    taarufCheck,
    marriageC,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageC': marriageC,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageC': marriageC,
    });

    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> addCalendarD(
    currentUserId,
    selectedUserId,
    taarufCheck,
    marriageD,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageD': marriageD,
    });

    await _firestore.collection('users').document(selectedUserId).updateData({
      'taarufCheck': taarufCheck,
      'marriageD': marriageD,
    });

    return getSelectedUserDetails(userId: currentUserId);
  }

  // new
  Future<User> finishTaaruf(
    currentUserId,
    selectedUserId,
    accountType,
    marriageStatus,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'accountType': accountType,
      'marriageStatus': marriageStatus,
      'taarufCheck': 6,
    });
    await _firestore.collection('users').document(selectedUserId).updateData({
      'accountType': accountType,
      'marriageStatus': marriageStatus,
      'taarufCheck': 6,
    });
    return getSelectedUserDetails(userId: currentUserId);
  }

  Future<User> submitRating(
    currentUserId,
    yAppRating,
    yExpRating,
    ySuggestionRating,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'yAppRating': yAppRating,
      'yExpRating': yExpRating,
      'ySuggestionRating': ySuggestionRating,
    });
    return getSelectedUserDetails(userId: currentUserId);
  }

  // Future openChat({currentUserId, selectedUserId}) async {
  //   await _firestore
  //       .collection('users')
  //       .document(currentUserId)
  //       .collection('chats')
  //       .document(selectedUserId)
  //       .setData({'timestamp': DateTime.now()});
  //   await _firestore
  //       .collection('users')
  //       .document(selectedUserId)
  //       .collection('chats')
  //       .document(currentUserId)
  //       .setData({'timestamp': DateTime.now()});
  // }
}
