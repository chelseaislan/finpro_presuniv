// @dart=2.9
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 03 16/41 //
// define 33 profile events
abstract class CompleteProfileEvent extends Equatable {
  const CompleteProfileEvent();

  @override
  List<Object> get props => [];
}

class PhotoChanged extends CompleteProfileEvent {
  final File photo;
  const PhotoChanged({@required this.photo});
  @override
  List<Object> get props => [photo];
}

class PhotoKtpChanged extends CompleteProfileEvent {
  final File photoKtp;
  const PhotoKtpChanged({@required this.photoKtp});
  @override
  List<Object> get props => [photoKtp];
}

class PhotoIDChanged extends CompleteProfileEvent {
  final File photoOtherID;
  const PhotoIDChanged({@required this.photoOtherID});
  @override
  List<Object> get props => [photoOtherID];
}

class NameChanged extends CompleteProfileEvent {
  final String name;
  const NameChanged({@required this.name});
  @override
  List<Object> get props => [name];
}

class DobChanged extends CompleteProfileEvent {
  final DateTime dob;
  const DobChanged({@required this.dob});
  @override
  List<Object> get props => [dob];
}

class AgeChanged extends CompleteProfileEvent {
  final int age;
  const AgeChanged({@required this.age});
  @override
  List<Object> get props => [age];
}

class GenderChanged extends CompleteProfileEvent {
  final String gender;
  const GenderChanged({@required this.gender});
  @override
  List<Object> get props => [gender];
}

class InterestedInChanged extends CompleteProfileEvent {
  final String isInterestedIn;
  const InterestedInChanged({@required this.isInterestedIn});
  @override
  List<Object> get props => [isInterestedIn];
}

class LocationChanged extends CompleteProfileEvent {
  final String location;
  const LocationChanged({@required this.location});
  @override
  List<Object> get props => [location];
}

class NicknameChanged extends CompleteProfileEvent {
  final String nickname;
  const NicknameChanged({@required this.nickname});
  @override
  List<Object> get props => [nickname];
}

class CurrentJobChanged extends CompleteProfileEvent {
  final String currentJob;
  const CurrentJobChanged({@required this.currentJob});
  @override
  List<Object> get props => [currentJob];
}

class JobPositionChanged extends CompleteProfileEvent {
  final String jobPosition;
  const JobPositionChanged({@required this.jobPosition});
  @override
  List<Object> get props => [jobPosition];
}

class HobbyChanged extends CompleteProfileEvent {
  final String hobby;
  const HobbyChanged({@required this.hobby});
  @override
  List<Object> get props => [hobby];
}

class AboutMeChanged extends CompleteProfileEvent {
  final String aboutMe;
  const AboutMeChanged({@required this.aboutMe});
  @override
  List<Object> get props => [aboutMe];
}

class SholatChanged extends CompleteProfileEvent {
  // list
  final String sholat;
  const SholatChanged({@required this.sholat});
  @override
  List<Object> get props => [sholat];
}

class SSunnahChanged extends CompleteProfileEvent {
  // list
  final String sSunnah;
  const SSunnahChanged({@required this.sSunnah});
  @override
  List<Object> get props => [sSunnah];
}

class FastingChanged extends CompleteProfileEvent {
  // list
  final String fasting;
  const FastingChanged({@required this.fasting});
  @override
  List<Object> get props => [fasting];
}

class FSunnahChanged extends CompleteProfileEvent {
  // list
  final String fSunnah;
  const FSunnahChanged({@required this.fSunnah});
  @override
  List<Object> get props => [fSunnah];
}

class PilgrimageChanged extends CompleteProfileEvent {
  // list
  final String pilgrimage;
  const PilgrimageChanged({@required this.pilgrimage});
  @override
  List<Object> get props => [pilgrimage];
}

class QuranLevelChanged extends CompleteProfileEvent {
  // list
  final String quranLevel;
  const QuranLevelChanged({@required this.quranLevel});
  @override
  List<Object> get props => [quranLevel];
}

class ProvinceChanged extends CompleteProfileEvent {
  // list
  final String province;
  const ProvinceChanged({@required this.province});
  @override
  List<Object> get props => [province];
}

class EducationChanged extends CompleteProfileEvent {
  // list
  final String education;
  const EducationChanged({@required this.education});
  @override
  List<Object> get props => [education];
}

class MarriageStatusChanged extends CompleteProfileEvent {
  // list
  final String marriageStatus;
  const MarriageStatusChanged({@required this.marriageStatus});
  @override
  List<Object> get props => [marriageStatus];
}

class HaveKidsChanged extends CompleteProfileEvent {
  // list
  final String haveKids;
  const HaveKidsChanged({@required this.haveKids});
  @override
  List<Object> get props => [haveKids];
}

class ChildPreferenceChanged extends CompleteProfileEvent {
  // list
  final String childPreference;
  const ChildPreferenceChanged({@required this.childPreference});
  @override
  List<Object> get props => [childPreference];
}

class SalaryRangeChanged extends CompleteProfileEvent {
  // list
  final String salaryRange;
  const SalaryRangeChanged({@required this.salaryRange});
  @override
  List<Object> get props => [salaryRange];
}

class FinancialsChanged extends CompleteProfileEvent {
  // list
  final String financials;
  const FinancialsChanged({@required this.financials});
  @override
  List<Object> get props => [financials];
}

class PersonalityChanged extends CompleteProfileEvent {
  // list
  final String personality;
  const PersonalityChanged({@required this.personality});
  @override
  List<Object> get props => [personality];
}

class PetsChanged extends CompleteProfileEvent {
  // list
  final String pets;
  const PetsChanged({@required this.pets});
  @override
  List<Object> get props => [pets];
}

class SmokeChanged extends CompleteProfileEvent {
  // list
  final String smoke;
  const SmokeChanged({@required this.smoke});
  @override
  List<Object> get props => [smoke];
}

class TattooChanged extends CompleteProfileEvent {
  // list
  final String tattoo;
  const TattooChanged({@required this.tattoo});
  @override
  List<Object> get props => [tattoo];
}

class TargetChanged extends CompleteProfileEvent {
  // list
  final String target;
  const TargetChanged({@required this.target});
  @override
  List<Object> get props => [target];
}

class BlurChanged extends CompleteProfileEvent {
  // list
  final bool blurAvatar;
  const BlurChanged({@required this.blurAvatar});
  @override
  List<Object> get props => [blurAvatar];
}

// declare all the 6 default + (3) additional variables + 9 lists
class Submitted extends CompleteProfileEvent {
  final String name,
      gender,
      interestedIn,
      location,
      nickname,
      currentJob,
      jobPosition, //
      hobby,
      aboutMe,
      sholat,
      sSunnah, //
      fasting,
      fSunnah, //
      pilgrimage,
      quranLevel,
      province,
      education,
      marriageStatus, //
      haveKids, //
      childPreference,
      salaryRange, //
      financials,
      personality, //
      pets, //
      smoke, //
      tattoo, //
      target;
  final DateTime dob;
  final int age;
  final File photo, photoKtp, photoOtherID;
  final bool blurAvatar;

  const Submitted({
    @required this.name,
    @required this.gender,
    @required this.interestedIn,
    @required this.location,
    @required this.nickname,
    @required this.currentJob,
    @required this.jobPosition,
    @required this.hobby,
    @required this.aboutMe,
    @required this.dob,
    @required this.age,
    @required this.photo,
    @required this.photoKtp,
    @required this.photoOtherID,
    @required this.sholat,
    @required this.sSunnah,
    @required this.fasting,
    @required this.fSunnah,
    @required this.pilgrimage,
    @required this.quranLevel,
    @required this.province,
    @required this.education,
    @required this.marriageStatus,
    @required this.haveKids,
    @required this.childPreference,
    @required this.salaryRange,
    @required this.financials,
    @required this.personality,
    @required this.pets,
    @required this.smoke,
    @required this.tattoo,
    @required this.target,
    @required this.blurAvatar,
  });

  @override
  List<Object> get props => [
        name,
        gender,
        interestedIn,
        nickname,
        currentJob,
        jobPosition,
        hobby,
        aboutMe,
        dob,
        age,
        location,
        photo,
        photoKtp,
        photoOtherID,
        sholat,
        sSunnah,
        fasting,
        fSunnah,
        pilgrimage,
        quranLevel,
        province,
        education,
        marriageStatus,
        haveKids,
        childPreference,
        salaryRange,
        financials,
        personality, //
        pets, //
        smoke, //
        tattoo, //
        target,
        blurAvatar,
      ];
}

// END OF PROFILE SETUP 03 16/41 //