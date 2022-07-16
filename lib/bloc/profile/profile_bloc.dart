// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:finpro_max/bloc/profile/bloc.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 04 16/41 //
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;

  ProfileBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  // implement initialState
  ProfileState get initialState => ProfileInitialState(); // ProfileState.empty

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // implement mapEventToState
    if (event is ProfileLoadedEvent) {
      yield* _mapProfileLoadedToState(userId: event.userId);
    } else if (event is ResetTaarufEvent) {
      yield* _mapResetTaaruf(userId: event.userId);
    } else if (event is UploadStoryEvent) {
      yield* _mapUploadStory(userId: event.userId);
    } else if (event is SubmitRatingEvent) {
      yield* _mapSubmitRating(
        userId: event.userId,
        yAppRating: event.yAppRating,
        yExpRating: event.yExpRating,
        ySuggestionRating: event.ySuggestionRating,
      );
    }
  }

  // _mapProfileLoadedToState = dsbloc_mapLoadUserToState
  Stream<ProfileState> _mapProfileLoadedToState({String userId}) async* {
    yield ProfileLoadingState();
    User currentUser = await _userRepository.getProfile(userId);
    yield ProfileLoadedState(currentUser);
  }

  Stream<ProfileState> _mapResetTaaruf({String userId}) async* {
    yield ProfileLoadingState();
    User currentUser = await _userRepository.resetTaaruf(userId);
    yield ProfileLoadedState(currentUser);
  }

  Stream<ProfileState> _mapUploadStory({
    String userId,
    int counter,
    File story,
  }) async* {
    yield ProfileLoadingState();
    User currentUser = await _userRepository.uploadStory(
      userId: userId,
      counter: counter,
      story: story,
    );
    yield ProfileLoadedState(currentUser);
  }

  Stream<ProfileState> _mapSubmitRating({
    String userId,
    int yAppRating,
    int yExpRating,
    String ySuggestionRating,
  }) async* {
    yield ProfileLoadingState();
    User currentUser = await _userRepository.submitRating(
      userId,
      yAppRating,
      yExpRating,
      ySuggestionRating,
    );
    yield ProfileLoadedState(currentUser);
  }
}
