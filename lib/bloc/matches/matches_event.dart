// @dart=2.9
// Start 28/41 02

import 'package:equatable/equatable.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

// 1st event
class LoadListsEvent extends MatchesEvent {
  final String userId;
  const LoadListsEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

// 2nd event to match with the other user (likes)
class AcceptUserEvent extends MatchesEvent {
  final String currentUser,
      selectedUser,
      currentUserNickname,
      currentUserPhotoUrl,
      selectedUserNickname,
      selectedUserPhotoUrl;
  final bool currentUserBlur, selectedUserBlur;
  final int currentUserAge, selectedUserAge;

  const AcceptUserEvent({
    this.currentUser,
    this.selectedUser,
    this.currentUserNickname,
    this.currentUserPhotoUrl,
    this.selectedUserNickname,
    this.selectedUserPhotoUrl,
    this.currentUserBlur,
    this.selectedUserBlur,
    this.currentUserAge,
    this.selectedUserAge,
  });

  @override
  List<Object> get props => [
        currentUser,
        selectedUser,
        currentUserNickname,
        currentUserPhotoUrl,
        selectedUserNickname,
        selectedUserPhotoUrl,
        currentUserBlur,
        selectedUserBlur,
        currentUserAge,
        selectedUserAge,
      ];
}

// 3rd event, delete tile from stream (usually for dislikes)
class DeleteUserEvent extends MatchesEvent {
  final String currentUser, selectedUser;

  const DeleteUserEvent({this.currentUser, this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}

// 4th event
class OpenChatEvent extends MatchesEvent {
  final String currentUser, selectedUser;
  const OpenChatEvent({this.currentUser, this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}

// End 28/41 02

// 5th event, delete user after match if user didn't like him / her
class DeleteMatchedUserEvent extends MatchesEvent {
  final String currentUser, selectedUser;

  const DeleteMatchedUserEvent({this.currentUser, this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}
