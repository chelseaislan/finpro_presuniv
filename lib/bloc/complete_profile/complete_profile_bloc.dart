// @dart=2.9
import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finpro_max/bloc/complete_profile/bloc.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 04 16/41 //
class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  UserRepository _userRepository;

  CompleteProfileBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  // implement initialState
  CompleteProfileState get initialState =>
      CompleteProfileState.empty(); // CompleteProfileState.empty

  @override
  Stream<CompleteProfileState> mapEventToState(
      CompleteProfileEvent event) async* {
    // implement mapEventToState
    if (event is NameChanged) {
      yield* _mapName(event.name);
    } else if (event is DobChanged) {
      yield* _mapDob(event.dob);
    } else if (event is AgeChanged) {
      yield* _mapAge(event.age);
    } else if (event is GenderChanged) {
      yield* _mapGender(event.gender);
    } else if (event is InterestedInChanged) {
      yield* _mapInterestedIn(event.isInterestedIn);
    } else if (event is LocationChanged) {
      yield* _mapLocation(event.location);
    } else if (event is PhotoChanged) {
      yield* _mapPhoto(event.photo);
    } else if (event is PhotoKtpChanged) {
      yield* _mapPhotoKtp(event.photoKtp);
    } else if (event is PhotoIDChanged) {
      yield* _mapPhotoOtherID(event.photoOtherID);
    } else if (event is NicknameChanged) {
      yield* _mapNickname(event.nickname);
    } else if (event is CurrentJobChanged) {
      yield* _mapCurrentJob(event.currentJob);
    } else if (event is JobPositionChanged) {
      yield* _mapJobPosition(event.jobPosition);
    } else if (event is HobbyChanged) {
      yield* _mapHobby(event.hobby);
    } else if (event is AboutMeChanged) {
      yield* _mapAboutMe(event.aboutMe);
    } else if (event is SholatChanged) {
      yield* _mapSholat(event.sholat);
    } else if (event is SSunnahChanged) {
      yield* _mapSSunnah(event.sSunnah);
    } else if (event is FastingChanged) {
      yield* _mapFasting(event.fasting);
    } else if (event is FSunnahChanged) {
      yield* _mapFSunnah(event.fSunnah);
    } else if (event is PilgrimageChanged) {
      yield* _mapPilgrimage(event.pilgrimage);
    } else if (event is QuranLevelChanged) {
      yield* _mapQuranLevel(event.quranLevel);
    } else if (event is ProvinceChanged) {
      yield* _mapProvince(event.province);
    } else if (event is EducationChanged) {
      yield* _mapEducation(event.education);
    } else if (event is MarriageStatusChanged) {
      yield* _mapMarriageStatus(event.marriageStatus);
    } else if (event is HaveKidsChanged) {
      yield* _mapHaveKids(event.haveKids);
    } else if (event is ChildPreferenceChanged) {
      yield* _mapChildPreference(event.childPreference);
    } else if (event is SalaryRangeChanged) {
      yield* _mapSalaryRange(event.salaryRange);
    } else if (event is FinancialsChanged) {
      yield* _mapFinancials(event.financials);
    } else if (event is PersonalityChanged) {
      yield* _mapPersonality(event.personality);
    } else if (event is PetsChanged) {
      yield* _mapPets(event.pets);
    } else if (event is SmokeChanged) {
      yield* _mapSmoke(event.smoke);
    } else if (event is TattooChanged) {
      yield* _mapTattoo(event.tattoo);
    } else if (event is TargetChanged) {
      yield* _mapTarget(event.target);
    } else if (event is BlurChanged) {
      yield* _mapBlur(event.blurAvatar);
    } else if (event is Submitted) {
      final uid = await _userRepository.getUser();
      yield* _mapSubmittedToState(
        photo: event.photo,
        photoKtp: event.photoKtp,
        photoOtherID: event.photoOtherID,
        name: event.name,
        userId: uid,
        dob: event.dob,
        age: event.age,
        location: event.location,
        interestedIn: event.interestedIn,
        gender: event.gender,
        nickname: event.nickname,
        currentJob: event.currentJob,
        jobPosition: event.jobPosition,
        hobby: event.hobby,
        aboutMe: event.aboutMe,
        sholat: event.sholat,
        sSunnah: event.sSunnah,
        fasting: event.fasting,
        fSunnah: event.fSunnah,
        pilgrimage: event.pilgrimage,
        quranLevel: event.quranLevel,
        province: event.province,
        education: event.education,
        marriageStatus: event.marriageStatus,
        haveKids: event.haveKids,
        childPreference: event.childPreference,
        salaryRange: event.salaryRange,
        financials: event.financials,
        personality: event.personality,
        pets: event.pets,
        smoke: event.smoke,
        tattoo: event.tattoo,
        target: event.target,
        blurAvatar: event.blurAvatar,
      );
    }
  }

  // create all the 6+3+9 methods
  Stream<CompleteProfileState> _mapName(String name) async* {
    yield state.update(isNameEmpty: name == null);
  }

  Stream<CompleteProfileState> _mapDob(DateTime dob) async* {
    yield state.update(isAgeEmpty: dob == null);
  }

  Stream<CompleteProfileState> _mapAge(int age) async* {
    yield state.update(isAgeEmpty: age == null);
  }

  Stream<CompleteProfileState> _mapGender(String gender) async* {
    yield state.update(isGenderEmpty: gender == null);
  }

  Stream<CompleteProfileState> _mapInterestedIn(String interestedIn) async* {
    yield state.update(isInterestedInEmpty: interestedIn == null);
  }

  Stream<CompleteProfileState> _mapLocation(String location) async* {
    yield state.update(isLocationEmpty: location == null);
  }

  Stream<CompleteProfileState> _mapPhoto(File photo) async* {
    yield state.update(isPhotoEmpty: photo == null);
  }

  Stream<CompleteProfileState> _mapNickname(String nickname) async* {
    yield state.update(isNicknameEmpty: nickname == null);
  }

  Stream<CompleteProfileState> _mapCurrentJob(String currentJob) async* {
    yield state.update(isCurrentJobEmpty: currentJob == null);
  }

  Stream<CompleteProfileState> _mapSholat(String sholat) async* {
    yield state.update(isSholatListEmpty: sholat == null);
  }

  Stream<CompleteProfileState> _mapFasting(String fasting) async* {
    yield state.update(isFastingListEmpty: fasting == null);
  }

  Stream<CompleteProfileState> _mapPilgrimage(String pilgrimage) async* {
    yield state.update(isPilgrimageListEmpty: pilgrimage == null);
  }

  Stream<CompleteProfileState> _mapQuranLevel(String quranLevel) async* {
    yield state.update(isQuranLevelListEmpty: quranLevel == null);
  }

  Stream<CompleteProfileState> _mapProvince(String province) async* {
    yield state.update(isProvinceEmpty: province == null);
  }

  Stream<CompleteProfileState> _mapEducation(String education) async* {
    yield state.update(isEduListEmpty: education == null);
  }

  Stream<CompleteProfileState> _mapChildPreference(
      String childPreference) async* {
    yield state.update(isChildPrefListEmpty: childPreference == null);
  }

  Stream<CompleteProfileState> _mapFinancials(String financials) async* {
    yield state.update(isFinancialsListEmpty: financials == null);
  }

  Stream<CompleteProfileState> _mapPhotoKtp(File photoKtp) async* {
    yield state.update(isPhotoKtpEmpty: photoKtp == null);
  }

  Stream<CompleteProfileState> _mapPhotoOtherID(File photoOtherID) async* {
    yield state.update(isPhotoOtherIDEmpty: photoOtherID == null);
  }

  Stream<CompleteProfileState> _mapJobPosition(String jobPosition) async* {
    yield state.update(isJobPositionEmpty: jobPosition == null);
  }

  Stream<CompleteProfileState> _mapHobby(String hobby) async* {
    yield state.update(isHobbyEmpty: hobby == null);
  }

  Stream<CompleteProfileState> _mapAboutMe(String aboutMe) async* {
    yield state.update(isAboutEmpty: aboutMe == null);
  }

  Stream<CompleteProfileState> _mapSSunnah(String sSunnah) async* {
    yield state.update(isSSunnahEmpty: sSunnah == null);
  }

  Stream<CompleteProfileState> _mapFSunnah(String fSunnah) async* {
    yield state.update(isFSunnahEmpty: fSunnah == null);
  }

  Stream<CompleteProfileState> _mapMarriageStatus(
      String marriageStatus) async* {
    yield state.update(isMarriageStatusEmpty: marriageStatus == null);
  }

  Stream<CompleteProfileState> _mapHaveKids(String haveKids) async* {
    yield state.update(isHaveKidsEmpty: haveKids == null);
  }

  Stream<CompleteProfileState> _mapSalaryRange(String salaryRange) async* {
    yield state.update(isSalaryRangeEmpty: salaryRange == null);
  }

  Stream<CompleteProfileState> _mapPersonality(String personality) async* {
    yield state.update(isPersonalityEmpty: personality == null);
  }

  Stream<CompleteProfileState> _mapPets(String pets) async* {
    yield state.update(isPetsEmpty: pets == null);
  }

  Stream<CompleteProfileState> _mapSmoke(String smoke) async* {
    yield state.update(isSmokeEmpty: smoke == null);
  }

  Stream<CompleteProfileState> _mapTattoo(String tattoo) async* {
    yield state.update(isTattooEmpty: tattoo == null);
  }

  Stream<CompleteProfileState> _mapTarget(String target) async* {
    yield state.update(isTargetEmpty: target == null);
  }

  Stream<CompleteProfileState> _mapBlur(bool blurAvatar) async* {
    yield state.update(isBlurEmpty: blurAvatar == null);
  }

  Stream<CompleteProfileState> _mapSubmittedToState({
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
    // 6 religion
    String sholat,
    String sSunnah, //
    String fasting,
    String fSunnah, //
    String pilgrimage,
    String quranLevel,
    // 6 status
    String province,
    String education,
    String marriageStatus, //
    String haveKids, //
    String childPreference,
    String salaryRange,
    String financials,
    // 4 personal
    String personality,
    String pets,
    String smoke,
    String tattoo,
    String target,
    // to be deleted
    bool blurAvatar,
  }) async* {
    yield CompleteProfileState.loading();
    try {
      // Profile Setup 01, urutan harus sama spt profileSetup
      await _userRepository.profileSetup(
        userId,
        name, // only for this account's profile
        gender, // no need to be shown
        interestedIn, // no need to be shown
        photo,
        photoKtp,
        photoOtherID,
        dob,
        age,
        location,
        nickname,
        currentJob,
        jobPosition,
        hobby,
        aboutMe,
        // 6 religion
        sholat,
        sSunnah, //
        fasting,
        fSunnah, //
        pilgrimage,
        quranLevel,
        // 6 details
        province,
        education,
        marriageStatus, //
        haveKids, //
        childPreference,
        salaryRange, //
        financials,
        // 4 personal
        personality, //
        pets, //
        smoke, //
        tattoo, //
        target,
        // others
        blurAvatar,
      );
      yield CompleteProfileState.success();
    } catch (_) {
      yield CompleteProfileState.failure();
    }
  }
}
// END OF PROFILE SETUP 04 16/41 //
// STATE -> EVENT -> BLOC (GOING UP)