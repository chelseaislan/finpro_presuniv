// @dart=2.9
import 'package:finpro_max/bloc/discover_swipe/discover_swipe_bloc.dart';
import 'package:finpro_max/bloc/discover_swipe/discover_swipe_event.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/floating_double_buttons.dart';
import 'package:finpro_max/custom_widgets/comparison_widget.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/profile_detail_listview.dart';
import 'package:finpro_max/custom_widgets/religion_filler.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/discover_swipe.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/profile_match_header_container.dart';
import 'package:flutter/material.dart';

class ViewDiscoverDetailHeader extends StatelessWidget {
  final User _user;
  final Size size;
  final DiscoverSwipeBloc _discoverSwipeBloc;
  final User _currentUser;
  final DiscoverSwipe widget;
  final int rTotal, pTotal;
  final double similarity;

  const ViewDiscoverDetailHeader({
    Key key,
    @required User user,
    @required this.size,
    @required DiscoverSwipeBloc discoverSwipeBloc,
    @required User currentUser,
    @required this.rTotal,
    @required this.pTotal,
    @required this.similarity,
    @required this.widget,
  })  : _user = user,
        _discoverSwipeBloc = discoverSwipeBloc,
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
          text: "Discover User Details",
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
                            Tab(text: "${_user.nickname}'s Personal Details"),
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
                                      "“The best love is the kind that awakens the soul; that makes us reach for more, that plants the fire in our hearts and brings peace to our minds.”",
                                  author: "Noah from The Notebook",
                                  image: "upgrayedd",
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
          FloatingDoubleButtons(
            size: size,
            onDislikeTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackbar(
                  text: "You disliked ${_user.nickname} (${_user.age}).",
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
              Navigator.of(context).pop();
            },
            onLikeTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackbar(
                  text: "You liked ${_user.nickname} (${_user.age}). 👍",
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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class DetailBlur extends StatelessWidget {
  const DetailBlur({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.07),
        CircleAvatar(
            maxRadius: 90,
            backgroundColor: pureWhite,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/love.png"),
            )),
        const SizedBox(height: 10),
        HeaderOneText(text: "MusliMatch", color: pureWhite),
      ],
    );
  }
}
