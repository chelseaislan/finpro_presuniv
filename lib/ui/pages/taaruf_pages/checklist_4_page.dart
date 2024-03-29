import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/checklist_cards.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
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

class ChecklistFour extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistFour({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistFour> createState() => _ChecklistFourState();
}

class _ChecklistFourState extends State<ChecklistFour>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TaarufRepository _taarufRepository = TaarufRepository();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;
  bool visibleA = true,
      visibleB = false,
      visibleC = false,
      visibleD = false,
      visibleE = false;
  String titleC;
  DateTime dateC;

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
      title: 'Marriage Proposal (Khitbah)',
      description:
          'You (${_currentUser.nickname}) and your partner (${_selectedUser.nickname}) will do the marriage proposal event with both of your parents and a third party.',
      location: 'MusliMatch app',
      startDate: dateC,
      endDate: dateC,
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
        appBarTitle: HeaderThreeText(
          text: "Taaruf Checklist (4)",
          color: pureWhite,
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
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          FirstCard(
                            size: size,
                            photoCU: _currentUser.photo,
                            photoSU: _selectedUser.photo,
                            title:
                                "Blessed day,\n${_currentUser.nickname} and ${_selectedUser.nickname}!",
                            topDesc:
                                "How are you feeling today?\nBefore we continue, we'd like to ask you several questions regarding to the marriage proposal.",
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
                                visibleD = !visibleD;
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.075),
                            child: CircleAvatar(
                              backgroundColor: pureWhite,
                              child: Icon(
                                Icons.change_circle_rounded,
                                color: appBarColor,
                                size: 40,
                              ),
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
                          titleC = "Okay, here we explain:";
                        });
                      },
                      onSwipeRight: () {
                        setState(() {
                          visibleB = !visibleB;
                          visibleC = !visibleC;
                          titleC = "Glad to hear that!";
                        });
                      },
                      child: SecondCard(
                        size: size,
                        image: "collab",
                        title: "Hello!",
                        description:
                            "Now you're about to do Khitbah, or the Islamic marriage proposal, and there are several steps of it.\n\nDo you know what are those steps?",
                        topLabel: "Yes, I know it",
                        bottomLabel: "I don't really know",
                        onTapTop: () {
                          setState(() {
                            visibleB = !visibleB;
                            visibleC = !visibleC;
                            titleC = "Glad to hear that!";
                          });
                        },
                        onTapBottom: () {
                          setState(() {
                            visibleB = !visibleB;
                            visibleC = !visibleC;
                            titleC = "Okay, here we explain:";
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
                            "Both brides and parents, along with a third party (mainly ustadz), do the event in the house of female bride's family.",
                        bottomDesc:
                            "After doing the prayer, the male bride expressing his intentions, and also handing over the gifts to the female bride.",
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
                      step: "fourth",
                      desc:
                          "You and ${_selectedUser.nickname} will decide when will both of you do the marriage proposal with both of your parents and a 3rd party.",
                      selectedDate: dateC != null
                          ? "${dateC.day}/${dateC.month}/${dateC.year}"
                          : "Please select a date.",
                      onTapTop: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Confirmation"),
                            content: Text(
                                "You and ${_selectedUser.nickname} will do the proposal. If both of you are already agreed to marry, please set the date as soon as possible to avoid false accusations."),
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
                                      dateC = date;
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
                        dateC != null
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
                                          "To keep track on the event date, please add this event to your calendar.",
                                      labelTop: "Add to Calendar",
                                      labelBottom: "Continue",
                                      textColorTop: pureWhite,
                                      btnTop: primary1,
                                      textColorBottom: pureWhite,
                                      btnBottom: primary1,
                                      onPressedTop: () {
                                        Add2Calendar.addEvent2Cal(buildEvent());
                                      },
                                      onPressedBottom: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          visibleD = !visibleD;
                                          visibleE = !visibleE;
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
                    visible: visibleE,
                    child: ThirdCard(
                      size: size,
                      image: "pro-account",
                      title: "Date has been set!",
                      topDesc:
                          "Now both of you can prepare for the marriage proposal.",
                      bottomDesc:
                          "We hope that the event will be awesome.\n\nBest Regards,\nMusliMatch Team",
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
                          taarufCheck: 4,
                          marriageC: dateC,
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
