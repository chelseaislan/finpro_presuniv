// @dart=2.9
// Start of DiscoverSwipe bloc (originally search) 04 23/41
import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:finpro_max/bloc/discover_swipe/bloc.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/discover_repository.dart';
import 'package:flutter/material.dart';

class DiscoverSwipeBloc extends Bloc<DiscoverSwipeEvent, DiscoverSwipeState> {
  final DiscoverRepository _discoverRepository;
  DiscoverSwipeBloc({@required DiscoverRepository discoverRepository})
      : assert(discoverRepository != null),
        _discoverRepository = discoverRepository;

  @override
  DiscoverSwipeState get initialState => DiscoverInitialState();

  @override
  Stream<DiscoverSwipeState> mapEventToState(DiscoverSwipeEvent event) async* {
    // implement mapEventToState
    if (event is DiscoverLoadUserEvent) {
      yield* _mapLoadUserToState(currentUserId: event.userId);
    } else if (event is DiscoverLikeUserEvent) {
      yield* _mapLikeUser(
        // jangan diubah
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        nickname: event.nickname,
        photoUrl: event.photoUrl,
        age: event.age,
        blurAvatar: event.blurAvatar,
        userChosenA: event.userChosen,
        userChosenB: event.userSelected,
      );
    } else if (event is DiscoverDislikeUserEvent) {
      yield* _mapDislikeUser(
        // jangan diubah
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        userChosenA: event.userChosen,
        userChosenB: event.userSelected,
      );
    }
  }

  Stream<DiscoverSwipeState> _mapLoadUserToState(
      {String currentUserId}) async* {
    yield DiscoverLoadingState();
    User user = await _discoverRepository.getUser(currentUserId);
    User currentUser =
        await _discoverRepository.getUserInterests(currentUserId);

    yield DiscoverLoadUserState(user, currentUser);
  }

  Stream<DiscoverSwipeState> _mapLikeUser({
    String currentUserId,
    String selectedUserId,
    String nickname,
    String photoUrl,
    int age,
    bool blurAvatar,
    List<String> userChosenA, // for search page
    List<String> userChosenB, // for search page
  }) async* {
    yield DiscoverLoadingState();
    User user = await _discoverRepository.chooseUser(
      currentUserId,
      selectedUserId,
      nickname,
      photoUrl,
      age,
      blurAvatar,
      userChosenA,
      userChosenB,
    );
    User currentUser =
        await _discoverRepository.getUserInterests(currentUserId);

    yield DiscoverLoadUserState(user, currentUser);
  }

  Stream<DiscoverSwipeState> _mapDislikeUser({
    String currentUserId,
    String selectedUserId,
    List<String> userChosenA, // for search page
    List<String> userChosenB, // for search page
  }) async* {
    yield DiscoverLoadingState();
    User user = await _discoverRepository.dislikeUser(
      currentUserId,
      selectedUserId,
      userChosenA,
      userChosenB,
    );
    User currentUser =
        await _discoverRepository.getUserInterests(currentUserId);

    yield DiscoverLoadUserState(user, currentUser);
  }
}
