import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/checklist_cards.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
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

class ChecklistTwo extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistTwo({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistTwo> createState() => _ChecklistTwoState();
}

class _ChecklistTwoState extends State<ChecklistTwo>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TaarufRepository _taarufRepository = TaarufRepository();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;
  bool visibleA = true,
      visibleB = false,
      visibleC = false,
      visibleD = false,
      visibleE = false,
      visibleF = false;
  String titleC;
  DateTime dateB;

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

  Event buildEvent({Recurrence recurrence}) {
    return Event(
      title: 'Visiting the second parents for taaruf',
      description:
          'You (${_currentUser.nickname}) and your partner (${_selectedUser.nickname}) will visit and get in touch with the remaining parents, as the part of taaruf.',
      location: 'MusliMatch app',
      startDate: dateB,
      endDate: dateB,
      allDay: true,
      androidParams: AndroidParams(
        emailInvites: [
          "${_currentUser.nickname}@your-email.com",
          "${_selectedUser.nickname}@your-email.com",
        ],
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Taaruf Checklist - 2"),
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
                            "Praise be,\n${_currentUser.nickname} and ${_selectedUser.nickname}!",
                        topDesc:
                            "How are you feeling after the visit?\nBefore we continue, we'd like to ask you several questions regarding to the steps.",
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
                            "While visiting the first parents yesterday, how do you feel?\n\nDid the make you comfortable or not, how are the overall things happened?",
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
                            "Now that after you visit the first parents, you can prepare more and improve how will both of you explain to the remaining parents.",
                        bottomDesc:
                            "Just a little more to overcome the last one.",
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
                  // Container 4, two button card
                  Visibility(
                    visible: visibleD,
                    child: Swipeable(
                      background: Container(color: primary5),
                      threshold: 250,
                      onSwipeLeft: () {
                        setState(() => visibleD = !visibleD);
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
                          visibleD = !visibleD;
                          visibleE = !visibleE;
                        });
                      },
                      child: SecondCard(
                        size: size,
                        image: "matches-top",
                        title: "\nContinue taaruf?",
                        description:
                            "Do you want continue the steps with ${_selectedUser.nickname}? It'll be good to continue, but you can cancel too if you feel unfit.",
                        topLabel: "Continue",
                        bottomLabel: "I want to cancel",
                        onTapTop: () {
                          setState(() {
                            visibleD = !visibleD;
                            visibleE = !visibleE;
                          });
                        },
                        onTapBottom: () {
                          setState(() => visibleD = !visibleD);
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
                  // Container 5 date picker
                  Visibility(
                    visible: visibleE,
                    child: FourthCard(
                      size: size,
                      step: "second",
                      desc:
                          "You and ${_selectedUser.nickname} will decide when will both of you visit the remaining parents.",
                      selectedDate: dateB != null
                          ? "${dateB.day}/${dateB.month}/${dateB.year}"
                          : "Please select a date.",
                      onTapTop: () {
                        DatePicker.showDatePicker(context,
                            locale: LocaleType.id,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            // must be atleast 18 yo
                            maxTime: DateTime(2024, 12, 31), onConfirm: (date) {
                          setState(() => dateB = date);
                        });
                      },
                      onTapBottom: () {
                        dateB != null
                            ? showModalBottomSheet(
                                transitionAnimationController:
                                    _animationController,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: ModalPopupTwoButton(
                                      size: size,
                                      title: "Confirmation",
                                      image: "assets/images/addtocal.png",
                                      description:
                                          "To keep track on the visit date, please add this event to your calendar.",
                                      labelTop: "Add to Calendar",
                                      labelBottom: "Continue",
                                      textColorTop: white,
                                      btnTop: primary1,
                                      textColorBottom: white,
                                      btnBottom: primary1,
                                      onPressedTop: () {
                                        Add2Calendar.addEvent2Cal(buildEvent());
                                      },
                                      onPressedBottom: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          visibleE = !visibleE;
                                          visibleF = !visibleF;
                                        });
                                      },
                                    ),
                                  );
                                },
                              )
                            : Fluttertoast.showToast(
                                msg: "Please select the date first.");
                      },
                    ),
                  ),
                  // Back to Checklist steps
                  Visibility(
                    visible: visibleF,
                    child: ThirdCard(
                      size: size,
                      image: "pro-account",
                      title: "Date has been set!",
                      topDesc:
                          "Now both of you can prepare to visit the remaining parents.",
                      bottomDesc:
                          "We hope that the visit will be awesome.\n\nBest Regards,\nMusliMatch Team",
                      label: "Okay",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          myLoadingSnackbar(
                            text: "Please wait...",
                            duration: 5,
                            background: primaryBlack,
                          ),
                        );
                        _taarufBloc.add(AddCalendarBEvent(
                          currentUserId: widget.currentUserId,
                          selectedUserId: widget.selectedUserId,
                          taarufCheck: 2,
                          marriageB: dateB,
                        ));
                        Timer(const Duration(seconds: 5), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Date has been updated.",
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
