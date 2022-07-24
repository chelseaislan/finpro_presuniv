// @dart=2.9
import 'package:finpro_max/bloc/matches/matches_bloc.dart';
import 'package:finpro_max/bloc/matches/matches_event.dart';
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
import 'package:finpro_max/ui/widgets/matches_widgets/profile_match_header_container.dart';
import 'package:flutter/material.dart';

class ViewSelectedDetailHeader extends StatelessWidget {
  final User selectedUser;
  final Size size;
  final MatchesBloc _matchesBloc;
  final User currentUser;
  final int rTotal, pTotal;
  final double similarity;

  const ViewSelectedDetailHeader(
      {Key key,
      @required this.selectedUser,
      @required this.size,
      @required MatchesBloc matchesBloc,
      @required this.rTotal,
      @required this.pTotal,
      @required this.similarity,
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
          text: "Selected User Details",
          color: pureWhite,
        ),
        appBarColor: primary1,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1st Stack
          ListView(
            children: [
              ProfileHeaderContainer(
                size: size,
                currentUser: selectedUser,
                blur: selectedUser.blurAvatar == true ? 18 : 0,
                overlay: selectedUser.blurAvatar == true
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
                        height: size.height * 1.42,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            // Tab 1
                            Column(
                              children: [
                                ComparisonWidget(
                                  size: size,
                                  similarity: similarity,
                                  currentUser: currentUser,
                                  user: selectedUser,
                                  rTotal: rTotal,
                                  pTotal: pTotal,
                                ),
                                ProfileDetailListView(
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
                                  color: secondBlack,
                                ),
                                const SizedBox(height: 20),
                                ReligionQuoteFiller(
                                  size: size,
                                  similarity: similarity,
                                  quote:
                                      "“The greatest degree of inner tranquility comes from love and compassion. The more we care for the happiness of others, the greater is our own sense of wellbeing.”",
                                  author: "Dalai Lama",
                                  image: "iftar",
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
          // 2nd stack
          FloatingDoubleButtons(
            size: size,
            onDislikeTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackbar(
                  text:
                      "You disliked ${selectedUser.nickname} (${selectedUser.age}).",
                  duration: 3,
                  background: primaryBlack,
                ),
              );
              _matchesBloc.add(
                DeleteUserEvent(
                    currentUser: currentUser.uid,
                    selectedUser: selectedUser.uid),
              );
              Navigator.of(context).pop();
            },
            onLikeTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackbar(
                  text:
                      "You liked ${selectedUser.nickname} (${selectedUser.age}). 👍",
                  duration: 3,
                  background: primaryBlack,
                ),
              );
              _matchesBloc.add(
                AcceptUserEvent(
                  currentUser: currentUser.uid,
                  selectedUser: selectedUser.uid,
                  currentUserPhotoUrl: currentUser.photo,
                  selectedUserPhotoUrl: selectedUser.photo,
                  currentUserNickname: currentUser.nickname,
                  selectedUserNickname: selectedUser.nickname,
                  currentUserBlur: currentUser.blurAvatar,
                  selectedUserBlur: selectedUser.blurAvatar,
                  currentUserAge: currentUser.age,
                  selectedUserAge: selectedUser.age,
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
