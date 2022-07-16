// @dart=2.9
import 'package:equatable/equatable.dart';

abstract class TaarufEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaarufLoadUserEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  TaarufLoadUserEvent({this.currentUserId, this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}

class CancelTaarufEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  CancelTaarufEvent({this.currentUserId, this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}

class ChecklistControllerEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  final int taarufCheck;

  ChecklistControllerEvent({
    this.currentUserId,
    this.selectedUserId,
    this.taarufCheck,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        taarufCheck,
      ];
}

class AddCalendarAEvent extends TaarufEvent {
  final String currentUserId,
      selectedUserId,
      taarufWithCurrentUser,
      taarufWithSelectedUser;
  final int taarufCheck;
  final DateTime marriageA;

  AddCalendarAEvent({
    this.currentUserId,
    this.selectedUserId,
    this.taarufWithCurrentUser,
    this.taarufWithSelectedUser,
    this.taarufCheck,
    this.marriageA,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        taarufWithCurrentUser,
        taarufWithSelectedUser,
        taarufCheck,
        marriageA,
      ];
}

class AddCalendarBEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  final int taarufCheck;
  final DateTime marriageB;

  AddCalendarBEvent({
    this.currentUserId,
    this.selectedUserId,
    this.taarufCheck,
    this.marriageB,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        taarufCheck,
        marriageB,
      ];
}

class AddChecklistThreeEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;

  AddChecklistThreeEvent({
    this.currentUserId,
    this.selectedUserId,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
      ];
}

class AddCalendarCEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  final int taarufCheck;
  final DateTime marriageC;

  AddCalendarCEvent({
    this.currentUserId,
    this.selectedUserId,
    this.taarufCheck,
    this.marriageC,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        taarufCheck,
        marriageC,
      ];
}

class AddCalendarDEvent extends TaarufEvent {
  final String currentUserId, selectedUserId;
  final int taarufCheck;
  final DateTime marriageD;

  AddCalendarDEvent({
    this.currentUserId,
    this.selectedUserId,
    this.taarufCheck,
    this.marriageD,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        taarufCheck,
        marriageD,
      ];
}

// new
class FinishTaarufEvent extends TaarufEvent {
  final String currentUserId, selectedUserId, accountType, marriageStatus;

  FinishTaarufEvent({
    this.currentUserId,
    this.selectedUserId,
    this.accountType,
    this.marriageStatus,
  });

  @override
  List<Object> get props => [
        currentUserId,
        selectedUserId,
        accountType,
        marriageStatus,
      ];
}

class SubmitRatingEvent extends TaarufEvent {
  final String currentUserId;
  final int yAppRating;
  final int yExpRating;
  final String ySuggestionRating;
  SubmitRatingEvent({
    this.currentUserId,
    this.yAppRating,
    this.yExpRating,
    this.ySuggestionRating,
  });
  @override
  List<Object> get props => [
        currentUserId,
        yAppRating,
        yExpRating,
        ySuggestionRating,
      ];
}

// unused
class TaarufOpenChatEvent extends TaarufEvent {
  final String currentUser, selectedUser;
  TaarufOpenChatEvent({this.currentUser, this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}
