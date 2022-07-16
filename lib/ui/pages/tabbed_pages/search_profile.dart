// @dart=2.9
import 'dart:async';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finpro_max/bloc/search_profile/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/custom_widgets/unverified.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/search_repository.dart';
import 'package:finpro_max/ui/pages/search_pages/view_search_header.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_profile_swipe.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:finpro_max/custom_widgets/text_radio_field.dart';

class SearchProfile extends StatefulWidget {
  final String userId;
  const SearchProfile({this.userId});

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile>
    with TickerProviderStateMixin {
  AnimationController _animationControllerA, _animationControllerB;
  final SearchRepository _searchRepository = SearchRepository();
  final TextEditingController _nicknameController = TextEditingController();
  SearchProfileBloc _searchProfileBloc;
  DropdownList _dropdownList;
  User _currentUser;
  int r01, r02, r03, r04, r05, r06;
  int p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11;
  int rTotal;
  int pTotal;
  double similarity;
  // check internet connection
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // radio dialog controllers
  final _sholatController = GroupButtonController();
  final _sSunnahController = GroupButtonController();
  final _fastingController = GroupButtonController();
  final _fSunnahController = GroupButtonController();
  final _pilgrimageController = GroupButtonController();
  final _quranController = GroupButtonController();
  final _eduController = GroupButtonController();
  final _mStatusController = GroupButtonController();
  final _haveKidsController = GroupButtonController();
  final _childPrefController = GroupButtonController();
  final _salaryController = GroupButtonController();
  final _debtController = GroupButtonController();
  final _personalityController = GroupButtonController();
  final _petsController = GroupButtonController();
  final _smokeController = GroupButtonController();
  final _tattooController = GroupButtonController();
  final _mTargetController = GroupButtonController();

  String zSholat,
      zSSunnah,
      zFasting,
      zFSunnah,
      zPilgrimage,
      zQuranLevel,
      zEducation,
      zMarriageStatus,
      zHaveKids,
      zChildPreference,
      zSalaryRange,
      zFinancials,
      zPersonality,
      zPets,
      zSmoke,
      zTattoo,
      zTarget;

  _onSubmitted() {
    ScaffoldMessenger.of(context).showSnackBar(
      mySnackbar(
        text: "Filtering...",
        duration: 2,
        background: primaryBlack,
      ),
    );
    _searchProfileBloc.add(
      AdvancedSearchEvent(
        userId: widget.userId,
        // zSholat: zSholat != null ? zSholat : _currentUser.zSholat,
        zSholat: zSholat ?? _currentUser.zSholat,
        zSSunnah: zSSunnah ?? _currentUser.zSSunnah,
        zFasting: zFasting ?? _currentUser.zFasting,
        zFSunnah: zFSunnah ?? _currentUser.zFSunnah,
        zPilgrimage: zPilgrimage ?? _currentUser.zPilgrimage,
        zQuranLevel: zQuranLevel ?? _currentUser.zQuranLevel,
        zEducation: zEducation ?? _currentUser.zEducation,
        zMarriageStatus: zMarriageStatus ?? _currentUser.zMarriageStatus,
        zHaveKids: zHaveKids ?? _currentUser.zHaveKids,
        zChildPreference: zChildPreference ?? _currentUser.zChildPreference,
        zSalaryRange: zSalaryRange ?? _currentUser.zSalaryRange,
        zFinancials: zFinancials ?? _currentUser.zFinancials,
        zPersonality: zPersonality ?? _currentUser.zPersonality,
        zPets: zPets ?? _currentUser.zPets,
        zSmoke: zSmoke ?? _currentUser.zSmoke,
        zTattoo: zTattoo ?? _currentUser.zTattoo,
        zTarget: zTarget ?? _currentUser.zTarget,
      ),
    );
    Navigator.pop(context);
  }

  _onReset() {
    ScaffoldMessenger.of(context).showSnackBar(
      mySnackbar(
        text: "Resetting search preferences...",
        duration: 2,
        background: primaryBlack,
      ),
    );
    _searchProfileBloc.add(
      ResetUserDefaultEvent(
        currentUserId: widget.userId,
        sholat: _currentUser.sholat,
        sSunnah: _currentUser.sSunnah,
        fasting: _currentUser.fasting,
        fSunnah: _currentUser.fSunnah,
        pilgrimage: _currentUser.pilgrimage,
        quranLevel: _currentUser.quranLevel,
        education: _currentUser.education,
        marriageStatus: _currentUser.marriageStatus,
        haveKids: _currentUser.haveKids,
        childPreference: _currentUser.childPreference,
        salaryRange: _currentUser.salaryRange,
        financials: _currentUser.financials,
        personality: _currentUser.personality,
        pets: _currentUser.pets,
        smoke: _currentUser.smoke,
        tattoo: _currentUser.tattoo,
        target: _currentUser.target,
      ),
    );
  }

  @override
  void initState() {
    _searchProfileBloc = SearchProfileBloc(searchRepository: _searchRepository);
    _dropdownList = DropdownList();
    r01 = 0;
    r02 = 0;
    r03 = 0;
    r04 = 0;
    r05 = 0;
    r06 = 0;
    p01 = 0;
    p02 = 0;
    p03 = 0;
    p04 = 0;
    p05 = 0;
    p06 = 0;
    p07 = 0;
    p08 = 0;
    p09 = 0;
    p10 = 0;
    p11 = 0;
    rTotal = 0;
    pTotal = 0;
    similarity = 0;
    super.initState();
    _animationControllerA = BottomSheet.createAnimationController(this);
    _animationControllerA.duration = const Duration(seconds: 0);
    _animationControllerB = BottomSheet.createAnimationController(this);
    _animationControllerB.duration = const Duration(seconds: 0);
    // check internet in initial state
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _animationControllerA.dispose();
    _animationControllerB.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // initialize connectivity async method
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() => _connectionStatus = result);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.35;
    final double itemWidth = size.width;

    // advanced search
    final List simpleAdvancedTitle = [
      "Prayer Punctuality",
      "Sunnah Prayer",
      "Ramadan Fasting",
      "Sunnah Fasting Status",
      "Pilgrimage Status",
      "Quran Proficiency",
      "Latest Education",
      "Marriage Status",
      "Number of Previous Kids",
      "Children Preference",
      "Salary Range",
      "Debt Ratio",
      "Personality Type",
      "Pets Status",
      "Smoking Status",
      "Tattoo Status",
      "Marriage Target",
    ];

    final List simpleController = [
      _sholatController,
      _sSunnahController,
      _fastingController,
      _fSunnahController,
      _pilgrimageController,
      _quranController,
      _eduController,
      _mStatusController,
      _haveKidsController,
      _childPrefController,
      _salaryController,
      _debtController,
      _personalityController,
      _petsController,
      _smokeController,
      _tattooController,
      _mTargetController,
    ];

    final List simpleList = [
      _dropdownList.sholatList,
      _dropdownList.sSunnahList,
      _dropdownList.fastingList,
      _dropdownList.fSunnahList,
      _dropdownList.pilgrimageList,
      _dropdownList.quranLevelList,
      _dropdownList.eduList,
      _dropdownList.marriageStatusList,
      _dropdownList.haveKidsList,
      _dropdownList.childPrefList,
      _dropdownList.salaryRangeList,
      _dropdownList.financialsList,
      _dropdownList.personalityList,
      _dropdownList.petsList,
      _dropdownList.smokeList,
      _dropdownList.tattooList,
      _dropdownList.targetList,
    ];

    final List simpleOnPressed = [
      (i) {
        setState(() => zSholat = _dropdownList.sholatList[i]);
        debugPrint(zSholat);
      },
      (i) {
        setState(() => zSSunnah = _dropdownList.sSunnahList[i]);
        debugPrint(zSSunnah);
      },
      (i) {
        setState(() => zFasting = _dropdownList.fastingList[i]);
        debugPrint(zFasting);
      },
      (i) {
        setState(() => zFSunnah = _dropdownList.fSunnahList[i]);
        debugPrint(zFSunnah);
      },
      (i) {
        setState(() => zPilgrimage = _dropdownList.pilgrimageList[i]);
        debugPrint(zPilgrimage);
      },
      (i) {
        setState(() => zQuranLevel = _dropdownList.quranLevelList[i]);
        debugPrint(zQuranLevel);
      },
      (i) {
        setState(() => zEducation = _dropdownList.eduList[i]);
        debugPrint(zEducation);
      },
      (i) {
        setState(() => zMarriageStatus = _dropdownList.marriageStatusList[i]);
        debugPrint(zMarriageStatus);
      },
      (i) {
        setState(() => zHaveKids = _dropdownList.haveKidsList[i]);
        debugPrint(zHaveKids);
      },
      (i) {
        setState(() => zChildPreference = _dropdownList.childPrefList[i]);
        debugPrint(zChildPreference);
      },
      (i) {
        setState(() => zSalaryRange = _dropdownList.salaryRangeList[i]);
        debugPrint(zSalaryRange);
      },
      (i) {
        setState(() => zFinancials = _dropdownList.financialsList[i]);
        debugPrint(zFinancials);
      },
      (i) {
        setState(() => zPersonality = _dropdownList.personalityList[i]);
        debugPrint(zPersonality);
      },
      (i) {
        setState(() => zPets = _dropdownList.petsList[i]);
        debugPrint(zPets);
      },
      (i) {
        setState(() => zSmoke = _dropdownList.smokeList[i]);
        debugPrint(zSmoke);
      },
      (i) {
        setState(() => zTattoo = _dropdownList.tattooList[i]);
        debugPrint(zTattoo);
      },
      (i) {
        setState(() => zTarget = _dropdownList.targetList[i]);
        debugPrint(zTarget);
      },
    ];

    final List simpleSearchOnTap = [
      () {
        showModalBottomSheet(
          transitionAnimationController: _animationControllerB,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderThreeText(
                    text: "Search by nickname:",
                    color: secondBlack,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 9,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            // autofocus: true,
                            controller: _nicknameController, // 2
                            decoration: InputDecoration(
                              hintText: "Input nickname",
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(width: 3, color: lightGrey2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(width: 3, color: lightGrey3),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: BigWideButton(
                            labelText: "Filter",
                            onPressedTo: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                mySnackbar(
                                  text:
                                      "Searching for '${_nicknameController.text}'...",
                                  duration: 2,
                                  background: primaryBlack,
                                ),
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // search
                              _searchProfileBloc.add(
                                SearchByNicknameEvent(
                                    userId: widget.userId,
                                    zNickname: _nicknameController.text),
                              );
                            },
                            textColor: white,
                            btnColor: primary1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[0],
          simpleController[0],
          simpleList[0],
          simpleOnPressed[0],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchBySholatEvent(userId: widget.userId, zSholat: zSholat),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[1],
          simpleController[1],
          simpleList[1],
          simpleOnPressed[1],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchBySSunnahEvent(userId: widget.userId, zSSunnah: zSSunnah),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[2],
          simpleController[2],
          simpleList[2],
          simpleOnPressed[2],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByFastingEvent(userId: widget.userId, zFasting: zFasting),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[3],
          simpleController[3],
          simpleList[3],
          simpleOnPressed[3],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByFSunnahEvent(userId: widget.userId, zFSunnah: zFSunnah),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[4],
          simpleController[4],
          simpleList[4],
          simpleOnPressed[4],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByPilgrimageEvent(
                  userId: widget.userId, zPilgrimage: zPilgrimage),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[5],
          simpleController[5],
          simpleList[5],
          simpleOnPressed[5],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByQuranEvent(
                  userId: widget.userId, zQuranLevel: zQuranLevel),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[6],
          simpleController[6],
          simpleList[6],
          simpleOnPressed[6],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByEduEvent(userId: widget.userId, zEducation: zEducation),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[7],
          simpleController[7],
          simpleList[7],
          simpleOnPressed[7],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByMStatusEvent(
                  userId: widget.userId, zMarriageStatus: zMarriageStatus),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[8],
          simpleController[8],
          simpleList[8],
          simpleOnPressed[8],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByHKidsEvent(userId: widget.userId, zHaveKids: zHaveKids),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[9],
          simpleController[9],
          simpleList[9],
          simpleOnPressed[9],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByCPrefEvent(
                  userId: widget.userId, zChildPreference: zChildPreference),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[10],
          simpleController[10],
          simpleList[10],
          simpleOnPressed[10],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchBySRangeEvent(
                  userId: widget.userId, zSalaryRange: zSalaryRange),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[11],
          simpleController[11],
          simpleList[11],
          simpleOnPressed[11],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByFinEvent(userId: widget.userId, zFinancials: zFinancials),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[12],
          simpleController[12],
          simpleList[12],
          simpleOnPressed[12],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByPersonalityEvent(
                  userId: widget.userId, zPersonality: zPersonality),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[13],
          simpleController[13],
          simpleList[13],
          simpleOnPressed[13],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByPetsEvent(userId: widget.userId, zPets: zPets),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[14],
          simpleController[14],
          simpleList[14],
          simpleOnPressed[14],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchBySmokeEvent(userId: widget.userId, zSmoke: zSmoke),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[15],
          simpleController[15],
          simpleList[15],
          simpleOnPressed[15],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByTattooEvent(userId: widget.userId, zTattoo: zTattoo),
            );
          },
        );
      },
      () {
        simpleSearch(
          context,
          simpleAdvancedTitle[16],
          simpleController[16],
          simpleList[16],
          simpleOnPressed[16],
          () {
            Navigator.pop(context);
            Navigator.pop(context);
            _searchProfileBloc.add(
              SearchByTargetEvent(userId: widget.userId, zTarget: zTarget),
            );
          },
        );
      },
    ];

    final List advancedValues = [
      zSholat,
      zSSunnah,
      zFasting,
      zFSunnah,
      zPilgrimage,
      zQuranLevel,
      zEducation,
      zMarriageStatus,
      zHaveKids,
      zChildPreference,
      zSalaryRange,
      zFinancials,
      zPersonality,
      zPets,
      zSmoke,
      zTattoo,
      zTarget,
    ];

    final List advancedItems = [
      _dropdownList.sholatList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.sSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fastingList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.pilgrimageList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.quranLevelList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.eduList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.marriageStatusList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.haveKidsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.childPrefList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.salaryRangeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.financialsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.personalityList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.petsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.smokeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.tattooList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.targetList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List advancedOnPressed = [
      (value) {
        setState(() => zSholat = value);
        debugPrint(zSholat);
      },
      (value) {
        setState(() => zSSunnah = value);
        debugPrint(zSSunnah);
      },
      (value) {
        setState(() => zFasting = value);
        debugPrint(zFasting);
      },
      (value) {
        setState(() => zFSunnah = value);
        debugPrint(zFSunnah);
      },
      (value) {
        setState(() => zPilgrimage = value);
        debugPrint(zPilgrimage);
      },
      (value) {
        setState(() => zQuranLevel = value);
        debugPrint(zQuranLevel);
      },
      (value) {
        setState(() => zEducation = value);
        debugPrint(zEducation);
      },
      (value) {
        setState(() => zMarriageStatus = value);
        debugPrint(zMarriageStatus);
      },
      (value) {
        setState(() => zHaveKids = value);
        debugPrint(zHaveKids);
      },
      (value) {
        setState(() => zChildPreference = value);
        debugPrint(zChildPreference);
      },
      (value) {
        setState(() => zSalaryRange = value);
        debugPrint(zSalaryRange);
      },
      (value) {
        setState(() => zFinancials = value);
        debugPrint(zFinancials);
      },
      (value) {
        setState(() => zPersonality = value);
        debugPrint(zPersonality);
      },
      (value) {
        setState(() => zPets = value);
        debugPrint(zPets);
      },
      (value) {
        setState(() => zSmoke = value);
        debugPrint(zSmoke);
      },
      (value) {
        setState(() => zTattoo = value);
        debugPrint(zTattoo);
      },
      (value) {
        setState(() => zTarget = value);
        debugPrint(zTarget);
      },
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Manual Search"),
        appBarColor: primary5,
      ),
      body: BlocBuilder<SearchProfileBloc, SearchProfileState>(
        bloc: _searchProfileBloc,
        builder: (context, state) {
          // check connection after builder
          if (_connectionStatus == ConnectivityResult.mobile ||
              _connectionStatus == ConnectivityResult.wifi) {
            if (state is SearchInitialState) {
              _searchProfileBloc
                  .add(SearchLoadUserEvent(userId: widget.userId));
              return Center(
                child: CircularProgressIndicator(color: primary1),
              );
            } else if (state is SearchLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primary1),
                ),
              );
            } else if (state is SearchLoadUserState) {
              _currentUser = state.currentUser;
              if (_currentUser.accountType == "verified" ||
                  _currentUser.accountType == "married") {
                return Stack(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: state.userList,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child:
                                  CircularProgressIndicator(color: primary1));
                        }
                        if (snapshot.data.documents.isNotEmpty) {
                          final user = snapshot.data.documents;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: size.height * 0.103),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              itemWidth / itemHeight,
                                        ),
                                        itemCount: user.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                myLoadingSnackbar(
                                                  text: "Please wait...",
                                                  duration: 1,
                                                  background: primaryBlack,
                                                ),
                                              );
                                              User selectedUser =
                                                  await _searchRepository
                                                      .getUserDetails(
                                                          user[index]
                                                              .documentID);
                                              User currentUser =
                                                  await _searchRepository
                                                      .getUserDetails(
                                                          widget.userId);
                                              // here
                                              if (_currentUser.zSholat ==
                                                  user[index].data['zSholat']) {
                                                setState(() => r01 = 1);
                                                debugPrint("$r01 r01 same");
                                              } else {
                                                setState(() => r01 = 0);
                                              }
                                              if (_currentUser.zSSunnah ==
                                                  user[index]
                                                      .data['zSSunnah']) {
                                                setState(() => r02 = 1);
                                                debugPrint("$r02 r02 same");
                                              } else {
                                                setState(() => r02 = 0);
                                              }
                                              if (_currentUser.zFasting ==
                                                  user[index]
                                                      .data['zFasting']) {
                                                setState(() => r03 = 1);
                                                debugPrint("$r03 r03 same");
                                              } else {
                                                setState(() => r03 = 0);
                                              }
                                              if (_currentUser.zFSunnah ==
                                                  user[index]
                                                      .data['zFSunnah']) {
                                                setState(() => r04 = 1);
                                                debugPrint("$r04 r04 same");
                                              } else {
                                                setState(() => r04 = 0);
                                              }
                                              if (_currentUser.zPilgrimage ==
                                                  user[index]
                                                      .data['zPilgrimage']) {
                                                setState(() => r05 = 1);
                                                debugPrint("$r05 r05 same");
                                              } else {
                                                setState(() => r05 = 0);
                                              }
                                              if (_currentUser.zQuranLevel ==
                                                  user[index]
                                                      .data['zQuranLevel']) {
                                                setState(() => r06 = 1);
                                                debugPrint("$r06 r06 same");
                                              } else {
                                                setState(() => r06 = 0);
                                              }
                                              if (_currentUser.zEducation ==
                                                  user[index]
                                                      .data['zEducation']) {
                                                setState(() => p01 = 1);
                                                debugPrint("$p01 p01 same");
                                              } else {
                                                setState(() => p01 = 0);
                                              }
                                              if (_currentUser
                                                      .zMarriageStatus ==
                                                  user[index].data[
                                                      'zMarriageStatus']) {
                                                setState(() => p02 = 1);
                                                debugPrint("$p02 p02 same");
                                              } else {
                                                setState(() => p02 = 0);
                                              }
                                              if (_currentUser.zHaveKids ==
                                                  user[index]
                                                      .data['zHaveKids']) {
                                                setState(() => p03 = 1);
                                                debugPrint("$p03 p03 same");
                                              } else {
                                                setState(() => p03 = 0);
                                              }
                                              if (_currentUser
                                                      .zChildPreference ==
                                                  user[index].data[
                                                      'zChildPreference']) {
                                                setState(() => p04 = 1);
                                                debugPrint("$p04 p04 same");
                                              } else {
                                                setState(() => p04 = 0);
                                              }
                                              if (_currentUser.zSalaryRange ==
                                                  user[index]
                                                      .data['zSalaryRange']) {
                                                setState(() => p05 = 1);
                                                debugPrint("$p05 p05 same");
                                              } else {
                                                setState(() => p05 = 0);
                                              }
                                              if (_currentUser.zFinancials ==
                                                  user[index]
                                                      .data['zFinancials']) {
                                                setState(() => p06 = 1);
                                                debugPrint("$p06 p06 same");
                                              } else {
                                                setState(() => p06 = 0);
                                              }
                                              if (_currentUser.zPersonality ==
                                                  user[index]
                                                      .data['zPersonality']) {
                                                setState(() => p07 = 1);
                                                debugPrint("$p07 p07 same");
                                              } else {
                                                setState(() => p07 = 0);
                                              }
                                              if (_currentUser.zPets ==
                                                  user[index].data['zPets']) {
                                                setState(() => p08 = 1);
                                                debugPrint("$p08 p08 same");
                                              } else {
                                                setState(() => p08 = 0);
                                              }
                                              if (_currentUser.zSmoke ==
                                                  user[index].data['zSmoke']) {
                                                setState(() => p09 = 1);
                                                debugPrint("$p09 p09 same");
                                              } else {
                                                setState(() => p09 = 0);
                                              }
                                              if (_currentUser.zTattoo ==
                                                  user[index].data['zTattoo']) {
                                                setState(() => p10 = 1);
                                                debugPrint("$p10 p10 same");
                                              } else {
                                                setState(() => p10 = 0);
                                              }
                                              if (_currentUser.zTarget ==
                                                  user[index].data['zTarget']) {
                                                setState(() => p11 = 1);
                                                debugPrint("$p11 p11 same");
                                              } else {
                                                setState(() => p11 = 0);
                                              }
                                              setState(() {
                                                rTotal = r01 +
                                                    r02 +
                                                    r03 +
                                                    r04 +
                                                    r05 +
                                                    r06;
                                                debugPrint("rTotal : $rTotal");
                                                pTotal = p01 +
                                                    p02 +
                                                    p03 +
                                                    p04 +
                                                    p05 +
                                                    p06 +
                                                    p07 +
                                                    p08 +
                                                    p09 +
                                                    p10 +
                                                    p11;
                                                debugPrint("pTotal : $pTotal");
                                                similarity =
                                                    (rTotal + pTotal) / 17;
                                                debugPrint(
                                                    "similarity : $similarity");
                                              });
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation1,
                                                          animation2) =>
                                                      ViewSearchHeader(
                                                    user: selectedUser,
                                                    size: size,
                                                    searchProfileBloc:
                                                        _searchProfileBloc,
                                                    currentUser: currentUser,
                                                    widget: widget,
                                                    rTotal: rTotal,
                                                    pTotal: pTotal,
                                                    similarity: double.parse(
                                                        similarity
                                                            .toStringAsFixed(
                                                                2)),
                                                  ),
                                                  transitionDuration:
                                                      Duration.zero,
                                                  reverseTransitionDuration:
                                                      Duration.zero,
                                                ),
                                              );
                                            },
                                            child: CardProfileSwipe(
                                              blur: user[index]
                                                          .data['blurAvatar'] ==
                                                      true
                                                  ? 10
                                                  : 0,
                                              overlay: user[index]
                                                          .data['blurAvatar'] ==
                                                      true
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.022),
                                                        CircleAvatar(
                                                          maxRadius: 65,
                                                          backgroundColor:
                                                              white,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            child: Image.asset(
                                                                "assets/images/love.png"),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              photo:
                                                  user[index].data['photoUrl'],
                                              photoHeight: size.height * 0.3,
                                              padding: size.height * 0.01,
                                              photoWidth: size.width * 0.5,
                                              clipRadius: size.height * 0.01,
                                              containerWidth: size.width * 0.5,
                                              containerHeight:
                                                  size.height * 0.12,
                                              containerChild: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 15, 15, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    HeaderFourText(
                                                      text:
                                                          "${user[index].data['nickname']}, ${(DateTime.now().year - user[index].data['dob'].toDate().year).toString()}",
                                                      color: white,
                                                    ),
                                                    SmallText(
                                                      text: user[index]
                                                          .data['jobPosition'],
                                                      color: white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SmallText(
                                                      text: user[index]
                                                          .data['currentJob'],
                                                      color: white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SmallText(
                                                      text:
                                                          "${user[index].data['location']}, ${user[index].data['province']}",
                                                      color: white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.103),
                                  EmptyContent(
                                    size: size,
                                    asset: "assets/images/questions.png",
                                    header: "Uh-oh...",
                                    description:
                                        "Looks like there is no one around. Please reset or refine your filter.",
                                    buttonText: "Reset Filter",
                                    onPressed: () {
                                      _onReset();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              HomeTabs(
                                                  userId: widget.userId,
                                                  selectedPage: 1),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ),
                                        ((route) => false),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: topFilterWidget(
                        context: context,
                        size: size,
                        simpleSearchOnTap: simpleSearchOnTap,
                        radioTitle: simpleAdvancedTitle,
                        simpleController: simpleController,
                        simpleList: simpleList,
                        simpleOnPressed: simpleOnPressed,
                        advancedValues: advancedValues,
                        advancedItems: advancedItems,
                        advancedOnPressed: advancedOnPressed,
                      ),
                    ),
                  ],
                );
                // }
              } else {
                return Unverified(userId: widget.userId);
              }
            }
            return HeaderFourText(text: "404", color: secondBlack);
          } else {
            return EmptyContent(
              size: size,
              asset: "assets/images/empty-container.png",
              header: "Oops...",
              description:
                  "Looks like the Internet is down or something else happened. Please try again later.",
              buttonText: "Refresh",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeTabs(userId: widget.userId, selectedPage: 1),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  ((route) => false),
                );
              },
            );
          }
        },
      ),
    );
  }

  GestureDetector topFilterWidget({
    BuildContext context,
    Size size,
    List<dynamic> simpleSearchOnTap,
    List<dynamic> radioTitle,
    List<dynamic> simpleController,
    List<dynamic> simpleList,
    List<dynamic> simpleOnPressed,
    List<dynamic> advancedValues,
    List<dynamic> advancedItems,
    List<dynamic> advancedOnPressed,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          transitionAnimationController: _animationControllerA,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SizedBox(
              height: size.height * 0.9,
              child: DefaultTabController(
                initialIndex: 0,
                animationDuration: Duration.zero,
                length: 2,
                child: Scaffold(
                  body: Column(
                    children: [
                      Container(
                        color: primary1,
                        child: TabBar(
                          indicatorColor: Colors.amber,
                          labelColor: Colors.amber,
                          unselectedLabelColor: white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: const EdgeInsets.all(5.0),
                          tabs: const [
                            Tab(text: "Simple Search"),
                            Tab(text: "Advanced Search"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            // Simple Search Tab
                            SingleChildScrollView(
                              child: Container(
                                color: lightGrey1,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SearchTips(
                                      title: "Search Tips",
                                      text:
                                          "In this section, you can filter based on single parameter. Select a parameter, choose a value or input a text (for nickname), and tap the Filter button to see the results.",
                                    ),
                                    const SizedBox(height: 15),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          _dropdownList.searchHeaders.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Card(
                                              child: InkWell(
                                                onTap: simpleSearchOnTap[index],
                                                child: ListTile(
                                                  leading: Icon(
                                                    _dropdownList
                                                            .simpleSearchIcons[
                                                        index],
                                                    color: primary1,
                                                  ),
                                                  title: DescText(
                                                    text: _dropdownList
                                                        .searchHeaders[index],
                                                    color: secondBlack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    resetSearch(context),
                                  ],
                                ),
                              ),
                            ),
                            // Advanced Search Tab
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    color: lightGrey1,
                                    padding: const EdgeInsets.fromLTRB(
                                        18, 20, 18, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SearchTips(
                                          title: "Search Tips",
                                          text:
                                              "In this section, you can mix the values of all the parameters. If you want to see users with 100% similarities, just leave it untouched and tap the Filter button at the bottom right to see the results.",
                                        ),
                                        const SizedBox(height: 20),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: radioTitle.length,
                                          itemBuilder: (context, index) {
                                            var currentUserHints = [
                                              _currentUser.zSholat,
                                              _currentUser.zSSunnah,
                                              _currentUser.zFasting,
                                              _currentUser.zFSunnah,
                                              _currentUser.zPilgrimage,
                                              _currentUser.zQuranLevel,
                                              _currentUser.zEducation,
                                              _currentUser.zMarriageStatus,
                                              _currentUser.zHaveKids,
                                              _currentUser.zChildPreference,
                                              _currentUser.zSalaryRange,
                                              _currentUser.zFinancials,
                                              _currentUser.zPersonality,
                                              _currentUser.zPets,
                                              _currentUser.zSmoke,
                                              _currentUser.zTattoo,
                                              _currentUser.zTarget,
                                            ];
                                            return dropdownField(
                                              radioTitle[index], // header
                                              Icon(_dropdownList.advSearchIcons[
                                                  index]), // icons
                                              currentUserHints[index], // hint
                                              advancedValues[index], // values
                                              advancedItems[index], // items
                                              advancedOnPressed[
                                                  index], // onpressed
                                              secondBlack,
                                            );
                                          },
                                        ),
                                        resetSearch(context),
                                        const SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 15, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FloatingActionButton(
                                        tooltip: "Cancel",
                                        backgroundColor: white,
                                        child: Icon(Icons.clear_outlined,
                                            color: primary1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      const SizedBox(width: 15),
                                      FloatingActionButton(
                                        tooltip: "Apply",
                                        backgroundColor: primary1,
                                        child: Icon(
                                          Icons.person_search_outlined,
                                          color: white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        onPressed: () => _onSubmitted(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appBarColor, primary1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: white),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SmallText(
                  text:
                      "Popular near ${_currentUser.location}, ${_currentUser.province}",
                  color: white,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                  child: HeaderFourText(
                    text: "Filter",
                    color: secondBlack,
                    align: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BigWideButton resetSearch(BuildContext context) {
    return BigWideButton(
      labelText: "Reset Search",
      onPressedTo: () {
        _onReset();
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                HomeTabs(userId: widget.userId, selectedPage: 1),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          ((route) => false),
        );
      },
      textColor: white,
      btnColor: primary1,
    );
  }

  Future<dynamic> simpleSearch(
    BuildContext context,
    String filterBy,
    GroupButtonController filterController,
    List<String> filterButtons,
    Function(int) filterSetState,
    Function() filterOnPressed,
  ) {
    return showModalBottomSheet(
      transitionAnimationController: _animationControllerB,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderThreeText(
                text: "Filter by $filterBy:",
                color: secondBlack,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GroupButton.radio(
                    selectedColor: primary1,
                    borderRadius: BorderRadius.circular(10),
                    mainGroupAlignment: MainGroupAlignment.start,
                    controller: filterController,
                    buttons: filterButtons,
                    onSelected: filterSetState,
                  );
                },
              ),
              const SizedBox(height: 20),
              BigWideButton(
                labelText: "Filter",
                onPressedTo: filterOnPressed,
                textColor: white,
                btnColor: primary1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchTips extends StatelessWidget {
  const SearchTips({
    this.title,
    this.text,
  });

  final String title, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary1,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderFourText(
            text: title,
            color: white,
          ),
          const SizedBox(height: 5),
          SmallText(
            text: text,
            color: white,
          ),
        ],
      ),
    );
  }
}
