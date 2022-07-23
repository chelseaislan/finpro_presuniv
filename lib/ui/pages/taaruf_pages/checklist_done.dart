// @dart=2.9

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/taaruf_repository.dart';
import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChecklistDone extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistDone({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistDone> createState() => _ChecklistDoneState();
}

class _ChecklistDoneState extends State<ChecklistDone> {
  final TaarufRepository _taarufRepository = TaarufRepository();
  final TextEditingController _ySuggestionController = TextEditingController();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;
  ConfettiController _controllerBottomCenter;
  double expRating, appRating;
  int yExpRating, yAppRating;

  @override
  void initState() {
    _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Congratulations! 🎉",
          color: white,
        ),
        appBarColor: primary1,
      ),
      body: BlocBuilder<TaarufBloc, TaarufState>(
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TaarufHeader(
                        size: size,
                        header: "Congratulations, ${_currentUser.nickname}!",
                        description:
                            "You and your partner ${_selectedUser.nickname} have successfully married!",
                        photoLink:
                            "https://media.giphy.com/media/kGoQir5EBfABnc3sTh/giphy-downsized.gif",
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: size.width * 0.05,
                        ),
                        child: DescText(
                          text:
                              "May Allah bless both of you and give success and happiness on your entire life.\n\nOn behalf of the developers, we would like to thank you all for using our service.",
                          color: white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            HeaderFourText(
                              text:
                                  "How was your experience of finding a partner using this app?",
                              color: secondBlack,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            RatingBar.builder(
                              initialRating: 0,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied_rounded,
                                      color: Colors.red,
                                    );
                                    break;
                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_dissatisfied_rounded,
                                      color: Colors.redAccent,
                                    );
                                    break;
                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_neutral_rounded,
                                      color: Colors.amber,
                                    );
                                    break;
                                  case 3:
                                    return const Icon(
                                      Icons.sentiment_satisfied_rounded,
                                      color: Colors.lightGreen,
                                    );
                                    break;
                                  case 4:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied_rounded,
                                      color: Colors.blue,
                                    );
                                    break;
                                  default:
                                    break;
                                }
                                return Container();
                              },
                              onRatingUpdate: (rating) {
                                debugPrint("Your expRating: $rating");
                                setState(() {
                                  expRating = rating;
                                  yExpRating = rating.toInt();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            HeaderFourText(
                              text:
                                  "How was your overall experience of using this app?",
                              color: secondBlack,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            RatingBar.builder(
                              initialRating: 0,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star_rounded,
                                color: gold,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint("Your appRating: $rating");
                                setState(() {
                                  appRating = rating;
                                  yAppRating = appRating.toInt();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeaderFourText(
                              text:
                                  "Any comments or suggestions for us?\nLeave them on the text field below.",
                              color: secondBlack,
                              align: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              // autofocus: true,
                              textCapitalization: TextCapitalization.sentences,
                              controller: _ySuggestionController, // 2
                              decoration: InputDecoration(
                                hintText: "Comments and Suggestions",
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
                            const SizedBox(height: 15),
                            BigWideButton(
                              labelText: "Submit & Go to Profile",
                              onPressedTo: () {
                                _taarufBloc.add(FinishTaarufEvent(
                                    currentUserId: widget.currentUserId,
                                    selectedUserId: widget.selectedUserId,
                                    accountType: "married",
                                    marriageStatus:
                                        "Married using MusliMatch App"));
                                _taarufBloc.add(
                                  SubmitRatingEvent(
                                    currentUserId: widget.currentUserId,
                                    yAppRating: yAppRating,
                                    yExpRating: yExpRating,
                                    ySuggestionRating:
                                        _ySuggestionController.text,
                                  ),
                                );
                                Fluttertoast.showToast(
                                  msg:
                                      "Thanks! Your feedback has been sent. 👍",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            HomeTabs(
                                      userId: widget.currentUserId,
                                      selectedPage: 4,
                                    ),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                  (route) => false,
                                );
                              },
                              textColor: secondBlack,
                              btnColor: gold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    );
  }
}
