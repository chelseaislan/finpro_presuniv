// @dart=2.9
// Start of SearchProfileBloc 04 23/41
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/search_profile/bloc.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/search_repository.dart';
import 'package:flutter/material.dart';

class SearchProfileBloc extends Bloc<SearchProfileEvent, SearchProfileState> {
  SearchRepository _searchRepository;
  SearchProfileBloc({@required SearchRepository searchRepository})
      : assert(searchRepository != null),
        _searchRepository = searchRepository;

  @override
  // implement initialState
  SearchProfileState get initialState => SearchInitialState();

  @override
  Stream<SearchProfileState> mapEventToState(SearchProfileEvent event) async* {
    if (event is SearchLoadUserEvent) {
      yield* _mapLoadUserToState(currentUserId: event.userId);
    } else if (event is SearchByNicknameEvent) {
      yield* _mapSearchByNickname(
        currentUserId: event.userId,
        zNickname: event.zNickname,
      );
    } else if (event is SearchBySholatEvent) {
      yield* _mapSearchBySholat(
        currentUserId: event.userId,
        zSholat: event.zSholat,
      );
    } else if (event is SearchBySSunnahEvent) {
      yield* _mapSearchBySSunnah(
        currentUserId: event.userId,
        zSSunnah: event.zSSunnah,
      );
    } else if (event is SearchByFastingEvent) {
      yield* _mapSearchByFasting(
        currentUserId: event.userId,
        zFasting: event.zFasting,
      );
    } else if (event is SearchByFSunnahEvent) {
      yield* _mapSearchByFSunnah(
        currentUserId: event.userId,
        zFSunnah: event.zFSunnah,
      );
    } else if (event is SearchByPilgrimageEvent) {
      yield* _mapSearchByPilgrimage(
        currentUserId: event.userId,
        zPilgrimage: event.zPilgrimage,
      );
    } else if (event is SearchByQuranEvent) {
      yield* _mapSearchByQuran(
        currentUserId: event.userId,
        zQuranLevel: event.zQuranLevel,
      );
    } else if (event is SearchByEduEvent) {
      yield* _mapSearchByEdu(
        currentUserId: event.userId,
        zEducation: event.zEducation,
      );
    } else if (event is SearchByMStatusEvent) {
      yield* _mapSearchByMStatus(
        currentUserId: event.userId,
        zMarriageStatus: event.zMarriageStatus,
      );
    } else if (event is SearchByHKidsEvent) {
      yield* _mapSearchByHKids(
        currentUserId: event.userId,
        zHaveKids: event.zHaveKids,
      );
    } else if (event is SearchByCPrefEvent) {
      yield* _mapSearchByCPref(
        currentUserId: event.userId,
        zChildPreference: event.zChildPreference,
      );
    } else if (event is SearchBySRangeEvent) {
      yield* _mapSearchBySRange(
        currentUserId: event.userId,
        zSalaryRange: event.zSalaryRange,
      );
    } else if (event is SearchByFinEvent) {
      yield* _mapSearchByFin(
        currentUserId: event.userId,
        zFinancials: event.zFinancials,
      );
    } else if (event is SearchByPersonalityEvent) {
      yield* _mapSearchByPersonality(
        currentUserId: event.userId,
        zPersonality: event.zPersonality,
      );
    } else if (event is SearchByPetsEvent) {
      yield* _mapSearchByPets(
        currentUserId: event.userId,
        zPets: event.zPets,
      );
    } else if (event is SearchBySmokeEvent) {
      yield* _mapSearchBySmoke(
        currentUserId: event.userId,
        zSmoke: event.zSmoke,
      );
    } else if (event is SearchByTattooEvent) {
      yield* _mapSearchByTattoo(
        currentUserId: event.userId,
        zTattoo: event.zTattoo,
      );
    } else if (event is SearchByTargetEvent) {
      yield* _mapSearchByTarget(
        currentUserId: event.userId,
        zTarget: event.zTarget,
      );
    } else if (event is AdvancedSearchEvent) {
      yield* _mapAdvancedSearch(
        currentUserId: event.userId,
        zSholat: event.zSholat,
        zSSunnah: event.zSSunnah,
        zFasting: event.zFasting,
        zFSunnah: event.zFSunnah,
        zPilgrimage: event.zPilgrimage,
        zQuranLevel: event.zQuranLevel,
        zEducation: event.zEducation,
        zMarriageStatus: event.zMarriageStatus,
        zHaveKids: event.zHaveKids,
        zChildPreference: event.zChildPreference,
        zSalaryRange: event.zSalaryRange,
        zFinancials: event.zFinancials,
        zPersonality: event.zPersonality,
        zPets: event.zPets,
        zSmoke: event.zSmoke,
        zTattoo: event.zTattoo,
        zTarget: event.zTarget,
      );
    } else if (event is SearchLikeUserEvent) {
      yield* _mapLikeUserToState(
        // jangan diubah
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        nickname: event.nickname,
        photoUrl: event.photoUrl,
        age: event.age,
        blurAvatar: event.blurAvatar,
        userChosen: event.userChosen,
        userSelected: event.userSelected,
      );
    } else if (event is SearchDislikeUserEvent) {
      yield* _mapDislikeUserToState(
        // jangan diubah
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        userChosen: event.userChosen,
        userSelected: event.userSelected,
      );
    } else if (event is ResetUserDefaultEvent) {
      yield* _mapResetUserDefault(
        // jangan diubah
        currentUserId: event.currentUserId,
        sholat: event.sholat,
        sSunnah: event.sSunnah,
        fasting: event.fasting,
        fSunnah: event.fSunnah,
        pilgrimage: event.pilgrimage,
        quranLevel: event.quranLevel,
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
      );
    }
  }

  Stream<SearchProfileState> _mapLoadUserToState(
      {String currentUserId}) async* {
    yield SearchLoadingState();
    // await _searchRepository.resetZSearch(currentUserId);
    User user = await _searchRepository.getUserDetails(currentUserId);
    User currentUser = await _searchRepository.getUserForSearch(currentUserId);
    Stream<QuerySnapshot> userList = currentUser.gender == "lady"
        ? _searchRepository.getMaleUserList(userId: currentUserId)
        : _searchRepository.getFemaleUserList(userId: currentUserId);

    yield SearchLoadUserState(
      user: user,
      currentUser: currentUser,
      userList: userList,
    );
  }

  Stream<SearchProfileState> _mapSearchByNickname({
    String currentUserId,
    String zNickname,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addNicknameSearch(currentUserId, zNickname);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleNickname(userId: currentUserId)
          : _searchRepository.sortFemaleNickname(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchBySholat({
    String currentUserId,
    String zSholat,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addSholat(currentUserId, zSholat);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleSholat(userId: currentUserId)
          : _searchRepository.sortFemaleSholat(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchBySSunnah({
    String currentUserId,
    String zSSunnah,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addSSunnah(currentUserId, zSSunnah);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleSSunnah(userId: currentUserId)
          : _searchRepository.sortFemaleSSunnah(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByFasting({
    String currentUserId,
    String zFasting,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addFasting(currentUserId, zFasting);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleFasting(userId: currentUserId)
          : _searchRepository.sortFemaleFasting(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByFSunnah({
    String currentUserId,
    String zFSunnah,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addFSunnah(currentUserId, zFSunnah);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleFSunnah(userId: currentUserId)
          : _searchRepository.sortFemaleFSunnah(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByPilgrimage({
    String currentUserId,
    String zPilgrimage,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addPilgrimage(currentUserId, zPilgrimage);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMalePilgrimage(userId: currentUserId)
          : _searchRepository.sortFemalePilgrimage(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByQuran({
    String currentUserId,
    String zQuranLevel,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addQuran(currentUserId, zQuranLevel);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleQuran(userId: currentUserId)
          : _searchRepository.sortFemaleQuran(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByEdu({
    String currentUserId,
    String zEducation,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addEdu(currentUserId, zEducation);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleEdu(userId: currentUserId)
          : _searchRepository.sortFemaleEdu(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByMStatus({
    String currentUserId,
    String zMarriageStatus,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addMStatus(currentUserId, zMarriageStatus);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleMStatus(userId: currentUserId)
          : _searchRepository.sortFemaleMStatus(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByHKids({
    String currentUserId,
    String zHaveKids,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addHKids(currentUserId, zHaveKids);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleHKids(userId: currentUserId)
          : _searchRepository.sortFemaleHKids(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByCPref({
    String currentUserId,
    String zChildPreference,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addCPref(currentUserId, zChildPreference);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleCPref(userId: currentUserId)
          : _searchRepository.sortFemaleCPref(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchBySRange({
    String currentUserId,
    String zSalaryRange,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addSRange(currentUserId, zSalaryRange);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleSRange(userId: currentUserId)
          : _searchRepository.sortFemaleSRange(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByFin({
    String currentUserId,
    String zFinancials,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addFin(currentUserId, zFinancials);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleFin(userId: currentUserId)
          : _searchRepository.sortFemaleFin(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByPersonality({
    String currentUserId,
    String zPersonality,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addPersonality(currentUserId, zPersonality);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMalePersonality(userId: currentUserId)
          : _searchRepository.sortFemalePersonality(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByPets({
    String currentUserId,
    String zPets,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addPets(currentUserId, zPets);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMalePets(userId: currentUserId)
          : _searchRepository.sortFemalePets(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchBySmoke({
    String currentUserId,
    String zSmoke,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addSmoke(currentUserId, zSmoke);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleSmoke(userId: currentUserId)
          : _searchRepository.sortFemaleSmoke(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByTattoo({
    String currentUserId,
    String zTattoo,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addTattoo(currentUserId, zTattoo);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleTattoo(userId: currentUserId)
          : _searchRepository.sortFemaleTattoo(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapSearchByTarget({
    String currentUserId,
    String zTarget,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addTarget(currentUserId, zTarget);
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleTarget(userId: currentUserId)
          : _searchRepository.sortFemaleTarget(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapAdvancedSearch({
    String currentUserId,
    String zSholat,
    String zSSunnah, //
    String zFasting,
    String zFSunnah, //
    String zPilgrimage,
    String zQuranLevel,
    String zEducation,
    String zMarriageStatus, //
    String zHaveKids, //
    String zChildPreference,
    String zSalaryRange, //
    String zFinancials,
    String zPersonality, //
    String zPets, //
    String zSmoke, //
    String zTattoo,
    String zTarget,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.addAdvancedSearch(
        currentUserId,
        zSholat,
        zSSunnah, //
        zFasting,
        zFSunnah, //
        zPilgrimage,
        zQuranLevel,
        zEducation,
        zMarriageStatus, //
        zHaveKids, //
        zChildPreference,
        zSalaryRange, //
        zFinancials,
        zPersonality, //
        zPets, //
        zSmoke, //
        zTattoo, //
        zTarget,
      );
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.sortMaleAdvanced(userId: currentUserId)
          : _searchRepository.sortFemaleAdvanced(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<SearchProfileState> _mapLikeUserToState({
    String currentUserId,
    String selectedUserId,
    String nickname,
    String photoUrl,
    int age,
    bool blurAvatar,
    List<String> userChosen, // for search page
    List<String> userSelected, // for search page
  }) async* {
    yield SearchLoadingState();
    User user = await _searchRepository.chooseUser(
      currentUserId,
      selectedUserId,
      nickname,
      photoUrl,
      age,
      blurAvatar,
      userChosen,
      userSelected,
    );
    User currentUser = await _searchRepository.getUserForSearch(currentUserId);

    yield SearchLoadUserState(user: user, currentUser: currentUser);
  }

  Stream<SearchProfileState> _mapDislikeUserToState({
    String currentUserId,
    String selectedUserId,
    List<String> userChosen, // for search page
    List<String> userSelected, // for search page
  }) async* {
    yield SearchLoadingState();
    User user = await _searchRepository.dislikeUser(
      currentUserId,
      selectedUserId,
      userChosen,
      userSelected,
    );
    User currentUser = await _searchRepository.getUserForSearch(currentUserId);

    yield SearchLoadUserState(user: user, currentUser: currentUser);
  }

  Stream<SearchProfileState> _mapResetUserDefault({
    String currentUserId,
    String sholat,
    String sSunnah,
    String fasting,
    String fSunnah,
    String pilgrimage,
    String quranLevel,
    // status
    String education,
    String marriageStatus,
    String haveKids,
    String childPreference,
    String salaryRange,
    String financials,
    // personal
    String personality,
    String pets,
    String smoke,
    String tattoo,
    String target,
  }) async* {
    yield SearchLoadingState();
    try {
      // await _searchRepository.resetZSearch(currentUserId);
      await _searchRepository.resetUserDefault(
        currentUserId,
        sholat,
        sSunnah,
        fasting,
        fSunnah,
        pilgrimage,
        quranLevel,
        education,
        marriageStatus,
        haveKids,
        childPreference,
        salaryRange,
        financials,
        personality,
        pets,
        smoke,
        tattoo,
        target,
      );
      User user = await _searchRepository.getUserDetails(currentUserId);
      User currentUser =
          await _searchRepository.getUserForSearch(currentUserId);
      Stream<QuerySnapshot> userList = currentUser.gender == "lady"
          ? _searchRepository.getMaleUserList(userId: currentUserId)
          : _searchRepository.getFemaleUserList(userId: currentUserId);

      yield SearchLoadUserState(
        user: user,
        currentUser: currentUser,
        userList: userList,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
