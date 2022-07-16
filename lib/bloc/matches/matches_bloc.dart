// @dart=2.9
// Start 28/41 03
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/matches/bloc.dart';
import 'package:finpro_max/repositories/matches_repository.dart';
import 'package:meta/meta.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  MatchesRepository _matchesRepository;
  MatchesBloc({@required MatchesRepository matchesRepository})
      : assert(matchesRepository != null),
        _matchesRepository = matchesRepository;

  @override
  MatchesState get initialState => LoadingState();

  @override
  Stream<MatchesState> mapEventToState(MatchesEvent event) async* {
    // implement mapEventToState
    if (event is LoadListsEvent) {
      yield* _mapLoadListsToState(currentUserId: event.userId);
    } else if (event is DeleteUserEvent) {
      yield* _mapDeleteUserToState(
          currentUserId: event.currentUser, selectedUserId: event.selectedUser);
    } else if (event is DeleteMatchedUserEvent) {
      yield* _mapDeleteMatchedUserToState(
          currentUserId: event.currentUser, selectedUserId: event.selectedUser);
    } else if (event is OpenChatEvent) {
      yield* _mapOpenChatToState(
          currentUserId: event.currentUser, selectedUserId: event.selectedUser);
    } else if (event is AcceptUserEvent) {
      yield* _mapAcceptUserToState(
        currentUserId: event.currentUser,
        selectedUserId: event.selectedUser,
        currentUserNickname: event.currentUserNickname,
        currentUserPhotoUrl: event.currentUserPhotoUrl,
        selectedUserNickname: event.selectedUserNickname,
        selectedUserPhotoUrl: event.selectedUserPhotoUrl,
        currentUserBlur: event.currentUserBlur,
        selectedUserBlur: event.selectedUserBlur,
        currentUserAge: event.currentUserAge,
        selectedUserAge: event.selectedUserAge,
      );
    }
  }

  Stream<MatchesState> _mapLoadListsToState({String currentUserId}) async* {
    yield LoadingState();
    Stream<QuerySnapshot> matchedList =
        _matchesRepository.getMatchedList(currentUserId);
    Stream<QuerySnapshot> selectedList =
        _matchesRepository.getSelectedList(currentUserId);

    yield LoadUserState(matchedList: matchedList, selectedList: selectedList);
  }

  Stream<MatchesState> _mapDeleteUserToState(
      {String currentUserId, String selectedUserId}) async* {
    _matchesRepository.deleteUser(currentUserId, selectedUserId);
  }

  Stream<MatchesState> _mapDeleteMatchedUserToState(
      {String currentUserId, String selectedUserId}) async* {
    _matchesRepository.deleteMatchedUser(currentUserId, selectedUserId);
  }

  Stream<MatchesState> _mapOpenChatToState(
      {String currentUserId, String selectedUserId}) async* {
    _matchesRepository.openChat(
      currentUserId: currentUserId,
      selectedUserId: selectedUserId,
    );
  }

  Stream<MatchesState> _mapAcceptUserToState({
    String currentUserId,
    String selectedUserId,
    String currentUserNickname,
    String currentUserPhotoUrl,
    String selectedUserNickname,
    String selectedUserPhotoUrl,
    bool currentUserBlur,
    bool selectedUserBlur,
    int currentUserAge,
    int selectedUserAge,
  }) async* {
    await _matchesRepository.selectUser(
      currentUserId,
      selectedUserId,
      currentUserNickname,
      currentUserPhotoUrl,
      selectedUserNickname,
      selectedUserPhotoUrl,
      currentUserBlur,
      selectedUserBlur,
      currentUserAge,
      selectedUserAge,
    );
  }
}
// End 28/41 03