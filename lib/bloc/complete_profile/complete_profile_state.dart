// @dart=2.9
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 02 15/41 //

// declare first
@immutable
class CompleteProfileState {
  final bool isPhotoEmpty;
  final bool isNameEmpty;
  final bool isDobEmpty;
  final bool isAgeEmpty;
  final bool isGenderEmpty;
  final bool isInterestedInEmpty;
  final bool isLocationEmpty; // 6 default + 3 additional + 9 lists
  final bool isNicknameEmpty; // additional
  final bool isCurrentJobEmpty; // additional
  final bool isSholatListEmpty;
  final bool isFastingListEmpty;
  final bool isPilgrimageListEmpty;
  final bool isQuranLevelListEmpty;
  final bool isProvinceEmpty;
  final bool isEduListEmpty;
  final bool isChildPrefListEmpty;
  final bool isFinancialsListEmpty;
  final bool isPhotoKtpEmpty;
  final bool isPhotoOtherIDEmpty;
  final bool isJobPositionEmpty;
  final bool isHobbyEmpty;
  final bool isAboutEmpty;
  final bool isSSunnahEmpty;
  final bool isFSunnahEmpty;
  final bool isMarriageStatusEmpty;
  final bool isHaveKidsEmpty;
  final bool isSalaryRangeEmpty;
  final bool isPersonalityEmpty;
  final bool isPetsEmpty;
  final bool isSmokeEmpty;
  final bool isTattooEmpty;
  final bool isTargetEmpty;
  final bool isBlurEmpty;
  final bool isFailure;
  final bool isSubmitting;
  final bool isSuccess;

  // declare what makes form valid
  bool get isFormValid =>
      isPhotoEmpty &&
      isNameEmpty &&
      isDobEmpty &&
      isAgeEmpty &&
      isGenderEmpty &&
      isInterestedInEmpty &&
      isLocationEmpty &&
      isNicknameEmpty && // additional
      isCurrentJobEmpty && // additional
      isSholatListEmpty &&
      isFastingListEmpty &&
      isPilgrimageListEmpty &&
      isProvinceEmpty &&
      isEduListEmpty &&
      isQuranLevelListEmpty &&
      isChildPrefListEmpty &&
      isFinancialsListEmpty &&
      isPhotoKtpEmpty &&
      isPhotoOtherIDEmpty &&
      isJobPositionEmpty &&
      isHobbyEmpty &&
      isAboutEmpty &&
      isSSunnahEmpty &&
      isFSunnahEmpty &&
      isMarriageStatusEmpty &&
      isHaveKidsEmpty &&
      isSalaryRangeEmpty &&
      isPersonalityEmpty &&
      isPetsEmpty &&
      isSmokeEmpty &&
      isTattooEmpty &&
      isTargetEmpty &&
      isBlurEmpty;

  const CompleteProfileState({
    @required this.isPhotoEmpty,
    @required this.isNameEmpty,
    @required this.isDobEmpty,
    @required this.isAgeEmpty,
    @required this.isGenderEmpty,
    @required this.isInterestedInEmpty,
    @required this.isLocationEmpty,
    @required this.isNicknameEmpty, // additional
    @required this.isCurrentJobEmpty, // additional
    @required this.isSholatListEmpty,
    @required this.isFastingListEmpty,
    @required this.isPilgrimageListEmpty,
    @required this.isQuranLevelListEmpty,
    @required this.isProvinceEmpty,
    @required this.isEduListEmpty,
    @required this.isChildPrefListEmpty,
    @required this.isFinancialsListEmpty,
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isPhotoKtpEmpty,
    @required this.isPhotoOtherIDEmpty,
    @required this.isJobPositionEmpty,
    @required this.isHobbyEmpty,
    @required this.isAboutEmpty,
    @required this.isSSunnahEmpty,
    @required this.isFSunnahEmpty,
    @required this.isMarriageStatusEmpty,
    @required this.isHaveKidsEmpty,
    @required this.isSalaryRangeEmpty,
    @required this.isPersonalityEmpty,
    @required this.isPetsEmpty,
    @required this.isSmokeEmpty,
    @required this.isTattooEmpty,
    @required this.isTargetEmpty,
    @required this.isBlurEmpty,
  });

  // a. initial state (empty)
  factory CompleteProfileState.empty() {
    return const CompleteProfileState(
      isPhotoEmpty: false,
      isNameEmpty: false,
      isDobEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isInterestedInEmpty: false,
      isLocationEmpty: false,
      isNicknameEmpty: false, // additional
      isCurrentJobEmpty: false, // additional
      isSholatListEmpty: false,
      isFastingListEmpty: false,
      isPilgrimageListEmpty: false,
      isQuranLevelListEmpty: false,
      isProvinceEmpty: false,
      isEduListEmpty: false,
      isChildPrefListEmpty: false,
      isFinancialsListEmpty: false,
      isPhotoKtpEmpty: false,
      isPhotoOtherIDEmpty: false,
      isJobPositionEmpty: false,
      isHobbyEmpty: false,
      isAboutEmpty: false,
      isSSunnahEmpty: false,
      isFSunnahEmpty: false,
      isMarriageStatusEmpty: false,
      isHaveKidsEmpty: false,
      isSalaryRangeEmpty: false,
      isPersonalityEmpty: false,
      isPetsEmpty: false,
      isSmokeEmpty: false,
      isTattooEmpty: false,
      isTargetEmpty: false,
      isBlurEmpty: false,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }
  // b. loading state, submitting true
  factory CompleteProfileState.loading() {
    return const CompleteProfileState(
      isPhotoEmpty: false,
      isNameEmpty: false,
      isDobEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isInterestedInEmpty: false,
      isLocationEmpty: false,
      isNicknameEmpty: false, // additional
      isCurrentJobEmpty: false, // additional
      isSholatListEmpty: false,
      isFastingListEmpty: false,
      isPilgrimageListEmpty: false,
      isQuranLevelListEmpty: false,
      isProvinceEmpty: false,
      isEduListEmpty: false,
      isChildPrefListEmpty: false,
      isFinancialsListEmpty: false,
      isPhotoKtpEmpty: false,
      isPhotoOtherIDEmpty: false,
      isJobPositionEmpty: false,
      isHobbyEmpty: false,
      isAboutEmpty: false,
      isSSunnahEmpty: false,
      isFSunnahEmpty: false,
      isMarriageStatusEmpty: false,
      isHaveKidsEmpty: false,
      isSalaryRangeEmpty: false,
      isPersonalityEmpty: false,
      isPetsEmpty: false,
      isSmokeEmpty: false,
      isTattooEmpty: false,
      isTargetEmpty: false,
      isBlurEmpty: false,
      isFailure: false,
      isSubmitting: true,
      isSuccess: false,
    );
  }
  // c. failure state, failure true
  factory CompleteProfileState.failure() {
    return const CompleteProfileState(
      isPhotoEmpty: false,
      isNameEmpty: false,
      isDobEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isInterestedInEmpty: false,
      isLocationEmpty: false,
      isNicknameEmpty: false, // additional
      isCurrentJobEmpty: false, // additional
      isSholatListEmpty: false,
      isFastingListEmpty: false,
      isPilgrimageListEmpty: false,
      isQuranLevelListEmpty: false,
      isProvinceEmpty: false,
      isEduListEmpty: false,
      isChildPrefListEmpty: false,
      isFinancialsListEmpty: false,
      isPhotoKtpEmpty: false,
      isPhotoOtherIDEmpty: false,
      isJobPositionEmpty: false,
      isHobbyEmpty: false,
      isAboutEmpty: false,
      isSSunnahEmpty: false,
      isFSunnahEmpty: false,
      isMarriageStatusEmpty: false,
      isHaveKidsEmpty: false,
      isSalaryRangeEmpty: false,
      isPersonalityEmpty: false,
      isPetsEmpty: false,
      isSmokeEmpty: false,
      isTattooEmpty: false,
      isTargetEmpty: false,
      isBlurEmpty: false,
      isFailure: true,
      isSubmitting: false,
      isSuccess: false,
    );
  }
  // d. success state, success true
  factory CompleteProfileState.success() {
    return const CompleteProfileState(
      isPhotoEmpty: false,
      isNameEmpty: false,
      isDobEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isInterestedInEmpty: false,
      isLocationEmpty: false,
      isNicknameEmpty: false, // additional
      isCurrentJobEmpty: false, // additional
      isSholatListEmpty: false,
      isFastingListEmpty: false,
      isPilgrimageListEmpty: false,
      isQuranLevelListEmpty: false,
      isProvinceEmpty: false,
      isEduListEmpty: false,
      isChildPrefListEmpty: false,
      isFinancialsListEmpty: false,
      isPhotoKtpEmpty: false,
      isPhotoOtherIDEmpty: false,
      isJobPositionEmpty: false,
      isHobbyEmpty: false,
      isAboutEmpty: false,
      isSSunnahEmpty: false,
      isFSunnahEmpty: false,
      isMarriageStatusEmpty: false,
      isHaveKidsEmpty: false,
      isSalaryRangeEmpty: false,
      isPersonalityEmpty: false,
      isPetsEmpty: false,
      isSmokeEmpty: false,
      isTattooEmpty: false,
      isTargetEmpty: false,
      isBlurEmpty: false,
      isFailure: false,
      isSubmitting: false,
      isSuccess: true,
    );
  }

  CompleteProfileState update({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isDobEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty,
    bool isInterestedInEmpty,
    bool isLocationEmpty,
    bool isNicknameEmpty, // additional
    bool isCurrentJobEmpty, // additional
    bool isSholatListEmpty,
    bool isFastingListEmpty,
    bool isPilgrimageListEmpty,
    bool isQuranLevelListEmpty,
    bool isProvinceEmpty,
    bool isEduListEmpty,
    bool isChildPrefListEmpty,
    bool isFinancialsListEmpty,
    bool isPhotoKtpEmpty,
    bool isPhotoOtherIDEmpty,
    bool isJobPositionEmpty,
    bool isHobbyEmpty,
    bool isAboutEmpty,
    bool isSSunnahEmpty,
    bool isFSunnahEmpty,
    bool isMarriageStatusEmpty,
    bool isHaveKidsEmpty,
    bool isSalaryRangeEmpty,
    bool isPersonalityEmpty,
    bool isPetsEmpty,
    bool isSmokeEmpty,
    bool isTattooEmpty,
    bool isTargetEmpty,
    bool isBlurEmpty,
  }) {
    return copyWith(
      isPhotoEmpty: isPhotoEmpty,
      isNameEmpty: isNameEmpty,
      isDobEmpty: isDobEmpty,
      isAgeEmpty: isAgeEmpty,
      isGenderEmpty: isGenderEmpty,
      isInterestedInEmpty: isInterestedInEmpty,
      isLocationEmpty: isLocationEmpty,
      isNicknameEmpty: isNicknameEmpty, // additional
      isCurrentJobEmpty: isCurrentJobEmpty, // additional
      isSholatListEmpty: isSholatListEmpty,
      isFastingListEmpty: isFastingListEmpty,
      isPilgrimageListEmpty: isPilgrimageListEmpty,
      isQuranLevelListEmpty: isQuranLevelListEmpty,
      isProvinceEmpty: isProvinceEmpty,
      isEduListEmpty: isEduListEmpty,
      isChildPrefListEmpty: isChildPrefListEmpty,
      isFinancialsListEmpty: isFinancialsListEmpty,
      isPhotoKtpEmpty: isPhotoKtpEmpty,
      isPhotoOtherIDEmpty: isPhotoOtherIDEmpty,
      isJobPositionEmpty: isJobPositionEmpty,
      isHobbyEmpty: isHobbyEmpty,
      isAboutEmpty: isAboutEmpty,
      isSSunnahEmpty: isSSunnahEmpty,
      isFSunnahEmpty: isFSunnahEmpty,
      isMarriageStatusEmpty: isMarriageStatusEmpty,
      isHaveKidsEmpty: isHaveKidsEmpty,
      isSalaryRangeEmpty: isSalaryRangeEmpty,
      isPersonalityEmpty: isPersonalityEmpty,
      isPetsEmpty: isPetsEmpty,
      isSmokeEmpty: isSmokeEmpty,
      isTattooEmpty: isTattooEmpty,
      isTargetEmpty: isTargetEmpty,
      isBlurEmpty: isBlurEmpty,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  // copy with nullable
  CompleteProfileState copyWith({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isDobEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty,
    bool isInterestedInEmpty,
    bool isLocationEmpty,
    bool isNicknameEmpty, // additional
    bool isCurrentJobEmpty, // additional
    bool isSholatListEmpty,
    bool isFastingListEmpty,
    bool isPilgrimageListEmpty,
    bool isQuranLevelListEmpty,
    bool isProvinceEmpty,
    bool isEduListEmpty,
    bool isChildPrefListEmpty,
    bool isFinancialsListEmpty,
    bool isPhotoKtpEmpty,
    bool isPhotoOtherIDEmpty,
    bool isJobPositionEmpty,
    bool isHobbyEmpty,
    bool isAboutEmpty,
    bool isSSunnahEmpty,
    bool isFSunnahEmpty,
    bool isMarriageStatusEmpty,
    bool isHaveKidsEmpty,
    bool isSalaryRangeEmpty,
    bool isPersonalityEmpty,
    bool isPetsEmpty,
    bool isSmokeEmpty,
    bool isTattooEmpty,
    bool isTargetEmpty,
    bool isBlurEmpty,
    bool isFailure,
    bool isSubmitting,
    bool isSuccess,
  }) {
    return CompleteProfileState(
      isPhotoEmpty: isPhotoEmpty ?? this.isPhotoEmpty,
      isNameEmpty: isNameEmpty ?? this.isNameEmpty,
      isDobEmpty: isDobEmpty ?? this.isDobEmpty,
      isAgeEmpty: isAgeEmpty ?? this.isAgeEmpty,
      isGenderEmpty: isGenderEmpty ?? this.isGenderEmpty,
      isInterestedInEmpty: isInterestedInEmpty ?? this.isInterestedInEmpty,
      isLocationEmpty: isLocationEmpty ?? this.isLocationEmpty,
      isNicknameEmpty: isNicknameEmpty ?? this.isNicknameEmpty, // additional
      isCurrentJobEmpty:
          isCurrentJobEmpty ?? this.isCurrentJobEmpty, // additional
      isSholatListEmpty: isSholatListEmpty ?? this.isSholatListEmpty,
      isFastingListEmpty: isFastingListEmpty ?? this.isFastingListEmpty,
      isPilgrimageListEmpty:
          isPilgrimageListEmpty ?? this.isPilgrimageListEmpty,
      isQuranLevelListEmpty:
          isQuranLevelListEmpty ?? this.isQuranLevelListEmpty,
      isProvinceEmpty: isProvinceEmpty ?? this.isProvinceEmpty,
      isEduListEmpty: isEduListEmpty ?? this.isEduListEmpty,
      isChildPrefListEmpty: isChildPrefListEmpty ?? this.isChildPrefListEmpty,
      isFinancialsListEmpty:
          isFinancialsListEmpty ?? this.isFinancialsListEmpty,
      isPhotoKtpEmpty: isPhotoKtpEmpty ?? this.isPhotoKtpEmpty,
      isPhotoOtherIDEmpty: isPhotoOtherIDEmpty ?? this.isPhotoOtherIDEmpty,
      isJobPositionEmpty: isJobPositionEmpty ?? this.isJobPositionEmpty,
      isHobbyEmpty: isHobbyEmpty ?? this.isHobbyEmpty,
      isAboutEmpty: isAboutEmpty ?? this.isAboutEmpty,
      isSSunnahEmpty: isSSunnahEmpty ?? this.isSSunnahEmpty,
      isFSunnahEmpty: isFSunnahEmpty ?? this.isFSunnahEmpty,
      isMarriageStatusEmpty:
          isMarriageStatusEmpty ?? this.isMarriageStatusEmpty,
      isHaveKidsEmpty: isHaveKidsEmpty ?? this.isHaveKidsEmpty,
      isSalaryRangeEmpty: isSalaryRangeEmpty ?? this.isSalaryRangeEmpty,
      isPersonalityEmpty: isPersonalityEmpty ?? this.isPersonalityEmpty,
      isPetsEmpty: isPetsEmpty ?? this.isPetsEmpty,
      isSmokeEmpty: isSmokeEmpty ?? this.isSmokeEmpty,
      isTattooEmpty: isTattooEmpty ?? this.isTattooEmpty,
      isTargetEmpty: isTargetEmpty ?? this.isTargetEmpty,
      isBlurEmpty: isBlurEmpty ?? this.isBlurEmpty,
      isFailure: isFailure ?? this.isFailure,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// END OF PROFILE SETUP 02 15/41 //