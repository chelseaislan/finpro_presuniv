// @dart=2.9
import 'package:finpro_max/bloc/matches/matches_bloc.dart';
import 'package:finpro_max/bloc/matches/matches_event.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/text_button.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/profile_detail_listview.dart';
import 'package:finpro_max/custom_widgets/religion_filler.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/ui/pages/chatroom_pages/chatroom_page.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/matches_page.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/page_turn.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/profile_match_header_container.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';

class ViewMatchedDetailHeader extends StatelessWidget {
  final User selectedUser;
  final Size size;
  final MatchesBloc _matchesBloc;
  final MatchesPage widget;
  final User currentUser;

  const ViewMatchedDetailHeader(
      {Key key,
      @required this.selectedUser,
      @required this.size,
      @required MatchesBloc matchesBloc,
      @required this.widget,
      @required this.currentUser})
      : _matchesBloc = matchesBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List aboutHeaders = [
      "Nickname",
      "Age",
      "Company / Organization",
      "Job Position",
      "Location",
      "Hobby",
      "About the User",
    ];

    final List aboutContents = [
      selectedUser.nickname,
      "${(DateTime.now().year - selectedUser.dob.toDate().year)} years old",
      selectedUser.currentJob,
      selectedUser.jobPosition,
      "${selectedUser.location}, ${selectedUser.province}",
      selectedUser.hobby,
      selectedUser.aboutMe,
    ];

    final List religionHeaders = [
      "Prayer Punctuality",
      "Sunnah Prayer",
      "Ramadan Fasting Status",
      "Sunnah Fasting",
      "Pilgrimage Status",
      "Quran Proficiency",
    ];

    final List religionContents = [
      selectedUser.sholat,
      selectedUser.sSunnah,
      selectedUser.fasting,
      selectedUser.fSunnah,
      selectedUser.pilgrimage,
      selectedUser.quranLevel,
    ];

    final List yourReligionContents = [
      currentUser.sholat,
      currentUser.sSunnah,
      currentUser.fasting,
      currentUser.fSunnah,
      currentUser.pilgrimage,
      currentUser.quranLevel,
    ];

    final List personalHeaders = [
      "Latest Education",
      "Current Marriage Status",
      "Already Have Kids?",
      "Children Preference",
      "Salary Range",
      "Currently In Debt?",
      "Personality",
      "Pet Preference",
      "Smoker?",
      "Have Tattooed Body?",
      "Marriage Target",
    ];

    final List personalContents = [
      selectedUser.education,
      selectedUser.marriageStatus,
      selectedUser.haveKids,
      selectedUser.childPreference,
      selectedUser.salaryRange,
      selectedUser.financials,
      selectedUser.personality,
      selectedUser.pets,
      selectedUser.smoke,
      selectedUser.tattoo,
      selectedUser.target,
    ];

    final List yourPersonalContents = [
      currentUser.education,
      currentUser.marriageStatus,
      currentUser.haveKids,
      currentUser.childPreference,
      currentUser.salaryRange,
      currentUser.financials,
      currentUser.personality,
      currentUser.pets,
      currentUser.smoke,
      currentUser.tattoo,
      currentUser.target,
    ];

    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Matched User Details",
          color: white,
        ),
        appBarColor: primary1,
      ),
      body: ListView(
        children: [
          ProfileHeaderContainer(
            size: size,
            currentUser: selectedUser,
            blur: 0,
            overlay: Container(),
          ),
          SizedBox(height: size.width * 0.02),
          DefaultTabController(
            initialIndex: 0,
            animationDuration: Duration.zero,
            length: 3,
            child: Container(
              color: lightGrey1,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    color: lightGrey1,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: primary1,
                      labelColor: primary1,
                      unselectedLabelColor: secondBlack,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(5.0),
                      tabs: [
                        Tab(text: "About ${selectedUser.nickname}"),
                        Tab(
                            text:
                                "${selectedUser.nickname}'s Religion Details"),
                        // const Tab(text: "YOUR Religion Details"),
                        Tab(
                            text:
                                "${selectedUser.nickname}'s Personal Details"),
                        // const Tab(text: "YOUR Personal Details"),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    height: size.height * 1.36,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Tab 1
                        Column(
                          children: [
                            Container(
                              height: size.height * 0.35,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: primary1,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            backgroundColor: white,
                                            child: ClipOval(
                                              child: SizedBox(
                                                height: size.height * 0.085,
                                                width: size.height * 0.085,
                                                child: CardPhotoWidget(
                                                  photoLink: currentUser.photo,
                                                ),
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            backgroundColor: white,
                                            child: ClipOval(
                                              child: SizedBox(
                                                height: size.height * 0.085,
                                                width: size.height * 0.085,
                                                child: CardPhotoWidget(
                                                  photoLink: selectedUser.photo,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CircleAvatar(
                                        backgroundColor: white,
                                        child: Icon(
                                          Icons.change_circle_rounded,
                                          color: appBarColor,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  DescText(
                                    text:
                                        "Praise be, ${currentUser.nickname} and ${selectedUser.nickname}!",
                                    color: white,
                                    align: TextAlign.center,
                                  ),
                                  HeaderOneText(
                                    text: "It's a match!",
                                    color: white,
                                    align: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  ChatText(
                                    text:
                                        "Now you can head into the chatroom to know each other, sending files, and ultimately, start the taaruf process.",
                                    color: white,
                                    align: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    "assets/images/header-logo-white.png",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            ProfileDetailListView(
                              headers: aboutHeaders,
                              contents: aboutContents,
                              color: secondBlack,
                            ),
                            const SizedBox(height: 10),
                            BigTextButton(
                              labelText: "Unmatch User",
                              onPressedTo: () {
                                showModalBottomSheet(
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
                                            "Are you sure, ${currentUser.nickname}?",
                                        image: "assets/images/divorce.png",
                                        description:
                                            "After unmatch, you will lose your possibility to match and chat with ${selectedUser.nickname} again.",
                                        labelTop: "No",
                                        labelBottom:
                                            "Unmatch from ${selectedUser.nickname}",
                                        textColorTop: white,
                                        btnTop: primary1,
                                        textColorBottom: white,
                                        btnBottom: primary2,
                                        onPressedTop: () =>
                                            Navigator.pop(context),
                                        onPressedBottom: () {
                                          _matchesBloc.add(
                                            DeleteMatchedUserEvent(
                                                currentUser: currentUser.uid,
                                                selectedUser: selectedUser.uid),
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  HomeTabs(
                                                      userId: widget.userId,
                                                      selectedPage: 2),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ),
                                            ((route) => false),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              labelColor: primary2,
                            ),
                          ],
                        ),
                        // Tab 2
                        Column(
                          children: [
                            ProfileDetailListView(
                              headers: religionHeaders,
                              contents: religionContents,
                              color: secondBlack,
                            ),
                            const SizedBox(height: 20),
                            ReligionQuoteFiller(
                              size: size,
                              similarity: 1,
                              quote:
                                  "“Lots of people want to ride with you in the limo, but what you want is someone who will take the bus with you when the limo breaks down.”",
                              author: "Oprah Winfrey",
                              image: "mobility",
                            ),
                          ],
                        ),
                        // Tab 4
                        ProfileDetailListView(
                          headers: personalHeaders,
                          contents: personalContents,
                          color: secondBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary5,
        child: Icon(Icons.chat_outlined, color: white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          _matchesBloc.add(
            OpenChatEvent(
              currentUser: widget.userId,
              selectedUser: selectedUser.uid,
            ),
          );
          Navigator.pop(context);
          pageTurn(
              ChatroomPage(
                currentUser: currentUser,
                selectedUser: selectedUser,
              ),
              context);
        },
      ),
    );
  }
}
