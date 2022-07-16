// @dart=2.9
// Start of DiscoverSwipe bloc (originally search) 02 21/41
// originally SearchEvent
import 'package:equatable/equatable.dart';

abstract class DiscoverSwipeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DiscoverLoadUserEvent extends DiscoverSwipeEvent {
  final String userId;
  DiscoverLoadUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

// originally SelectUserEvent, when the card shows and like / swipe right
class DiscoverLikeUserEvent extends DiscoverSwipeEvent {
  final String currentUserId, selectedUserId, nickname, photoUrl;
  final int age;
  final bool blurAvatar;
  final List<String> userChosen, userSelected; // for search page
  DiscoverLikeUserEvent({
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

// originally PassUserEvent, to press dislike / swipe left
class DiscoverDislikeUserEvent extends DiscoverSwipeEvent {
  final String currentUserId, selectedUserId;
  final List<String> userChosen, userSelected; // for search page
  DiscoverDislikeUserEvent({
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

// End of DiscoverSwipe bloc (originally search) 02 21/41