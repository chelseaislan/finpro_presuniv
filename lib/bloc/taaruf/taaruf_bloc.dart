// @dart=2.9

import 'dart:async';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/taaruf_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaarufBloc extends Bloc<TaarufEvent, TaarufState> {
  final TaarufRepository _taarufRepository;

  TaarufBloc({@required TaarufRepository taarufRepository})
      : assert(taarufRepository != null),
        _taarufRepository = taarufRepository;

  @override
  TaarufState get initialState => TaarufLoadingState();

  @override
  Stream<TaarufState> mapEventToState(TaarufEvent event) async* {
    if (event is TaarufLoadUserEvent) {
      yield* _mapTaarufLoadUser(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
      );
    } else if (event is CancelTaarufEvent) {
      yield* _mapCancelTaaruf(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
      );
    } else if (event is ChecklistControllerEvent) {
      yield* _mapChecklistController(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
      );
    } else if (event is AddCalendarAEvent) {
      yield* _mapAddCalendarA(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        marriageA: event.marriageA,
        taarufWithCurrentUser: event.taarufWithCurrentUser,
        taarufWithSelectedUser: event.taarufWithSelectedUser,
        taarufCheck: event.taarufCheck,
      );
    } else if (event is AddCalendarBEvent) {
      yield* _mapAddCalendarB(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        marriageB: event.marriageB,
        taarufCheck: event.taarufCheck,
      );
    } else if (event is AddChecklistThreeEvent) {
      yield* _mapAddChecklistThree(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
      );
    } else if (event is AddCalendarCEvent) {
      yield* _mapAddCalendarC(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        marriageC: event.marriageC,
        taarufCheck: event.taarufCheck,
      );
    } else if (event is AddCalendarDEvent) {
      yield* _mapAddCalendarD(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        marriageD: event.marriageD,
        taarufCheck: event.taarufCheck,
      );
    } else if (event is FinishTaarufEvent) {
      yield* _mapFinishTaaruf(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        accountType: event.accountType,
        marriageStatus: event.marriageStatus,
      );
    } else if (event is SubmitRatingEvent) {
      yield* _mapSubmitRating(
        currentUserId: event.currentUserId,
        yAppRating: event.yAppRating,
        yExpRating: event.yExpRating,
        ySuggestionRating: event.ySuggestionRating,
      );
    }
  }

  Stream<TaarufState> _mapTaarufLoadUser(
      {String currentUserId, selectedUserId}) async* {
    yield TaarufLoadingState();
    User selectedUser =
        await _taarufRepository.getSelectedUserDetails(userId: selectedUserId);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(
        selectedUser: selectedUser, currentUser: currentUser);
  }

  Stream<TaarufState> _mapCancelTaaruf(
      {String currentUserId, String selectedUserId}) async* {
    User user =
        await _taarufRepository.cancelTaaruf(currentUserId, selectedUserId);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapChecklistController(
      {String currentUserId, String selectedUserId}) async* {
    User selectedUser =
        await _taarufRepository.getSelectedUserDetails(userId: selectedUserId);
    User currentUser =
        await _taarufRepository.getTaarufChecklist(currentUserId);

    yield TaarufLoadUserState(
        selectedUser: selectedUser, currentUser: currentUser);
  }

  Stream<TaarufState> _mapAddCalendarA({
    String currentUserId,
    String selectedUserId,
    String taarufWithCurrentUser,
    String taarufWithSelectedUser,
    int taarufCheck,
    DateTime marriageA,
  }) async* {
    User user = await _taarufRepository.addCalendarA(
      currentUserId,
      selectedUserId,
      taarufWithCurrentUser,
      taarufWithSelectedUser,
      taarufCheck,
      marriageA,
    );
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapAddCalendarB({
    String currentUserId,
    String selectedUserId,
    int taarufCheck,
    DateTime marriageB,
  }) async* {
    User user = await _taarufRepository.addCalendarB(
        currentUserId, selectedUserId, taarufCheck, marriageB);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapAddChecklistThree(
      {String currentUserId, String selectedUserId}) async* {
    User user = await _taarufRepository.addChecklistThree(
        currentUserId, selectedUserId);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapAddCalendarC({
    String currentUserId,
    String selectedUserId,
    int taarufCheck,
    DateTime marriageC,
  }) async* {
    User user = await _taarufRepository.addCalendarC(
        currentUserId, selectedUserId, taarufCheck, marriageC);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapAddCalendarD({
    String currentUserId,
    String selectedUserId,
    int taarufCheck,
    DateTime marriageD,
  }) async* {
    User user = await _taarufRepository.addCalendarD(
        currentUserId, selectedUserId, taarufCheck, marriageD);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  // new
  Stream<TaarufState> _mapFinishTaaruf({
    String currentUserId,
    String selectedUserId,
    String accountType,
    String marriageStatus,
  }) async* {
    User user = await _taarufRepository.finishTaaruf(
        currentUserId, selectedUserId, accountType, marriageStatus);
    User currentUser =
        await _taarufRepository.getCurrentUserDetails(currentUserId);

    yield TaarufLoadUserState(selectedUser: user, currentUser: currentUser);
  }

  Stream<TaarufState> _mapSubmitRating({
    String currentUserId,
    int yAppRating,
    int yExpRating,
    String ySuggestionRating,
  }) async* {
    User currentUser = await _taarufRepository.submitRating(
      currentUserId,
      yAppRating,
      yExpRating,
      ySuggestionRating,
    );
    yield TaarufLoadUserState(currentUser: currentUser);
  }

  // Stream<TaarufState> _mapTaarufOpenChat(
  //     {String currentUserId, String selectedUserId}) async* {
  //   _taarufRepository.taarufOpenChat(
  //     currentUserId: currentUserId,
  //     selectedUserId: selectedUserId,
  //   );
  // }
}
