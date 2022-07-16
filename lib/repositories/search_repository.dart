// @dart=2.9
// originally search repository 03 22/41
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/user.dart';

class SearchRepository {
  final Firestore _firestore;

  SearchRepository({Firestore firestore})
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
    return getUserDetails(currentUserId);
  }

  // originally passUser, when the user dislike
  Future<User> dislikeUser(
    currentUserId,
    selectedUserId,
    userChosenA,
    userChosenB,
  ) async {
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

    return getUserDetails(currentUserId);
  }

  Future getUserForSearch(userId) async {
    User currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      // only pro accounts can access manual search
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
      currentUser.userChosen = user['userChosen'];
      currentUser.zNickname = user['zNickname'];
      currentUser.zSholat = user['zSholat'];
      currentUser.zSSunnah = user['zSSunnah'];
      currentUser.zFasting = user['zFasting'];
      currentUser.zFSunnah = user['zFSunnah'];
      currentUser.zPilgrimage = user['zPilgrimage'];
      currentUser.zQuranLevel = user['zQuranLevel'];
      currentUser.zEducation = user['zEducation'];
      currentUser.zMarriageStatus = user['zMarriageStatus'];
      currentUser.zHaveKids = user['zHaveKids'];
      currentUser.zChildPreference = user['zChildPreference'];
      currentUser.zSalaryRange = user['zSalaryRange'];
      currentUser.zFinancials = user['zFinancials'];
      currentUser.zPersonality = user['zPersonality'];
      currentUser.zPets = user['zPets'];
      currentUser.zSmoke = user['zSmoke'];
      currentUser.zTattoo = user['zTattoo'];
      currentUser.zTarget = user['zTarget'];
    });
    return currentUser;
  }

  Future<User> getUserDetails(userId) async {
    User _user = User();
    await _firestore.collection('users').document(userId).get().then(
      (user) {
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
        _user.userChosen = user['userChosen'];
      },
    );
    return _user;
  }

  Stream<QuerySnapshot> getMaleUserList({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.location = user["location"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .snapshots();
  }

  Stream<QuerySnapshot> getFemaleUserList({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.location = user["location"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .snapshots();
  }

  // simple search starts here
  Future<void> addNicknameSearch(
    String currentUserId,
    String zNickname,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zNickname': zNickname});
  }

  Stream<QuerySnapshot> sortMaleNickname({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zNickname = user["zNickname"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('nickname', isEqualTo: _currentUser.zNickname)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleNickname({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zNickname = user["zNickname"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('nickname', isEqualTo: _currentUser.zNickname)
        .snapshots();
  }

  Future<void> addSholat(
    String currentUserId,
    String zSholat,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zSholat': zSholat});
  }

  Stream<QuerySnapshot> sortMaleSholat({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSholat = user["zSholat"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sholat', isEqualTo: _currentUser.zSholat)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleSholat({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSholat = user["zSholat"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sholat', isEqualTo: _currentUser.zSholat)
        .snapshots();
  }

  Future<void> addSSunnah(
    String currentUserId,
    String zSSunnah,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zSSunnah': zSSunnah});
  }

  Stream<QuerySnapshot> sortMaleSSunnah({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSSunnah = user["zSSunnah"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sSunnah', isEqualTo: _currentUser.zSSunnah)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleSSunnah({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSSunnah = user["zSSunnah"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sSunnah', isEqualTo: _currentUser.zSSunnah)
        .snapshots();
  }

  Future<void> addFasting(
    String currentUserId,
    String zFasting,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zFasting': zFasting});
  }

  Stream<QuerySnapshot> sortMaleFasting({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFasting = user["zFasting"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('fasting', isEqualTo: _currentUser.zFasting)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleFasting({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFasting = user["zFasting"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('fasting', isEqualTo: _currentUser.zFasting)
        .snapshots();
  }

  Future<void> addFSunnah(
    String currentUserId,
    String zFSunnah,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zFSunnah': zFSunnah});
  }

  Stream<QuerySnapshot> sortMaleFSunnah({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFSunnah = user["zFSunnah"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('fSunnah', isEqualTo: _currentUser.zFSunnah)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleFSunnah({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFSunnah = user["zFSunnah"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('fSunnah', isEqualTo: _currentUser.zFSunnah)
        .snapshots();
  }

  Future<void> addPilgrimage(
    String currentUserId,
    String zPilgrimage,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zPilgrimage': zPilgrimage});
  }

  Stream<QuerySnapshot> sortMalePilgrimage({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPilgrimage = user["zPilgrimage"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('pilgrimage', isEqualTo: _currentUser.zPilgrimage)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemalePilgrimage({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPilgrimage = user["zPilgrimage"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('pilgrimage', isEqualTo: _currentUser.zPilgrimage)
        .snapshots();
  }

  Future<void> addQuran(
    String currentUserId,
    String zQuranLevel,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zQuranLevel': zQuranLevel});
  }

  Stream<QuerySnapshot> sortMaleQuran({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zQuranLevel = user["zQuranLevel"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('quranLevel', isEqualTo: _currentUser.zQuranLevel)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleQuran({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zQuranLevel = user["zQuranLevel"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('quranLevel', isEqualTo: _currentUser.zQuranLevel)
        .snapshots();
  }

  Future<void> addEdu(
    String currentUserId,
    String zEducation,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zEducation': zEducation});
  }

  Stream<QuerySnapshot> sortMaleEdu({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zEducation = user["zEducation"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('education', isEqualTo: _currentUser.zEducation)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleEdu({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zEducation = user["zEducation"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('education', isEqualTo: _currentUser.zEducation)
        .snapshots();
  }

  Future<void> addMStatus(
    String currentUserId,
    String zMarriageStatus,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zMarriageStatus': zMarriageStatus});
  }

  Stream<QuerySnapshot> sortMaleMStatus({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zMarriageStatus = user["zMarriageStatus"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('marriageStatus', isEqualTo: _currentUser.zMarriageStatus)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleMStatus({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zMarriageStatus = user["zMarriageStatus"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('marriageStatus', isEqualTo: _currentUser.zMarriageStatus)
        .snapshots();
  }

  Future<void> addHKids(
    String currentUserId,
    String zHaveKids,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zHaveKids': zHaveKids});
  }

  Stream<QuerySnapshot> sortMaleHKids({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zHaveKids = user["zHaveKids"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('haveKids', isEqualTo: _currentUser.zHaveKids)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleHKids({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zHaveKids = user["zHaveKids"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('haveKids', isEqualTo: _currentUser.zHaveKids)
        .snapshots();
  }

  Future<void> addCPref(
    String currentUserId,
    String zChildPreference,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zChildPreference': zChildPreference});
  }

  Stream<QuerySnapshot> sortMaleCPref({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zChildPreference = user["zChildPreference"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('childPreference', isEqualTo: _currentUser.zChildPreference)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleCPref({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zChildPreference = user["zChildPreference"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('childPreference', isEqualTo: _currentUser.zChildPreference)
        .snapshots();
  }

  Future<void> addSRange(
    String currentUserId,
    String zSalaryRange,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zSalaryRange': zSalaryRange});
  }

  Stream<QuerySnapshot> sortMaleSRange({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSalaryRange = user["zSalaryRange"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('salaryRange', isEqualTo: _currentUser.zSalaryRange)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleSRange({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSalaryRange = user["zSalaryRange"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('salaryRange', isEqualTo: _currentUser.zSalaryRange)
        .snapshots();
  }

  Future<void> addFin(
    String currentUserId,
    String zFinancials,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zFinancials': zFinancials});
  }

  Stream<QuerySnapshot> sortMaleFin({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFinancials = user["zFinancials"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('financials', isEqualTo: _currentUser.zFinancials)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleFin({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zFinancials = user["zFinancials"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('financials', isEqualTo: _currentUser.zFinancials)
        .snapshots();
  }

  Future<void> addPersonality(
    String currentUserId,
    String zPersonality,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zPersonality': zPersonality});
  }

  Stream<QuerySnapshot> sortMalePersonality({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPersonality = user["zPersonality"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('personality', isEqualTo: _currentUser.zPersonality)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemalePersonality({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPersonality = user["zPersonality"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('personality', isEqualTo: _currentUser.zPersonality)
        .snapshots();
  }

  Future<void> addPets(
    String currentUserId,
    String zPets,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zPets': zPets});
  }

  Stream<QuerySnapshot> sortMalePets({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPets = user["zPets"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('pets', isEqualTo: _currentUser.zPets)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemalePets({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zPets = user["zPets"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('pets', isEqualTo: _currentUser.zPets)
        .snapshots();
  }

  Future<void> addSmoke(
    String currentUserId,
    String zSmoke,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zSmoke': zSmoke});
  }

  Stream<QuerySnapshot> sortMaleSmoke({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSmoke = user["zSmoke"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('smoke', isEqualTo: _currentUser.zSmoke)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleSmoke({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSmoke = user["zSmoke"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('smoke', isEqualTo: _currentUser.zSmoke)
        .snapshots();
  }

  Future<void> addTattoo(
    String currentUserId,
    String zTattoo,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zTattoo': zTattoo});
  }

  Stream<QuerySnapshot> sortMaleTattoo({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zTattoo = user["zTattoo"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('tattoo', isEqualTo: _currentUser.zTattoo)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleTattoo({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zTattoo = user["zTattoo"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('tattoo', isEqualTo: _currentUser.zTattoo)
        .snapshots();
  }

  Future<void> addTarget(
    String currentUserId,
    String zTarget,
  ) async {
    await _firestore
        .collection('users')
        .document(currentUserId)
        .updateData({'zTarget': zTarget});
  }

  Stream<QuerySnapshot> sortMaleTarget({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zTarget = user["zTarget"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('target', isEqualTo: _currentUser.zTarget)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleTarget({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zTarget = user["zTarget"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('target', isEqualTo: _currentUser.zTarget)
        .snapshots();
  }
  // simple search ends here

  Future<void> addAdvancedSearch(
    String currentUserId,
    String zSholat,
    String zSSunnah, //
    String zFasting,
    String zFSunnah, //
    String zPilgrimage,
    String zQuranLevel,
    String zEducation,
    String zMarriageStatus, //
    String zHaveKids, //
    String zChildPreference,
    String zSalaryRange, //
    String zFinancials,
    String zPersonality, //
    String zPets, //
    String zSmoke, //
    String zTattoo,
    String zTarget,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'zSholat': zSholat,
      'zSSunnah': zSSunnah,
      'zFasting': zFasting,
      'zFSunnah': zFSunnah,
      'zPilgrimage': zPilgrimage,
      'zQuranLevel': zQuranLevel,
      'zEducation': zEducation,
      'zMarriageStatus': zMarriageStatus,
      'zHaveKids': zHaveKids,
      'zChildPreference': zChildPreference,
      'zSalaryRange': zSalaryRange,
      'zFinancials': zFinancials,
      'zPersonality': zPersonality,
      'zPets': zPets,
      'zSmoke': zSmoke,
      'zTattoo': zTattoo,
      'zTarget': zTarget,
    });
  }

  Stream<QuerySnapshot> sortMaleAdvanced({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSholat = user["zSholat"];
      _currentUser.zSSunnah = user["zSSunnah"];
      _currentUser.zFasting = user["zFasting"];
      _currentUser.zFSunnah = user["zFSunnah"];
      _currentUser.zPilgrimage = user["zPilgrimage"];
      _currentUser.zQuranLevel = user["zQuranLevel"];
      _currentUser.zEducation = user["zEducation"];
      _currentUser.zMarriageStatus = user["zMarriageStatus"];
      _currentUser.zHaveKids = user["zHaveKids"];
      _currentUser.zChildPreference = user["zChildPreference"];
      _currentUser.zSalaryRange = user["zSalaryRange"];
      _currentUser.zFinancials = user["zFinancials"];
      _currentUser.zPersonality = user["zPersonality"];
      _currentUser.zPets = user["zPets"];
      _currentUser.zSmoke = user["zSmoke"];
      _currentUser.zTattoo = user["zTattoo"];
      _currentUser.zTarget = user["zTarget"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'gentleman')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sholat', isEqualTo: _currentUser.zSholat)
        .where('sSunnah', isEqualTo: _currentUser.zSSunnah)
        .where('fasting', isEqualTo: _currentUser.zFasting)
        .where('fSunnah', isEqualTo: _currentUser.zFSunnah)
        .where('pilgrimage', isEqualTo: _currentUser.zPilgrimage)
        .where('quranLevel', isEqualTo: _currentUser.zQuranLevel)
        .where('education', isEqualTo: _currentUser.zEducation)
        .where('marriageStatus', isEqualTo: _currentUser.zMarriageStatus)
        .where('haveKids', isEqualTo: _currentUser.zHaveKids)
        .where('childPreference', isEqualTo: _currentUser.zChildPreference)
        .where('salaryRange', isEqualTo: _currentUser.zSalaryRange)
        .where('financials', isEqualTo: _currentUser.zFinancials)
        .where('personality', isEqualTo: _currentUser.zPersonality)
        .where('pets', isEqualTo: _currentUser.zPets)
        .where('smoke', isEqualTo: _currentUser.zSmoke)
        .where('tattoo', isEqualTo: _currentUser.zTattoo)
        .where('target', isEqualTo: _currentUser.zTarget)
        .snapshots();
  }

  Stream<QuerySnapshot> sortFemaleAdvanced({userId}) async* {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.zSholat = user["zSholat"];
      _currentUser.zSSunnah = user["zSSunnah"];
      _currentUser.zFasting = user["zFasting"];
      _currentUser.zFSunnah = user["zFSunnah"];
      _currentUser.zPilgrimage = user["zPilgrimage"];
      _currentUser.zQuranLevel = user["zQuranLevel"];
      _currentUser.zEducation = user["zEducation"];
      _currentUser.zMarriageStatus = user["zMarriageStatus"];
      _currentUser.zHaveKids = user["zHaveKids"];
      _currentUser.zChildPreference = user["zChildPreference"];
      _currentUser.zSalaryRange = user["zSalaryRange"];
      _currentUser.zFinancials = user["zFinancials"];
      _currentUser.zPersonality = user["zPersonality"];
      _currentUser.zPets = user["zPets"];
      _currentUser.zSmoke = user["zSmoke"];
      _currentUser.zTattoo = user["zTattoo"];
      _currentUser.zTarget = user["zTarget"];
      _currentUser.province = user["province"];
    });
    yield* _firestore
        .collection('users')
        .where('gender', isEqualTo: 'lady')
        .where('accountType', isEqualTo: 'verified')
        .where('province', isEqualTo: _currentUser.province)
        .where('sholat', isEqualTo: _currentUser.zSholat)
        .where('sSunnah', isEqualTo: _currentUser.zSSunnah)
        .where('fasting', isEqualTo: _currentUser.zFasting)
        .where('fSunnah', isEqualTo: _currentUser.zFSunnah)
        .where('pilgrimage', isEqualTo: _currentUser.zPilgrimage)
        .where('quranLevel', isEqualTo: _currentUser.zQuranLevel)
        .where('education', isEqualTo: _currentUser.zEducation)
        .where('marriageStatus', isEqualTo: _currentUser.zMarriageStatus)
        .where('haveKids', isEqualTo: _currentUser.zHaveKids)
        .where('childPreference', isEqualTo: _currentUser.zChildPreference)
        .where('salaryRange', isEqualTo: _currentUser.zSalaryRange)
        .where('financials', isEqualTo: _currentUser.zFinancials)
        .where('personality', isEqualTo: _currentUser.zPersonality)
        .where('pets', isEqualTo: _currentUser.zPets)
        .where('smoke', isEqualTo: _currentUser.zSmoke)
        .where('tattoo', isEqualTo: _currentUser.zTattoo)
        .where('target', isEqualTo: _currentUser.zTarget)
        .snapshots();
  }

  Future<void> resetUserDefault(
    String currentUserId,
    // religion
    String sholat,
    String sSunnah,
    String fasting,
    String fSunnah,
    String pilgrimage,
    String quranLevel,
    // status
    String education,
    String marriageStatus,
    String haveKids,
    String childPreference,
    String salaryRange,
    String financials,
    // personal
    String personality,
    String pets,
    String smoke,
    String tattoo,
    String target,
  ) async {
    await _firestore.collection('users').document(currentUserId).updateData({
      'zSholat': sholat,
      'zSSunnah': sSunnah,
      'zFasting': fasting,
      'zFSunnah': fSunnah,
      'zPilgrimage': pilgrimage,
      'zQuranLevel': quranLevel,
      'zEducation': education,
      'zMarriageStatus': marriageStatus,
      'zHaveKids': haveKids,
      'zChildPreference': childPreference,
      'zSalaryRange': salaryRange,
      'zFinancials': financials,
      'zPersonality': personality,
      'zPets': pets,
      'zSmoke': smoke,
      'zTattoo': tattoo,
      'zTarget': target,
    });
  }
}
