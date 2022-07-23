import 'dart:async';

import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/checklist_cards.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/taaruf_repository.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_0_page.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipeable/swipeable.dart';

class ChecklistThree extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistThree({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistThree> createState() => _ChecklistThreeState();
}

class _ChecklistThreeState extends State<ChecklistThree>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TaarufRepository _taarufRepository = TaarufRepository();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;
  String isPrayed;
  bool visibleA = true,
      visibleB = false,
      visibleC = false,
      visibleD = false,
      visibleE = false,
      visibleF = false;
  String titleC;

  @override
  void initState() {
    _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Taaruf Checklist (3)",
          color: white,
        ),
        appBarColor: primary1,
        appBarIcon: Icons.home_outlined,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(userId: widget.currentUserId, selectedPage: 3),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
            (route) => false,
          );
        },
        tooltip: "Home",
      ),
      body: BlocBuilder<TaarufBloc, TaarufState>(
        bloc: _taarufBloc,
        builder: (context, state) {
          if (state is TaarufLoadingState) {
            _taarufBloc.add(TaarufLoadUserEvent(
              currentUserId: widget.currentUserId,
              selectedUserId: widget.selectedUserId,
            ));
          }
          if (state is TaarufLoadUserState) {
            _selectedUser = state.selectedUser;
            _currentUser = state.currentUser;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container 1
                SizedBox(height: size.height * 0.05),
                Visibility(
                  visible: visibleA,
                  child: Swipeable(
                    background: Container(color: primary5),
                    threshold: 250,
                    onSwipeLeft: () {
                      setState(() {
                        visibleA = !visibleA;
                        visibleD = !visibleD;
                      });
                    },
                    onSwipeRight: () {
                      setState(() {
                        visibleA = !visibleA;
                        visibleB = !visibleB;
                      });
                    },
                    child: FirstCard(
                      size: size,
                      photoCU: _currentUser.photo,
                      photoSU: _selectedUser.photo,
                      title:
                          "Good day,\n${_currentUser.nickname} and ${_selectedUser.nickname}!",
                      topDesc:
                          "How are you feeling after the second visit?\nBefore we continue, we'd like to ask you several questions regarding to the steps.",
                      bottomDesc:
                          "There are no right or wrong answers, and you may answer anything you want.\n\nAre you ready?",
                      topLabel: "Okay, just show me",
                      bottomLabel: "Skip the introduction",
                      onTapTop: () {
                        setState(() {
                          visibleA = !visibleA;
                          visibleB = !visibleB;
                        });
                      },
                      onTapBottom: () {
                        setState(() {
                          visibleA = !visibleA;
                          visibleC = !visibleC;
                        });
                      },
                    ),
                  ),
                ),
                // Container 2, two button card
                Visibility(
                  visible: visibleB,
                  child: Swipeable(
                    background: Container(color: primary5),
                    threshold: 250,
                    onSwipeLeft: () {
                      setState(() {
                        visibleB = !visibleB;
                        visibleC = !visibleC;
                        titleC = "It's okay.";
                      });
                    },
                    onSwipeRight: () {
                      setState(() {
                        visibleB = !visibleB;
                        visibleC = !visibleC;
                        titleC = "Very nice!";
                      });
                    },
                    child: SecondCard(
                      size: size,
                      image: "questions",
                      title: "Feelings?",
                      description:
                          "While visiting the second parents yesterday, how do you feel?\n\nDid the make you comfortable or not, how are the overall things happened?",
                      topLabel: "Positive",
                      bottomLabel: "Negative",
                      onTapTop: () {
                        setState(() {
                          visibleB = !visibleB;
                          visibleC = !visibleC;
                          titleC = "Very nice!";
                        });
                      },
                      onTapBottom: () {
                        setState(() {
                          visibleB = !visibleB;
                          visibleC = !visibleC;
                          titleC = "It's okay.";
                        });
                      },
                    ),
                  ),
                ),
                // Container 3, one button card
                Visibility(
                  visible: visibleC,
                  child: Swipeable(
                    background: Container(color: primary5),
                    threshold: 250,
                    onSwipeLeft: () {
                      setState(() {
                        visibleC = !visibleC;
                        visibleD = !visibleD;
                      });
                    },
                    onSwipeRight: () {
                      setState(() {
                        visibleC = !visibleC;
                        visibleD = !visibleD;
                      });
                    },
                    child: ThirdCard(
                      size: size,
                      image: "ramadan",
                      title: titleC,
                      topDesc:
                          "What will you do next is called the Istikharah Prayer, to ask guidance from God if the selected user is the one will be your spouse.",
                      bottomDesc:
                          "It's better if you also do the Tahajud Prayer in the middle of the night.",
                      label: "I understand",
                      onTap: () {
                        setState(() {
                          visibleC = !visibleC;
                          visibleD = !visibleD;
                        });
                      },
                    ),
                  ),
                ),
                // Container 4, prayer
                Visibility(
                  visible: visibleD,
                  child: Swipeable(
                    background: Container(color: primary5),
                    threshold: 250,
                    onSwipeLeft: () => prayerText(context),
                    onSwipeRight: () {
                      setState(() {
                        visibleD = !visibleD;
                        visibleE = !visibleE;
                      });
                    },
                    child: SecondCard(
                      size: size,
                      image: "eid",
                      title: "Istikharah Prayer Steps",
                      description:
                          "First, you said your intention to pray, and the rest is the same with the regular sunnah prayer.\nIt's better if you also do the Tahajud Prayer in the middle of the night.",
                      topLabel: "I understand",
                      bottomLabel: "The Prayer",
                      onTapTop: () {
                        setState(() {
                          visibleD = !visibleD;
                          visibleE = !visibleE;
                        });
                      },
                      onTapBottom: () => prayerText(context),
                    ),
                  ),
                ),
                // Container 5 decision
                Visibility(
                  visible: visibleE,
                  child: Swipeable(
                    background: Container(color: primary5),
                    threshold: 250,
                    onSwipeLeft: () {
                      setState(() => visibleE = !visibleE);
                      Fluttertoast.showToast(msg: "Please wait...");
                      Timer(const Duration(seconds: 2), () {
                        returnToZero(context);
                        Fluttertoast.showToast(
                            msg:
                                "You can cancel taaruf at the bottom of this page.");
                      });
                    },
                    onSwipeRight: () {
                      setState(() {
                        visibleE = !visibleE;
                        visibleF = !visibleF;
                      });
                    },
                    child: SecondCard(
                      size: size,
                      image: "matches-top",
                      title: "\nMarry ${_selectedUser.nickname}?",
                      description:
                          "If you decided to marry ${_selectedUser.nickname}, then congratulations! You can swipe right.\nBut you can cancel if you don't want to.",
                      topLabel: "Continue",
                      bottomLabel: "I want to cancel",
                      onTapTop: () {
                        setState(() {
                          visibleE = !visibleE;
                          visibleF = !visibleF;
                        });
                      },
                      onTapBottom: () {
                        setState(() => visibleE = !visibleE);
                        Fluttertoast.showToast(msg: "Please wait...");
                        Timer(const Duration(seconds: 2), () {
                          returnToZero(context);
                          Fluttertoast.showToast(
                              msg:
                                  "You can cancel taaruf at the bottom of this page.");
                        });
                      },
                    ),
                  ),
                ),
                // Back to Checklist steps
                Visibility(
                  visible: visibleF,
                  child: ThirdCard(
                    size: size,
                    image: "pro-account",
                    title: "Very nice!",
                    topDesc:
                        "Now both of you can prepare to do the marriage proposal later.",
                    bottomDesc:
                        "We hope that it will be awesome.\n\nBest Regards,\nMusliMatch Team",
                    label: "Okay",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        myLoadingSnackbar(
                          text: "Please wait...",
                          duration: 5,
                          background: primaryBlack,
                        ),
                      );
                      _taarufBloc.add(AddCalendarCEvent(
                        currentUserId: widget.currentUserId,
                        selectedUserId: widget.selectedUserId,
                        taarufCheck: 3,
                      ));
                      Timer(const Duration(seconds: 5), () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          mySnackbar(
                            text: "Progress has been updated.",
                            duration: 3,
                            background: primaryBlack,
                          ),
                        );
                      });
                      Timer(const Duration(seconds: 5), () {
                        returnToZero(context);
                      });
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<dynamic> prayerText(BuildContext context) {
    return showModalBottomSheet(
      transitionAnimationController: _animationController,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderThreeText(
                  text: "The Prayer",
                  color: secondBlack,
                ),
                const SizedBox(height: 10),
                DescText(
                  text:
                      "Here is the one you need to say after doing the Istikharah Prayer:",
                  color: secondBlack,
                ),
                const SizedBox(height: 10),
                HeaderFourText(
                  text:
                      "“Allahumma inni astakhiruka bi 'ilmika, wa astaqdiruka bi qudratika, wa as-aluka min fadhlika, fa innaka taqdiru wa laa aqdiru, wa ta'lamu wa laa a'lamu, wa anta 'allaamul ghuyub.”",
                  color: secondBlack,
                ),
                const SizedBox(height: 10),
                HeaderFourText(
                  text:
                      "“Allahumma in kunta ta'lamu annahu syarrun lii fii diini wa ma'aasyi wa 'aqibati amrii (fii 'aajili amri wa aajilih) fash-rifnii 'anhu, waqdur liil khoiro haitsu kaana tsumma rodh-dhinii bih.”",
                  color: secondBlack,
                ),
                const SizedBox(height: 10),
                PaddingDivider(color: secondBlack),
                DescText(text: "Meaning:", color: secondBlack),
                const SizedBox(height: 10),
                HeaderFourText(
                  text:
                      "“O Allah, if You know that this matter is good for me in my religion, my life and my decision, then decide for me, make it easy for me and bless me in it.”",
                  color: secondBlack,
                ),
                const SizedBox(height: 10),
                HeaderFourText(
                  text:
                      "“And if You know that this matter is bad for me in my religion, my life and my decision, then keep it away from me and keep me away from it, determine for me what is best, then make me happy with it.”",
                  color: secondBlack,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> returnToZero(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => ChecklistZero(
          currentUserId: widget.currentUserId,
          selectedUserId: widget.selectedUserId,
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  PageRouteBuilder<dynamic> reloadAfterSave() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => super.widget,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
