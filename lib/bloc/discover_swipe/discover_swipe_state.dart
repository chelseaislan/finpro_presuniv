// @dart=2.9
// Start of DiscoverSwipe bloc (originally search) 01 21/41
// originally SearchState
import 'package:equatable/equatable.dart';
import 'package:finpro_max/models/user.dart';

abstract class DiscoverSwipeState extends Equatable {
  const DiscoverSwipeState();

  @override
  List<Object> get props => [];
}

// 3 states to load user card
class DiscoverInitialState extends DiscoverSwipeState {}

class DiscoverLoadingState extends DiscoverSwipeState {}

class DiscoverLoadUserState extends DiscoverSwipeState {
  final User user, currentUser;
  DiscoverLoadUserState(this.user, this.currentUser);

  @override
  List<Object> get props => [user, currentUser];
}
// End of DiscoverSwipe bloc (originally search) 01 21/41