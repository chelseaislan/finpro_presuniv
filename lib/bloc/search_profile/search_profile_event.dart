// @dart=2.9
// Start of SearchProfileEvent
import 'package:equatable/equatable.dart';

abstract class SearchProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchLoadUserEvent extends SearchProfileEvent {
  final String userId;
  SearchLoadUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

// simple search starts
class SearchByNicknameEvent extends SearchProfileEvent {
  final String userId;
  final String zNickname;
  SearchByNicknameEvent({this.userId, this.zNickname});

  @override
  List<Object> get props => [userId, zNickname];
}

class SearchBySholatEvent extends SearchProfileEvent {
  final String userId;
  final String zSholat;
  SearchBySholatEvent({this.userId, this.zSholat});

  @override
  List<Object> get props => [userId, zSholat];
}

class SearchBySSunnahEvent extends SearchProfileEvent {
  final String userId;
  final String zSSunnah;
  SearchBySSunnahEvent({this.userId, this.zSSunnah});

  @override
  List<Object> get props => [userId, zSSunnah];
}

class SearchByFastingEvent extends SearchProfileEvent {
  final String userId;
  final String zFasting;
  SearchByFastingEvent({this.userId, this.zFasting});

  @override
  List<Object> get props => [userId, zFasting];
}

class SearchByFSunnahEvent extends SearchProfileEvent {
  final String userId;
  final String zFSunnah;
  SearchByFSunnahEvent({this.userId, this.zFSunnah});

  @override
  List<Object> get props => [userId, zFSunnah];
}

class SearchByPilgrimageEvent extends SearchProfileEvent {
  final String userId;
  final String zPilgrimage;
  SearchByPilgrimageEvent({this.userId, this.zPilgrimage});

  @override
  List<Object> get props => [userId, zPilgrimage];
}

class SearchByQuranEvent extends SearchProfileEvent {
  final String userId;
  final String zQuranLevel;
  SearchByQuranEvent({this.userId, this.zQuranLevel});

  @override
  List<Object> get props => [userId, zQuranLevel];
}

class SearchByEduEvent extends SearchProfileEvent {
  final String userId;
  final String zEducation;
  SearchByEduEvent({this.userId, this.zEducation});

  @override
  List<Object> get props => [userId, zEducation];
}

class SearchByMStatusEvent extends SearchProfileEvent {
  final String userId;
  final String zMarriageStatus;
  SearchByMStatusEvent({this.userId, this.zMarriageStatus});

  @override
  List<Object> get props => [userId, zMarriageStatus];
}

class SearchByHKidsEvent extends SearchProfileEvent {
  final String userId;
  final String zHaveKids;
  SearchByHKidsEvent({this.userId, this.zHaveKids});

  @override
  List<Object> get props => [userId, zHaveKids];
}

class SearchByCPrefEvent extends SearchProfileEvent {
  final String userId;
  final String zChildPreference;
  SearchByCPrefEvent({this.userId, this.zChildPreference});

  @override
  List<Object> get props => [userId, zChildPreference];
}

class SearchBySRangeEvent extends SearchProfileEvent {
  final String userId;
  final String zSalaryRange;
  SearchBySRangeEvent({this.userId, this.zSalaryRange});

  @override
  List<Object> get props => [userId, zSalaryRange];
}

class SearchByFinEvent extends SearchProfileEvent {
  final String userId;
  final String zFinancials;
  SearchByFinEvent({this.userId, this.zFinancials});

  @override
  List<Object> get props => [userId, zFinancials];
}

class SearchByPersonalityEvent extends SearchProfileEvent {
  final String userId;
  final String zPersonality;
  SearchByPersonalityEvent({this.userId, this.zPersonality});

  @override
  List<Object> get props => [userId, zPersonality];
}

class SearchByPetsEvent extends SearchProfileEvent {
  final String userId;
  final String zPets;
  SearchByPetsEvent({this.userId, this.zPets});

  @override
  List<Object> get props => [userId, zPets];
}

class SearchBySmokeEvent extends SearchProfileEvent {
  final String userId;
  final String zSmoke;
  SearchBySmokeEvent({this.userId, this.zSmoke});

  @override
  List<Object> get props => [userId, zSmoke];
}

class SearchByTattooEvent extends SearchProfileEvent {
  final String userId;
  final String zTattoo;
  SearchByTattooEvent({this.userId, this.zTattoo});

  @override
  List<Object> get props => [userId, zTattoo];
}

class SearchByTargetEvent extends SearchProfileEvent {
  final String userId;
  final String zTarget;
  SearchByTargetEvent({this.userId, this.zTarget});

  @override
  List<Object> get props => [userId, zTarget];
}
// simple search ends

// advanced search
class AdvancedSearchEvent extends SearchProfileEvent {
  final String userId,
      zSholat,
      zSSunnah, //
      zFasting,
      zFSunnah, //
      zPilgrimage,
      zQuranLevel,
      zEducation,
      zMarriageStatus, //
      zHaveKids, //
      zChildPreference,
      zSalaryRange, //
      zFinancials,
      zPersonality, //
      zPets, //
      zSmoke, //
      zTattoo, //
      zTarget;
  AdvancedSearchEvent({
    this.userId,
    this.zSholat,
    this.zSSunnah,
    this.zFasting,
    this.zFSunnah,
    this.zPilgrimage,
    this.zQuranLevel,
    this.zEducation,
    this.zMarriageStatus,
    this.zHaveKids,
    this.zChildPreference,
    this.zSalaryRange,
    this.zFinancials,
    this.zPersonality,
    this.zPets,
    this.zSmoke,
    this.zTattoo,
    this.zTarget,
  });

  @override
  List<Object> get props => [
        userId,
        zSholat,
        zSSunnah,
        zFasting,
        zFSunnah,
        zPilgrimage,
        zQuranLevel,
        zEducation,
        zMarriageStatus,
        zHaveKids,
        zChildPreference,
        zSalaryRange,
        zFinancials,
        zPersonality,
        zPets,
        zSmoke,
        zTattoo,
        zTarget,
      ];
}

class SearchLikeUserEvent extends SearchProfileEvent {
  final String currentUserId, selectedUserId, nickname, photoUrl;
  final int age;
  final bool blurAvatar;
  final List<String> userChosen, userSelected; // for search page
  SearchLikeUserEvent({
    this.currentUserId,
    this.selectedUserId,
    this.nickname,
    this.photoUrl,
    this.age,
    this.blurAvatar,
    this.userChosen,
    this.userSelected,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        nickname,
        photoUrl,
        age,
        blurAvatar,
        userChosen,
        userSelected,
      ];
}

class SearchDislikeUserEvent extends SearchProfileEvent {
  final String currentUserId, selectedUserId;
  final List<String> userChosen, userSelected;
  SearchDislikeUserEvent({
    this.currentUserId,
    this.selectedUserId,
    this.userChosen,
    this.userSelected,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        userChosen,
        userSelected,
      ];
}

// Reset to user's default
class ResetUserDefaultEvent extends SearchProfileEvent {
  final String currentUserId;
  // religion
  final String sholat;
  final String sSunnah;
  final String fasting;
  final String fSunnah;
  final String pilgrimage;
  final String quranLevel;
  // status
  final String education;
  final String marriageStatus;
  final String haveKids;
  final String childPreference;
  final String salaryRange;
  final String financials;
  // personal
  final String personality;
  final String pets;
  final String smoke;
  final String tattoo;
  final String target;
  ResetUserDefaultEvent({
    this.currentUserId,
    this.sholat,
    this.sSunnah,
    this.fasting,
    this.fSunnah,
    this.pilgrimage,
    this.quranLevel,
    this.education,
    this.marriageStatus,
    this.haveKids,
    this.childPreference,
    this.salaryRange,
    this.financials,
    this.personality,
    this.pets,
    this.smoke,
    this.tattoo,
    this.target,
  });

  @override
  List<Object> get props => [
        currentUserId,
        sholat,
        sSunnah,
        fasting,
        fSunnah,
        pilgrimage,
        quranLevel,
        education,
        marriageStatus,
        haveKids,
        childPreference,
        salaryRange,
        financials,
        personality,
        pets,
        smoke,
        tattoo,
        target,
      ];
}
