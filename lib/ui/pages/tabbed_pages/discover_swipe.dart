// @dart=2.9
// 25/41
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finpro_max/bloc/discover_swipe/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/custom_widgets/unverified.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/discover_repository.dart';
import 'package:finpro_max/ui/pages/discover_pages/view_discover_detail_header.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_likedislike_icon.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_profile_swipe.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipeable/swipeable.dart';

class DiscoverSwipe extends StatefulWidget {
  final String userId;
  DiscoverSwipe({this.userId});

  @override
  State<DiscoverSwipe> createState() => _DiscoverSwipeState();
}

class _DiscoverSwipeState extends State<DiscoverSwipe> {
  final DiscoverRepository _discoverRepository = DiscoverRepository();
  DiscoverSwipeBloc _discoverSwipeBloc;
  User _user, _currentUser;
  // check similarity values
  int r01, r02, r03, r04, r05, r06;
  int p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11;
  int rTotal;
  int pTotal;
  double similarity;
  // check internet connection
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _discoverSwipeBloc =
        DiscoverSwipeBloc(discoverRepository: _discoverRepository);
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarSideButton(
        appBarTitle: Image.asset(
          "assets/images/header-logo.png",
          width: size.width * 0.4,
        ),
        appBarColor: white,
        appBarIcon: Icons.refresh_outlined,
        tooltip: "Refresh",
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(userId: widget.userId, selectedPage: 0),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
      body: BlocBuilder<DiscoverSwipeBloc, DiscoverSwipeState>(
        bloc: _discoverSwipeBloc, // in case of errors, include this
        builder: (context, state) {
          // check internet after builder
          if (_connectionStatus == ConnectivityResult.mobile ||
              _connectionStatus == ConnectivityResult.wifi) {
            // check states
            if (state is DiscoverInitialState) {
              _discoverSwipeBloc
                  .add(DiscoverLoadUserEvent(userId: widget.userId));
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primary1),
                ),
              );
            } else if (state is DiscoverLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primary1),
                ),
              );
            } else if (state is DiscoverLoadUserState) {
              _user = state.user;
              _currentUser = state.currentUser;
              if (_currentUser.accountType == "verified" ||
                  _currentUser.accountType == "married") {
                if (_user.nickname != null) {
                  return Swipeable(
                    background: Container(color: white),
                    threshold: 250,
                    onSwipeLeft: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackbar(
                          text:
                              "You disliked ${_user.nickname} (${_user.age}).",
                          duration: 3,
                          background: primaryBlack,
                        ),
                      );
                      _discoverSwipeBloc.add(
                        DiscoverDislikeUserEvent(
                          currentUserId: widget.userId,
                          selectedUserId: _user.uid,
                          userChosen: [_user.uid],
                          userSelected: [widget.userId],
                        ),
                      );
                    },
                    onSwipeRight: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackbar(
                          text:
                              "You liked ${_user.nickname} (${_user.age}). 👍",
                          duration: 3,
                          background: primaryBlack,
                        ),
                      );
                      _discoverSwipeBloc.add(
                        DiscoverLikeUserEvent(
                          // in the future 6+3
                          nickname: _currentUser.nickname,
                          photoUrl: _currentUser.photo,
                          age: _currentUser.age,
                          blurAvatar: _currentUser.blurAvatar,
                          currentUserId: widget.userId,
                          selectedUserId: _user.uid,
                          userChosen: [_user.uid],
                          userSelected: [widget.userId],
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CardProfileSwipe(
                          blur: _user.blurAvatar == true ? 20 : 0,
                          overlay: _user.blurAvatar == true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.15),
                                    CircleAvatar(
                                        maxRadius: 105,
                                        backgroundColor: white,
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Image.asset(
                                              "assets/images/love.png"),
                                        )),
                                  ],
                                )
                              : Container(),
                          padding: size.height * 0.035,
                          photoHeight: size.height * 0.824,
                          photo: _user.photo,
                          clipRadius: size.height * 0.02,
                          containerHeight: size.height * 0.325,
                          containerWidth: size.width * 0.9,
                          containerChild: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.035),
                                HeaderOneText(
                                  text:
                                      "${_user.nickname}, ${(DateTime.now().year - _user.dob.toDate().year).toString()}",
                                  color: white,
                                  align: TextAlign.left,
                                ),
                                ChatText(
                                  text:
                                      "${_user.jobPosition} at ${_user.currentJob}",
                                  color: white,
                                  align: TextAlign.left,
                                ),
                                ChatText(
                                  text: "${_user.location}, ${_user.province}",
                                  color: white,
                                  align: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // dislike
                                    iconWidget(
                                      "assets/images/close.png",
                                      size.width * 0.16,
                                      size.height * 0.16,
                                      () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          mySnackbar(
                                            text:
                                                "You disliked ${_user.nickname} (${_user.age}).",
                                            duration: 3,
                                            background: primaryBlack,
                                          ),
                                        );
                                        _discoverSwipeBloc.add(
                                          DiscoverDislikeUserEvent(
                                            currentUserId: widget.userId,
                                            selectedUserId: _user.uid,
                                            userChosen: [_user.uid],
                                            userSelected: [widget.userId],
                                          ),
                                        );
                                      },
                                    ),
                                    iconWidget(
                                      "assets/images/info.png",
                                      size.width * 0.1,
                                      size.height * 0.1,
                                      () async {
                                        if (_currentUser.sholat ==
                                            _user.sholat) {
                                          setState(() => r01 = 1);
                                          debugPrint("$r01 r01 same");
                                        } else {
                                          setState(() => r01 = 0);
                                        }
                                        if (_currentUser.sSunnah ==
                                            _user.sSunnah) {
                                          setState(() => r02 = 1);
                                          debugPrint("$r02 r02 same");
                                        } else {
                                          setState(() => r02 = 0);
                                        }
                                        if (_currentUser.fasting ==
                                            _user.fasting) {
                                          setState(() => r03 = 1);
                                          debugPrint("$r03 r03 same");
                                        } else {
                                          setState(() => r03 = 0);
                                        }
                                        if (_currentUser.fSunnah ==
                                            _user.fSunnah) {
                                          setState(() => r04 = 1);
                                          debugPrint("$r04 r04 same");
                                        } else {
                                          setState(() => r04 = 0);
                                        }
                                        if (_currentUser.pilgrimage ==
                                            _user.pilgrimage) {
                                          setState(() => r05 = 1);
                                          debugPrint("$r05 r05 same");
                                        } else {
                                          setState(() => r05 = 0);
                                        }
                                        if (_currentUser.quranLevel ==
                                            _user.quranLevel) {
                                          setState(() => r06 = 1);
                                          debugPrint("$r06 r06 same");
                                        } else {
                                          setState(() => r06 = 0);
                                        }
                                        if (_currentUser.education ==
                                            _user.education) {
                                          setState(() => p01 = 1);
                                          debugPrint("$p01 p01 same");
                                        } else {
                                          setState(() => p01 = 0);
                                        }
                                        if (_currentUser.marriageStatus ==
                                            _user.marriageStatus) {
                                          setState(() => p02 = 1);
                                          debugPrint("$p02 p02 same");
                                        } else {
                                          setState(() => p02 = 0);
                                        }
                                        if (_currentUser.haveKids ==
                                            _user.haveKids) {
                                          setState(() => p03 = 1);
                                          debugPrint("$p03 p03 same");
                                        } else {
                                          setState(() => p03 = 0);
                                        }
                                        if (_currentUser.childPreference ==
                                            _user.childPreference) {
                                          setState(() => p04 = 1);
                                          debugPrint("$p04 p04 same");
                                        } else {
                                          setState(() => p04 = 0);
                                        }
                                        if (_currentUser.salaryRange ==
                                            _user.salaryRange) {
                                          setState(() => p05 = 1);
                                          debugPrint("$p05 p05 same");
                                        } else {
                                          setState(() => p05 = 0);
                                        }
                                        if (_currentUser.financials ==
                                            _user.financials) {
                                          setState(() => p06 = 1);
                                          debugPrint("$p06 p06 same");
                                        } else {
                                          setState(() => p06 = 0);
                                        }
                                        if (_currentUser.personality ==
                                            _user.personality) {
                                          setState(() => p07 = 1);
                                          debugPrint("$p07 p07 same");
                                        } else {
                                          setState(() => p07 = 0);
                                        }
                                        if (_currentUser.pets == _user.pets) {
                                          setState(() => p08 = 1);
                                          debugPrint("$p08 p08 same");
                                        } else {
                                          setState(() => p08 = 0);
                                        }
                                        if (_currentUser.smoke == _user.smoke) {
                                          setState(() => p09 = 1);
                                          debugPrint("$p09 p09 same");
                                        } else {
                                          setState(() => p09 = 0);
                                        }
                                        if (_currentUser.tattoo ==
                                            _user.tattoo) {
                                          setState(() => p10 = 1);
                                          debugPrint("$p10 p10 same");
                                        } else {
                                          setState(() => p10 = 0);
                                        }
                                        if (_currentUser.target ==
                                            _user.target) {
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
                                                ViewDiscoverDetailHeader(
                                              user: _user,
                                              size: size,
                                              discoverSwipeBloc:
                                                  _discoverSwipeBloc,
                                              currentUser: _currentUser,
                                              widget: widget,
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
                                    ),
                                    // smash
                                    iconWidget(
                                      "assets/images/heart.png",
                                      size.width * 0.16,
                                      size.height * 0.16,
                                      () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          mySnackbar(
                                            text:
                                                "You liked ${_user.nickname} (${_user.age}). 👍",
                                            duration: 3,
                                            background: primaryBlack,
                                          ),
                                        );
                                        _discoverSwipeBloc.add(
                                          DiscoverLikeUserEvent(
                                            // in the future 6+3
                                            nickname: _currentUser.nickname,
                                            photoUrl: _currentUser.photo,
                                            age: _currentUser.age,
                                            blurAvatar: _currentUser.blurAvatar,
                                            currentUserId: widget.userId,
                                            selectedUserId: _user.uid,
                                            userChosen: [_user.uid],
                                            userSelected: [widget.userId],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [appBarColor, primary1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MiniText(
                                text:
                                    "Showing results near ${_currentUser.location}, ${_currentUser.province}",
                                color: white),
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              mySnackbar(
                                text:
                                    "Region can be changed in the profile setiings page.",
                                duration: 3,
                                background: primaryBlack,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return EmptyContent(
                    size: size,
                    asset: "assets/images/discover-tab.png",
                    header: "Uh-oh...",
                    description:
                        "Looks like there is no one around. Please come back later.",
                    buttonText: "Refresh",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              HomeTabs(userId: widget.userId, selectedPage: 0),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  );
                }
              } else {
                return Unverified(userId: widget.userId);
              }
            } else {
              return Center(
                  child: HeaderFourText(text: "404", color: secondBlack));
            }
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
                        HomeTabs(userId: widget.userId, selectedPage: 0),
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
}
