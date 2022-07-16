// @dart=2.9
// originally search repository 03 22/41
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/user.dart';

class DiscoverRepository {
  final Firestore _firestore;

  DiscoverRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  // when the user likes another user
  Future<User> chooseUser(
    currentUserId,
    selectedUserId,
    nickname,
    photoUrl,
    age,
    blurAvatar,
    userChosenA,
    userChosenB,
  ) async {
    // put the user to the chosen list, set data in the map
    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chosenList')
        .document(selectedUserId)
        .setData({});

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('chosenList')
        .document(currentUserId)
        .setData({});

    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'userChosen': FieldValue.arrayUnion(userChosenA)});

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .updateData({'userChosen': FieldValue.arrayUnion(userChosenB)});

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('selectedList')
        .document(currentUserId)
        .setData({
      'nickname': nickname,
      'photoUrl': photoUrl,
      'age': age,
      'blurAvatar': blurAvatar,
    });
    return getUser(currentUserId);
  }

  // originally passUser, when the user dislike
  Future<User> dislikeUser(
      currentUserId, selectedUserId, userChosenA, userChosenB) async {
    await _firestore
        .collection('users')
        .document(selectedUserId)
        .collection('chosenList')
        .document(currentUserId)
        .setData({});

    await _firestore
        .collection('users')
        .document(currentUserId)
        .collection('chosenList')
        .document(selectedUserId)
        .setData({});

    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'userChosen': FieldValue.arrayUnion(userChosenA)});

    await _firestore
        .collection('users')
        .document(selectedUserId)
        .updateData({'userChosen': FieldValue.arrayUnion(userChosenB)});

    return getUser(currentUserId);
  }

  Future getUserInterests(userId) async {
    User currentUser = User();
    // check if the current user can match with the selected user
    await _firestore.collection('users').document(userId).get().then((user) {
      currentUser.photo = user['photoUrl'];
      currentUser.location = user['location'];
      currentUser.gender = user['gender'];
      currentUser.interestedIn = user['interestedIn'];
      currentUser.dob = user['dob'];
      currentUser.age = user['age'];
      currentUser.nickname = user['nickname'];
      currentUser.currentJob = user['currentJob'];
      currentUser.jobPosition = user['jobPosition'];
      currentUser.hobby = user['hobby'];
      currentUser.aboutMe = user['aboutMe'];
      currentUser.accountType = user['accountType'];
      currentUser.sholat = user['sholat'];
      currentUser.sSunnah = user['sSunnah'];
      currentUser.fasting = user['fasting'];
      currentUser.fSunnah = user['fSunnah'];
      currentUser.pilgrimage = user['pilgrimage'];
      currentUser.quranLevel = user['quranLevel'];
      currentUser.province = user['province'];
      currentUser.education = user['education'];
      currentUser.marriageStatus = user['marriageStatus'];
      currentUser.haveKids = user['haveKids'];
      currentUser.childPreference = user['childPreference'];
      currentUser.salaryRange = user['salaryRange'];
      currentUser.financials = user['financials'];
      currentUser.personality = user['personality'];
      currentUser.pets = user['pets'];
      currentUser.smoke = user['smoke'];
      currentUser.tattoo = user['tattoo'];
      currentUser.target = user['target'];
      currentUser.blurAvatar = user['blurAvatar'];
    });
    return currentUser;
  }

  // after get the documents, if it's not empty then added with the chosen list
  Future<List> getChosenList(userId) async {
    List<String> chosenList = [];
    await _firestore
        .collection('users')
        .document(userId)
        .collection('chosenList')
        .getDocuments()
        .then(
      (docs) {
        for (var doc in docs.documents) {
          if (docs.documents != null) {
            chosenList.add(doc.documentID);
          }
        }
      },
    );
    return chosenList;
  }

  // to check chosenlist has user document id to match each other,
  // and not to select yourself and to match your selected gender & interests
  Future<User> getUser(userId) async {
    User _user = User();
    List<String> chosenList = await getChosenList(userId);
    User currentUser = await getUserInterests(userId);

    await _firestore.collection('users').getDocuments().then(
      (users) {
        for (var user in users.documents) {
          if ((!chosenList.contains(user.documentID)) &&
              (user.documentID != userId) &&
              (currentUser.interestedIn == user['gender']) &&
              (user['accountType'] == 'verified') &&
              // (user['location'] == currentUser.location) &&
              (user['province'] == currentUser.province) &&
              (user['interestedIn'] == currentUser.gender)) {
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
            // _user.name = user['name'];
            // _user.photoKtp = user['photoKtp'];
            // _user.photoOtherID = user['photoOtherID'];
            // _user.marriageA = user['marriageA'];
            // _user.marriageB = user['marriageB'];
            // _user.marriageC = user['marriageC'];
            // _user.marriageD = user['marriageD'];
            // _user.taarufWith = user['taarufWith'];
            // _user.taarufChecklist = user['taarufCheck'];
            break;
          }
        }
      },
    );
    return _user;
  }
}
