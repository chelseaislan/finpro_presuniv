import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/taaruf_repository.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_1_page.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_2_page.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_3_page.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_4_page.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_5_page.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_done.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChecklistZero extends StatefulWidget {
  final String currentUserId, selectedUserId;
  const ChecklistZero({this.currentUserId, this.selectedUserId});

  @override
  State<ChecklistZero> createState() => _ChecklistZeroState();
}

class _ChecklistZeroState extends State<ChecklistZero>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TaarufRepository _taarufRepository = TaarufRepository();
  TaarufBloc _taarufBloc;
  User _selectedUser, _currentUser;

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
    final List stepNumbers = [1, 2, 3, 4, 5, 6];
    final List titles = [
      "Visiting the first parents",
      "Visiting the second parents",
      "Decide by praying",
      "Marriage Proposal",
      "The Ceremony",
      "The Finale",
    ];
    final List subtitles = [
      "Both of you will decide the date to visit the one of your parents.",
      "Both of you will decide the date to visit the remaining parents.",
      "You gotta do the special prayer if your selected match is the one who will become your spouse.",
      "The male bride and his family should visit the female bride and her family, to express the intentions.",
      "The best day of both of your lives.",
      "Things that you can do after being married with the guidance of this application.",
    ];

    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Taaruf Steps Check"),
        appBarColor: primary1,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => super.widget,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
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
              if (_currentUser.taarufWith == null ||
                  _currentUser.taarufWith == _selectedUser.uid) {
                if (_currentUser.taarufChecklist ==
                    _selectedUser.taarufChecklist) {
                  debugPrint(
                      "CU Checklist: ${_currentUser.nickname} ${_currentUser.taarufChecklist}");
                  debugPrint(
                      "SU Checklist: ${_selectedUser.nickname} ${_selectedUser.taarufChecklist}");
                  final List status = [
                    _currentUser.taarufChecklist == 0
                        ? "Open"
                        : "Selected date on ${_currentUser.marriageA.toDate().day}/${_currentUser.marriageA.toDate().month}/${_currentUser.marriageA.toDate().year}",
                    _currentUser.taarufChecklist < 1
                        ? "Locked"
                        : _currentUser.taarufChecklist == 1
                            ? "This step can be opened after the selected date in step 1 has passed. "
                            : "Selected date on ${_currentUser.marriageB.toDate().day}/${_currentUser.marriageB.toDate().month}/${_currentUser.marriageB.toDate().year}",
                    _currentUser.taarufChecklist < 2
                        ? "Locked"
                        : _currentUser.taarufChecklist == 2
                            ? "This step can be opened after the selected date in step 2 has passed."
                            : "User has decided to marry ${_selectedUser.nickname}",
                    _currentUser.taarufChecklist < 3
                        ? "Locked"
                        : _currentUser.taarufChecklist == 3
                            ? "Open"
                            : "Selected date on ${_currentUser.marriageC.toDate().day}/${_currentUser.marriageC.toDate().month}/${_currentUser.marriageC.toDate().year}",
                    _currentUser.taarufChecklist < 4
                        ? "Locked"
                        : _currentUser.taarufChecklist == 4
                            ? "This step can be opened after the selected date in step 4 has passed."
                            : "Selected date on ${_currentUser.marriageD.toDate().day}/${_currentUser.marriageD.toDate().month}/${_currentUser.marriageD.toDate().year}",
                    _currentUser.taarufChecklist < 5
                        ? "Locked"
                        : _currentUser.taarufChecklist == 5
                            ? "This step can be opened after the selected date in step 5 has passed."
                            : "Congratulations, ${_currentUser.nickname} and ${_selectedUser.nickname}!",
                  ];
                  final List colors = [
                    _currentUser.marriageA != null ? primary1 : appBarColor,
                    _currentUser.marriageA != null &&
                            _currentUser.marriageB != null
                        ? primary1
                        : _currentUser.marriageA != null &&
                                _currentUser.marriageB == null
                            ? appBarColor
                            : thirdBlack,
                    _currentUser.marriageB != null &&
                            _currentUser.taarufChecklist > 2
                        ? primary1
                        : _currentUser.marriageB != null &&
                                _currentUser.taarufChecklist == 2
                            ? appBarColor
                            : thirdBlack,
                    _currentUser.marriageB != null &&
                            _currentUser.marriageC != null
                        ? primary1
                        : _currentUser.marriageB != null &&
                                _currentUser.taarufChecklist == 3
                            ? appBarColor
                            : thirdBlack,
                    _currentUser.marriageC != null &&
                            _currentUser.marriageD != null
                        ? primary1
                        : _currentUser.marriageC != null &&
                                _currentUser.taarufChecklist == 4
                            ? appBarColor
                            : thirdBlack,
                    _currentUser.marriageD != null &&
                            _currentUser.taarufChecklist > 5
                        ? primary1
                        : _currentUser.marriageD != null &&
                                _currentUser.taarufChecklist == 5
                            ? appBarColor
                            : thirdBlack,
                  ];
                  final List onTap = [
                    () {
                      _currentUser.taarufChecklist == 0 ||
                              _currentUser.taarufChecklist == 1
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistOne(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 1 is currently locked.");
                    },
                    () {
                      _currentUser.taarufChecklist == 1 &&
                                  DateTime.now().isAfter(
                                      _currentUser.marriageA.toDate()) ||
                              _currentUser.taarufChecklist == 2
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistTwo(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 2 is currently locked.");
                    },
                    () {
                      _currentUser.taarufChecklist == 2 &&
                                  DateTime.now().isAfter(
                                      _currentUser.marriageB.toDate()) ||
                              _currentUser.taarufChecklist == 3
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistThree(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 3 is currently locked.");
                    },
                    () {
                      _currentUser.taarufChecklist == 3 ||
                              _currentUser.taarufChecklist == 4
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistFour(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 4 is currently locked.");
                    },
                    () {
                      _currentUser.taarufChecklist == 4 &&
                                  DateTime.now().isAfter(
                                      _currentUser.marriageC.toDate()) ||
                              _currentUser.taarufChecklist == 5
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistFive(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 5 is currently locked.");
                    },
                    () {
                      _currentUser.taarufChecklist == 5 &&
                                  DateTime.now().isAfter(
                                      _currentUser.marriageD.toDate()) ||
                              _currentUser.taarufChecklist == 6
                          ? Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChecklistDone(
                                  currentUserId: widget.currentUserId,
                                  selectedUserId: widget.selectedUserId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            )
                          : Fluttertoast.showToast(
                              msg: "Step 6 is currently locked.");
                    },
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(bottom: size.width * 0.05),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: white,
                                width: size.width * 0.9,
                                height: size.width * 0.6,
                                child: CardPhotoWidget(
                                  photoLink: _currentUser.taarufChecklist == 0
                                      ? "https://media.giphy.com/media/3ohhwqXYQZKqvhVDuU/giphy-downsized.gif"
                                      : _currentUser.taarufChecklist == 1
                                          ? "https://media.giphy.com/media/bFuP8jviH6SUYRaBsa/giphy.gif"
                                          : _currentUser.taarufChecklist == 2
                                              ? "https://i.ibb.co/YZt45q6/taaruf3.jpg"
                                              : _currentUser.taarufChecklist ==
                                                      3
                                                  ? "https://media.giphy.com/media/7TwWM1k5dxWgOd0oMH/giphy-downsized.gif"
                                                  : _currentUser
                                                              .taarufChecklist ==
                                                          4
                                                      ? "https://media.giphy.com/media/urgh3QkW9wgG8goYCQ/giphy-downsized.gif"
                                                      : _currentUser.taarufChecklist ==
                                                                  5 ||
                                                              _currentUser
                                                                      .taarufChecklist ==
                                                                  6
                                                          ? "https://media.giphy.com/media/kGoQir5EBfABnc3sTh/giphy-downsized.gif"
                                                          : "https://media.giphy.com/media/lgcUUCXgC8mEo/giphy.gif",
                                ),
                              ),
                            ),
                          ),
                          PaddingDivider(color: white),
                          HeaderThreeText(
                            text: "Blessed day, ${_currentUser.nickname}!",
                            color: white,
                          ),
                          DescText(
                            text:
                                "Here are the steps you need to take prior to the marriage with ${_selectedUser.nickname}:",
                            color: white,
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: stepNumbers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: onTap[index],
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 23),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: colors[index],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: white)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ChatText(
                                          text: "Step ${stepNumbers[index]}",
                                          color: white),
                                      const SizedBox(height: 5),
                                      HeaderTwoText(
                                        text: titles[index],
                                        color: white,
                                      ),
                                      const SizedBox(height: 5),
                                      DescText(
                                        text: subtitles[index],
                                        color: white,
                                      ),
                                      const SizedBox(height: 10),
                                      SmallText(
                                        text: "Status: ${status[index]}",
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          PaddingDivider(color: white),
                          TaarufButtons(
                              size: size,
                              onPressedTop: () => goToMessages(context),
                              onPressedBottom: () {
                                showModalBottomSheet(
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
                                        title:
                                            "Cancel taaruf with ${_selectedUser.nickname}?",
                                        image: "assets/images/think.png",
                                        description:
                                            "If you feel unfit with this user, you may cancel this taaruf and find a new one to begin with.",
                                        labelTop: "No",
                                        labelBottom: "Yes",
                                        textColorTop: white,
                                        btnTop: primary1,
                                        textColorBottom: white,
                                        btnBottom: primary2,
                                        onPressedTop: () =>
                                            Navigator.pop(context),
                                        onPressedBottom: () {
                                          _taarufBloc.add(CancelTaarufEvent(
                                            currentUserId: widget.currentUserId,
                                            selectedUserId:
                                                widget.selectedUserId,
                                          ));
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  HomeTabs(
                                                      userId:
                                                          widget.currentUserId,
                                                      selectedPage: 2),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ),
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }),
                          Center(
                            child: Image.asset(
                              "assets/images/header-logo-white.png",
                              fit: BoxFit.cover,
                              width: 100,
                              height: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    color: white,
                    child: EmptyContent(
                      size: size,
                      asset: "assets/images/storm.png",
                      header: "Whoa!",
                      description:
                          "Looks like ${_selectedUser.nickname} is currently having a taaruf with another user.\n\nYou can wait until ${_selectedUser.nickname} cancels the ongoing one, or maybe just find new matches.",
                      buttonText: "Go to Home",
                      onPressed: () => goToMessages(context),
                    ),
                  );
                }
              } else {
                return Container(
                  color: white,
                  child: EmptyContent(
                    size: size,
                    asset: "assets/images/stop.png",
                    header: "Stop!",
                    description:
                        "You're currently having a taaruf with another user. If you changed your mind, you can cancel the ongoing taaruf at any time.",
                    buttonText: "Go to Home",
                    onPressed: () => goToMessages(context),
                  ),
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<dynamic> goToMessages(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            HomeTabs(userId: widget.currentUserId, selectedPage: 3),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      ((route) => false),
    );
  }
}
