// @dart=2.9
import 'package:finpro_max/bloc/search_profile/search_profile_bloc.dart';
import 'package:finpro_max/bloc/search_profile/search_profile_event.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/floating_double_buttons.dart';
import 'package:finpro_max/custom_widgets/comparison_widget.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/profile_detail_listview.dart';
import 'package:finpro_max/custom_widgets/religion_filler.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/ui/pages/discover_pages/view_discover_detail_header.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/search_profile.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/profile_match_header_container.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';

class ViewSearchHeader extends StatelessWidget {
  final User _user;
  final Size size;
  final SearchProfileBloc _searchProfileBloc;
  final User _currentUser;
  final SearchProfile widget;
  final int rTotal, pTotal;
  final double similarity;

  const ViewSearchHeader({
    Key key,
    @required User user,
    @required this.size,
    @required SearchProfileBloc searchProfileBloc,
    @required User currentUser,
    @required this.rTotal,
    @required this.pTotal,
    @required this.similarity,
    @required this.widget,
  })  : _user = user,
        _searchProfileBloc = searchProfileBloc,
        _currentUser = currentUser,
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
      _user.nickname,
      "${(DateTime.now().year - _user.dob.toDate().year)} years old",
      _user.currentJob,
      _user.jobPosition,
      "${_user.location}, ${_user.province}",
      _user.hobby,
      _user.aboutMe,
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
      _user.sholat,
      _user.sSunnah,
      _user.fasting,
      _user.fSunnah,
      _user.pilgrimage,
      _user.quranLevel,
    ];

    final List uReligionContents = [
      _currentUser.sholat,
      _currentUser.sSunnah,
      _currentUser.fasting,
      _currentUser.fSunnah,
      _currentUser.pilgrimage,
      _currentUser.quranLevel,
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
      _user.education,
      _user.marriageStatus,
      _user.haveKids,
      _user.childPreference,
      _user.salaryRange,
      _user.financials,
      _user.personality,
      _user.pets,
      _user.smoke,
      _user.tattoo,
      _user.target,
    ];

    final List uPersonalContents = [
      _currentUser.education,
      _currentUser.marriageStatus,
      _currentUser.haveKids,
      _currentUser.childPreference,
      _currentUser.salaryRange,
      _currentUser.financials,
      _currentUser.personality,
      _currentUser.pets,
      _currentUser.smoke,
      _currentUser.tattoo,
      _currentUser.target,
    ];

    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Filtered User Details",
          color: pureWhite,
        ),
        appBarColor: primary1,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              ProfileHeaderContainer(
                size: size,
                currentUser: _user,
                blur: _user.blurAvatar == true ? 18 : 0,
                overlay: _user.blurAvatar == true
                    ? DetailBlur(size: size)
                    : Container(),
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
                            Tab(text: "About ${_user.nickname}"),
                            Tab(text: "${_user.nickname}'s Religion Details"),
                            // const Tab(text: "YOUR Religion Details"),
                            Tab(text: "${_user.nickname}'s Personal Details"),
                            // const Tab(text: "YOUR Personal Details"),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        height: size.height * 1.53,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            // Tab 1
                            Column(
                              children: [
                                ComparisonWidget(
                                  size: size,
                                  similarity: similarity,
                                  currentUser: _currentUser,
                                  user: _user,
                                  rTotal: rTotal,
                                  pTotal: pTotal,
                                ),
                                ProfileListView(
                                  headers: aboutHeaders,
                                  contents: aboutContents,
                                  color: secondBlack,
                                ),
                              ],
                            ),
                            // Tab 2
                            Column(
                              children: [
                                ProfileDetailListView(
                                  headers: religionHeaders,
                                  contents: religionContents,
                                  cuContents: uReligionContents,
                                  color: secondBlack,
                                ),
                                const SizedBox(height: 20),
                                ReligionQuoteFiller(
                                  size: size,
                                  similarity: similarity,
                                  quote:
                                      "“Love many things, for therein lies the true strength, and whosoever loves much performs much, and can accomplish much, and what is done in love is done well.”",
                                  author: "Vincent van Gogh",
                                  image: "ramadan",
                                ),
                              ],
                            ),
                            // Tab 4
                            ProfileDetailListView(
                              headers: personalHeaders,
                              contents: personalContents,
                              cuContents: uPersonalContents,
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
          // 2nd stack
          _currentUser.userChosen.contains(_user.uid)
              ? Container(
                  height: 115,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 17),
                  decoration: BoxDecoration(
                      color: primary5,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: pureWhite)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderFourText(text: "Reminder", color: pureWhite),
                      const SizedBox(height: 5),
                      SmallText(
                        text:
                            "You've already liked or disliked ${_user.nickname}, or vice versa. If you like this user, wait for ${_user.nickname} to respond.",
                        color: pureWhite,
                      ),
                    ],
                  ),
                )
              : FloatingDoubleButtons(
                  size: size,
                  onDislikeTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackbar(
                        text: "You disliked ${_user.nickname} (${_user.age}).",
                        duration: 3,
                        background: primaryBlack,
                      ),
                    );
                    _searchProfileBloc.add(
                      SearchDislikeUserEvent(
                        currentUserId: widget.userId,
                        selectedUserId: _user.uid,
                        userChosen: [_user.uid],
                        userSelected: [widget.userId],
                      ),
                    );
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
                  onLikeTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackbar(
                        text: "You liked ${_user.nickname} (${_user.age}). 👍",
                        duration: 3,
                        background: primaryBlack,
                      ),
                    );
                    _searchProfileBloc.add(
                      SearchLikeUserEvent(
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
                ),
        ],
      ),
    );
  }
}
