// @dart=2.9
// Start 29/41
import 'dart:async';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finpro_max/bloc/matches/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/matches_repository.dart';
import 'package:finpro_max/ui/pages/matches_pages/view_matched_detail_header.dart';
import 'package:finpro_max/ui/pages/matches_pages/view_selected_detail_header.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_profile_swipe.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchesPage extends StatefulWidget {
  final String userId;
  const MatchesPage({this.userId});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  MatchesRepository matchesRepository = MatchesRepository();
  MatchesBloc _matchesBloc;
  int r01, r02, r03, r04, r05, r06;
  int p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11;
  int rTotal;
  int pTotal;
  double similarity;
  DateTime currentBackPressTime;
  // check internet connection
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _matchesBloc = MatchesBloc(matchesRepository: matchesRepository);
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
    // check internet in initial state
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
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
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "All Your Matches",
          color: white,
        ),
        appBarColor: primary1,
      ),
      body: WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              mySnackbar(
                text: "Press back again to exit.",
                duration: 3,
                background: primaryBlack,
              ),
            );
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: BlocBuilder<MatchesBloc, MatchesState>(
          bloc: _matchesBloc,
          builder: (BuildContext context, MatchesState state) {
            // check connection
            if (_connectionStatus == ConnectivityResult.mobile ||
                _connectionStatus == ConnectivityResult.wifi) {
              if (state is LoadingState) {
                _matchesBloc.add(LoadListsEvent(userId: widget.userId));
                return CircularProgressIndicator(color: primary1);
              }
              if (state is LoadUserState) {
                return Container(
                  color: white,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MatchesHeader(text: "Matched Users"),
                        // 30/41
                        StreamBuilder<QuerySnapshot>(
                          stream: state.matchedList,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: primary1));
                            }
                            if (snapshot.data.documents.isNotEmpty) {
                              final user = snapshot.data.documents;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
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
                                            await matchesRepository
                                                .getUserDetails(
                                                    user[index].documentID);
                                        User currentUser =
                                            await matchesRepository
                                                .getUserDetails(widget.userId);
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                ViewMatchedDetailHeader(
                                              selectedUser: selectedUser,
                                              size: size,
                                              matchesBloc: _matchesBloc,
                                              currentUser: currentUser,
                                              widget: widget,
                                            ),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                      },
                                      child: CardProfileSwipe(
                                        blur: 0,
                                        overlay: Container(),
                                        photo: user[index].data['photoUrl'],
                                        photoHeight: size.height * 0.3,
                                        padding: size.height * 0.01,
                                        photoWidth: size.width * 0.5,
                                        clipRadius: size.height * 0.01,
                                        containerWidth: size.width * 0.5,
                                        containerHeight: size.height * 0.06,
                                        containerChild: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          child: HeaderThreeText(
                                            text:
                                                "${user[index].data['nickname']}, ${user[index].data['age']}",
                                            color: white,
                                            align: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/matches-top.png",
                                      width: size.width * 0.6,
                                      height: size.width * 0.6,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 5,
                                      ),
                                      child: HeaderFourText(
                                        color: secondBlack,
                                        text:
                                            "We hope that you will get a perfect match!",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        const MatchesHeader(text: "New Matches to Look For"),
                        StreamBuilder<QuerySnapshot>(
                          stream: state.selectedList,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: primary1));
                            }
                            if (snapshot.data.documents.isNotEmpty) {
                              final user = snapshot.data.documents;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
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
                                            await matchesRepository
                                                .getUserDetails(
                                                    user[index].documentID);
                                        User currentUser =
                                            await matchesRepository
                                                .getUserDetails(widget.userId);
                                        if (currentUser.sholat ==
                                            selectedUser.sholat) {
                                          setState(() => r01 = 1);
                                          debugPrint("$r01 r01 same");
                                        } else {
                                          setState(() => r01 = 0);
                                        }
                                        if (currentUser.sSunnah ==
                                            selectedUser.sSunnah) {
                                          setState(() => r02 = 1);
                                          debugPrint("$r02 r02 same");
                                        } else {
                                          setState(() => r02 = 0);
                                        }
                                        if (currentUser.fasting ==
                                            selectedUser.fasting) {
                                          setState(() => r03 = 1);
                                          debugPrint("$r03 r03 same");
                                        } else {
                                          setState(() => r03 = 0);
                                        }
                                        if (currentUser.fSunnah ==
                                            selectedUser.fSunnah) {
                                          setState(() => r04 = 1);
                                          debugPrint("$r04 r04 same");
                                        } else {
                                          setState(() => r04 = 0);
                                        }
                                        if (currentUser.pilgrimage ==
                                            selectedUser.pilgrimage) {
                                          setState(() => r05 = 1);
                                          debugPrint("$r05 r05 same");
                                        } else {
                                          setState(() => r05 = 0);
                                        }
                                        if (currentUser.quranLevel ==
                                            selectedUser.quranLevel) {
                                          setState(() => r06 = 1);
                                          debugPrint("$r06 r06 same");
                                        } else {
                                          setState(() => r06 = 0);
                                        }
                                        if (currentUser.education ==
                                            selectedUser.education) {
                                          setState(() => p01 = 1);
                                          debugPrint("$p01 p01 same");
                                        } else {
                                          setState(() => p01 = 0);
                                        }
                                        if (currentUser.marriageStatus ==
                                            selectedUser.marriageStatus) {
                                          setState(() => p02 = 1);
                                          debugPrint("$p02 p02 same");
                                        } else {
                                          setState(() => p02 = 0);
                                        }
                                        if (currentUser.haveKids ==
                                            selectedUser.haveKids) {
                                          setState(() => p03 = 1);
                                          debugPrint("$p03 p03 same");
                                        } else {
                                          setState(() => p03 = 0);
                                        }
                                        if (currentUser.childPreference ==
                                            selectedUser.childPreference) {
                                          setState(() => p04 = 1);
                                          debugPrint("$p04 p04 same");
                                        } else {
                                          setState(() => p04 = 0);
                                        }
                                        if (currentUser.salaryRange ==
                                            selectedUser.salaryRange) {
                                          setState(() => p05 = 1);
                                          debugPrint("$p05 p05 same");
                                        } else {
                                          setState(() => p05 = 0);
                                        }
                                        if (currentUser.financials ==
                                            selectedUser.financials) {
                                          setState(() => p06 = 1);
                                          debugPrint("$p06 p06 same");
                                        } else {
                                          setState(() => p06 = 0);
                                        }
                                        if (currentUser.personality ==
                                            selectedUser.personality) {
                                          setState(() => p07 = 1);
                                          debugPrint("$p07 p07 same");
                                        } else {
                                          setState(() => p07 = 0);
                                        }
                                        if (currentUser.pets ==
                                            selectedUser.pets) {
                                          setState(() => p08 = 1);
                                          debugPrint("$p08 p08 same");
                                        } else {
                                          setState(() => p08 = 0);
                                        }
                                        if (currentUser.smoke ==
                                            selectedUser.smoke) {
                                          setState(() => p09 = 1);
                                          debugPrint("$p09 p09 same");
                                        } else {
                                          setState(() => p09 = 0);
                                        }
                                        if (currentUser.tattoo ==
                                            selectedUser.tattoo) {
                                          setState(() => p10 = 1);
                                          debugPrint("$p10 p10 same");
                                        } else {
                                          setState(() => p10 = 0);
                                        }
                                        if (currentUser.target ==
                                            selectedUser.target) {
                                          setState(() => p11 = 1);
                                          debugPrint("$p11 p11 same");
                                        } else {
                                          setState(() => p11 = 0);
                                        }
                                        setState(() {
                                          rTotal =
                                              r01 + r02 + r03 + r04 + r05 + r06;
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
                                          similarity = (rTotal + pTotal) / 17;
                                          debugPrint(
                                              "similarity : $similarity");
                                        });
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                ViewSelectedDetailHeader(
                                              selectedUser: selectedUser,
                                              size: size,
                                              matchesBloc: _matchesBloc,
                                              currentUser: currentUser,
                                              rTotal: rTotal,
                                              pTotal: pTotal,
                                              similarity: double.parse(
                                                  similarity
                                                      .toStringAsFixed(2)),
                                            ),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                      },
                                      child: CardProfileSwipe(
                                        blur: user[index].data['blurAvatar'] ==
                                                true
                                            ? 30
                                            : 0,
                                        overlay: user[index]
                                                    .data['blurAvatar'] ==
                                                true
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          size.height * 0.05),
                                                  Icon(
                                                    Icons
                                                        .blur_circular_outlined,
                                                    color: white,
                                                    size: 40,
                                                  ),
                                                  HeaderThreeText(
                                                      text: "MusliMatch",
                                                      color: white),
                                                ],
                                              )
                                            : Container(),
                                        photo: user[index].data['photoUrl'],
                                        photoHeight: size.height * 0.3,
                                        padding: size.height * 0.01,
                                        photoWidth: size.width * 0.5,
                                        clipRadius: size.height * 0.01,
                                        containerWidth: size.width * 0.5,
                                        containerHeight: size.height * 0.06,
                                        containerChild: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          child: HeaderThreeText(
                                            text:
                                                "${user[index].data['nickname']}, ${user[index].data['age']}",
                                            color: white,
                                            align: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/matches-bottom.png",
                                      width: size.width * 0.6,
                                      height: size.width * 0.6,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: HeaderFourText(
                                        color: secondBlack,
                                        text:
                                            "Currently, there are no users who likes you,\njust be patient.",
                                        align: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
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
                          HomeTabs(userId: widget.userId, selectedPage: 2),
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
      ),
    );
  }
}

class MatchesHeader extends StatelessWidget {
  final String text;
  const MatchesHeader({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 20, 20, 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 9),
            decoration: BoxDecoration(
              color: primary1,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: lightGrey3,
                  blurRadius: 10,
                  spreadRadius: 0.01,
                ),
              ],
            ),
            child: HeaderFourText(
              text: text.toUpperCase(),
              color: white,
              align: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
