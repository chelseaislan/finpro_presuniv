// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({
    FirebaseAuth firebaseAuth,
    Firestore firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  // START OF AUTHENTICATION //
  // to log in
  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // to check if the user logs in first time or not
  Future<bool> isFirstTime(String userId) async {
    bool exist;
    await Firestore.instance
        .collection('users')
        .document(userId)
        .get()
        .then((user) {
      return exist = user.exists;
    });
    return exist;
  }

  // to create a new account
  Future<void> signUpWithEmail(String email, String password) async {
    // ignore: avoid_print
    print(_firebaseAuth);
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // to sign out
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  // check if the app has a signed in user
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // END OF AUTHENTICATION //

  // START OF PROFILE SETUP 01, 15/41 6+3+9 //
  // Profile setup for CPF
  Future<void> profileSetup(
    String userId,
    String name, // only for this account's profile
    String gender, // no need to be shown
    String interestedIn, // no need to be shown
    File photo,
    File photoKtp,
    File photoOtherID,
    DateTime dob,
    int age,
    String location,
    String nickname,
    String currentJob,
    String jobPosition,
    String hobby,
    String aboutMe,
    // religion
    String sholat,
    String sSunnah,
    String fasting,
    String fSunnah,
    String pilgrimage,
    String quranLevel,
    // status
    String province,
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
    bool blurAvatar,
  ) async {
    StorageUploadTask uploadAvatar, uploadKtp, uploadOtherID;
    uploadAvatar = FirebaseStorage.instance
        .ref()
        .child('userPhotos') // create folder userPhotos
        .child(userId) // create folder with uid as the name
        .child('avatar_$name') // name of the file
        .putFile(photo);
    uploadKtp = FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .child('ktp_$name')
        .putFile(photoKtp);
    uploadOtherID = FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .child('otherID_$name')
        .putFile(photoOtherID);

// use Array Profile
    return await uploadAvatar.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        return await uploadKtp.onComplete.then((ref) async {
          await ref.ref.getDownloadURL().then((urlKtp) async {
            return await uploadOtherID.onComplete.then((ref) async {
              await ref.ref.getDownloadURL().then((urlOtherID) async {
                await _firestore.collection('users').document(userId).setData({
                  'uid': userId,
                  'photoUrl': url,
                  'photoKtp': urlKtp,
                  'photoOtherID': urlOtherID,
                  'name': name,
                  'location': location,
                  'gender': gender,
                  'interestedIn': interestedIn,
                  'dob': dob,
                  'age': age,
                  'nickname': nickname,
                  'currentJob': currentJob,
                  'jobPosition': jobPosition,
                  'hobby': hobby,
                  'aboutMe': aboutMe,
                  'accountType': "verifying document",
                  'sholat': sholat,
                  'sSunnah': sSunnah,
                  'fasting': fasting,
                  'fSunnah': fSunnah,
                  'pilgrimage': pilgrimage,
                  'quranLevel': quranLevel,
                  'province': province,
                  'education': education,
                  'marriageStatus': marriageStatus,
                  'haveKids': haveKids,
                  'childPreference': childPreference,
                  'salaryRange': salaryRange,
                  'financials': financials,
                  'personality': personality,
                  'pets': pets,
                  'smoke': smoke,
                  'tattoo': tattoo,
                  'target': target,
                  'marriageA': null,
                  'marriageB': null,
                  'marriageC': null,
                  'marriageD': null,
                  'taarufWith': null,
                  'taarufCheck': 0,
                  'blurAvatar': blurAvatar,
                  'userChosen': [],
                  'userSelected': [],
                  'userMatched': [],
                  // for rating
                  'yAppRating': 0,
                  'yExpRating': 0,
                  'ySuggestionRating': "",
                  // for search (simple & advanced)
                  'zNickname': null,
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
                  'highlights': [],
                  'verifiedBy': null,
                });
              });
            });
          });
        });
      });
    });
  }

  // END OF PROFILE SETUP 01 //

  // Additional, getProfile = getUserInterests //
  // 6+3+9
  Future<User> getProfile(userId) async {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.uid = user['uid'];
      _currentUser.photo = user['photoUrl'];
      _currentUser.photoKtp = user['photoKtp'];
      _currentUser.photoOtherID = user['photoOtherID'];
      _currentUser.name = user['name'];
      _currentUser.location = user['location'];
      _currentUser.gender = user['gender'];
      _currentUser.interestedIn = user['interestedIn'];
      _currentUser.dob = user['dob'];
      _currentUser.age = user['age'];
      _currentUser.nickname = user['nickname'];
      _currentUser.currentJob = user['currentJob'];
      _currentUser.jobPosition = user['jobPosition'];
      _currentUser.hobby = user['hobby'];
      _currentUser.aboutMe = user['aboutMe'];
      _currentUser.accountType = user['accountType'];
      _currentUser.sholat = user['sholat'];
      _currentUser.sSunnah = user['sSunnah'];
      _currentUser.fasting = user['fasting'];
      _currentUser.fSunnah = user['fSunnah'];
      _currentUser.pilgrimage = user['pilgrimage'];
      _currentUser.quranLevel = user['quranLevel'];
      _currentUser.province = user['province'];
      _currentUser.education = user['education'];
      _currentUser.marriageStatus = user['marriageStatus'];
      _currentUser.haveKids = user['haveKids'];
      _currentUser.childPreference = user['childPreference'];
      _currentUser.salaryRange = user['salaryRange'];
      _currentUser.financials = user['financials'];
      _currentUser.personality = user['personality'];
      _currentUser.pets = user['pets'];
      _currentUser.smoke = user['smoke'];
      _currentUser.tattoo = user['tattoo'];
      _currentUser.target = user['target'];
      _currentUser.marriageA = user['marriageA'];
      _currentUser.marriageB = user['marriageB'];
      _currentUser.marriageC = user['marriageC'];
      _currentUser.marriageD = user['marriageD'];
      _currentUser.taarufWith = user['taarufWith'];
      _currentUser.taarufChecklist = user['taarufCheck'];
      _currentUser.blurAvatar = user['blurAvatar'];
      _currentUser.userChosen = user['userChosen'];
      _currentUser.userSelected = user['userSelected'];
      _currentUser.userMatched = user['userMatched'];
      _currentUser.yAppRating = user['yAppRating'];
      _currentUser.yExpRating = user['yExpRating'];
      _currentUser.ySuggestionRating = user['ySuggestionRating'];
    });
    return _currentUser;
  }

  Future<User> resetTaaruf(userId) async {
    await _firestore.collection('users').document(userId).updateData({
      'accountType': "verified",
      'taarufWith': null,
      'taarufCheck': 0,
      'marriageA': null,
      'marriageB': null,
      'marriageC': null,
      'marriageD': null,
    });
    return getProfile(userId);
  }

  Future<User> submitRating(
    userId,
    yAppRating,
    yExpRating,
    ySuggestionRating,
  ) async {
    await _firestore.collection('users').document(userId).updateData({
      'yAppRating': yAppRating,
      'yExpRating': yExpRating,
      'ySuggestionRating': ySuggestionRating,
    });
    return getProfile(userId);
  }

  // upload a story
  Future<User> uploadStory({
    String userId,
    int counter,
    File story,
  }) async {
    StorageUploadTask uploadStory;
    uploadStory = FirebaseStorage.instance
        .ref()
        .child('userStories') // create folder userPhotos
        .child(userId) // create folder with uid as the name
        .child('story_$counter') // name of the file
        .putFile(story);
    uploadStory.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((urlStory) async {
        await _firestore.collection('users').document(userId).updateData({
          'highlights': FieldValue.arrayUnion([urlStory]),
        });
      });
    });
    return getProfile(userId);
  }
}
