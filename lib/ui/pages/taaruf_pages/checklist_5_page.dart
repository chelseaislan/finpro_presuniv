import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/checklist_cards.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/taaruf_repository.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_0_page.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipeable/swipeable.dart';

class ChecklistFive extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistFive({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistFive> createState() => _ChecklistFiveState();
}

class _ChecklistFiveState extends State<ChecklistFive>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TaarufRepository _taarufRepository = TaarufRepository();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;
  ConfettiController _controllerBottomCenter;
  bool visibleA = true,
      visibleB = false,
      visibleC = false,
      visibleD = false,
      visibleE = false;
  String titleD;
  DateTime dateD;

  @override
  void initState() {
    _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Taaruf Checklist - 5"),
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
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(context, reloadAfterSave()),
        child: BlocBuilder<TaarufBloc, TaarufState>(
          bloc: _taarufBloc,
          builder: (context, state) {
            if (state is TaarufLoadingState) {
              _controllerBottomCenter.play();
              _taarufBloc.add(TaarufLoadUserEvent(
                currentUserId: widget.currentUserId,
                selectedUserId: widget.selectedUserId,
              ));
            }
            if (state is TaarufLoadUserState) {
              _selectedUser = state.selectedUser;
              _currentUser = state.currentUser;
              return Stack(
                children: [
                  Column(
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
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              FirstCard(
                                size: size,
                                photoCU: _currentUser.photo,
                                photoSU: _selectedUser.photo,
                                title:
                                    "Blessed be the fruit,\n${_currentUser.nickname} and ${_selectedUser.nickname}!",
                                topDesc:
                                    "How are you feeling today?\nWe'd like to ask you several questions regarding to the wedding ceremony.",
                                bottomDesc:
                                    "In these steps, there are no right or wrong answers. You may answer anything you want.\n\nAre you ready?",
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
                                    visibleD = !visibleD;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.07),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  maxRadius: 25,
                                  child: CircleAvatar(
                                      backgroundColor: white,
                                      child: Image.asset(
                                          "assets/images/heart.png")),
                                ),
                              ),
                            ],
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
                              titleD = "It's okay...";
                            });
                          },
                          onSwipeRight: () {
                            setState(() {
                              visibleB = !visibleB;
                              visibleC = !visibleC;
                              titleD = "Very nice!";
                            });
                          },
                          child: SecondCard(
                            size: size,
                            image: "karaoke",
                            title: "Hello!",
                            description:
                                "After all the hard work both of you have done, you have reached the final stage of taaruf - the wedding ceremony.\n\nHow does that feel, are you excited?",
                            topLabel: "Yes, I'm super excited!",
                            bottomLabel: "I am kinda nervous...",
                            onTapTop: () {
                              setState(() {
                                visibleB = !visibleB;
                                visibleC = !visibleC;
                                titleD = "Very nice!";
                              });
                            },
                            onTapBottom: () {
                              setState(() {
                                visibleB = !visibleB;
                                visibleC = !visibleC;
                                titleD = "It's okay...";
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
                            image: "iftar",
                            title: titleD,
                            topDesc:
                                "Make sure that both of you prepare everything for the ceremony, from the dress, concept, venue, and so on.",
                            bottomDesc:
                                "It's not necessarily meant to be too lavish. A simple wedding with your known ones as the attendants is much preferred.",
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
                      // Container 4 date picker
                      Visibility(
                        visible: visibleD,
                        child: FourthCard(
                          size: size,
                          step: "fifth",
                          desc:
                              "You and ${_selectedUser.nickname} will decide when will both of you do the wedding ceremony as one of your greatest days.",
                          selectedDate: dateD != null
                              ? "${dateD.day}/${dateD.month}/${dateD.year}"
                              : "Please select a date.",
                          onTapTop: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Confirmation"),
                                content: const Text(
                                    "Please set the most suitable date, so that both of you can prepare the wedding ceremony better."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          locale: LocaleType.id,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          // must be atleast 18 yo
                                          maxTime: DateTime(2024, 12, 31),
                                          onConfirm: (date) {
                                        setState(() {
                                          dateD = date;
                                          Navigator.pop(context);
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          onTapBottom: () {
                            dateD != null
                                ? setState(() {
                                    visibleD = !visibleD;
                                    visibleE = !visibleE;
                                  })
                                : Fluttertoast.showToast(
                                    msg: "Please select the date first.");
                          },
                        ),
                      ),
                      // Back to Checklist steps
                      Visibility(
                        visible: visibleE,
                        child: ThirdCard(
                          size: size,
                          image: "wedding",
                          title: "Date has been set!",
                          topDesc:
                              "This will be the greatest day of your life.\nWe hope that both of you can maintain the commitment and live happily ever after.",
                          bottomDesc: "Best Regards,\nMusliMatch Team",
                          label: "Okay",
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "Please wait...",
                              toastLength: Toast.LENGTH_LONG,
                            );
                            _taarufBloc.add(AddCalendarDEvent(
                              currentUserId: widget.currentUserId,
                              selectedUserId: widget.selectedUserId,
                              taarufCheck: 5,
                              marriageD: dateD,
                            ));
                            Timer(const Duration(seconds: 5), () {
                              Fluttertoast.showToast(
                                msg: "Date has been updated.",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            });
                            Timer(const Duration(seconds: 5), () {
                              returnToZero(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfettiWidget(
                      confettiController: _controllerBottomCenter,
                      blastDirection: -pi / 2,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      maxBlastForce: 100,
                      minBlastForce: 80,
                      gravity: 0.2,
                      particleDrag: 0.05, // apply drag to the confetti
                      shouldLoop: false,
                      colors: [
                        gold,
                        appBarColor,
                        primary3,
                      ], // manually specify the colors to be used
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
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
