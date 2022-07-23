// @dart=2.9
import 'package:finpro_max/bloc/profile/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/profile_detail_listview.dart';
import 'package:finpro_max/custom_widgets/religion_filler.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_profile_tabs.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/profile_match_header_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetails extends StatefulWidget {
  final String userId;
  ProfileDetails({this.userId});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final UserRepository _currentUserRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  DropdownList _dropdownList;

  @override
  void initState() {
    _profileBloc = ProfileBloc(userRepository: _currentUserRepository);
    _dropdownList = DropdownList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGrey1,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Your Profile Details",
          color: white,
        ),
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
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            if (state is ProfileInitialState) {
              _profileBloc.add(ProfileLoadedEvent(userId: widget.userId));
            }
            if (state is ProfileLoadingState) {
              return Center(child: CircularProgressIndicator(color: primary1));
            }
            if (state is ProfileLoadedState) {
              _currentUser = state.currentUser;
              final List aboutHeaders = [
                "Full Legal Name",
                "Nickname",
                "Date of Birth",
                "Age",
                "Company / Organization",
                "Job Position",
                "Location",
                "Hobby",
                "About the User",
              ];

              final List aboutContents = [
                _currentUser.name,
                _currentUser.nickname,
                "${_currentUser.dob.toDate().day}/${_currentUser.dob.toDate().month}/${_currentUser.dob.toDate().year}",
                "${(DateTime.now().year - _currentUser.dob.toDate().year)} years old",
                _currentUser.currentJob,
                _currentUser.jobPosition,
                "${_currentUser.location}, ${_currentUser.province}",
                _currentUser.hobby,
                _currentUser.aboutMe,
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Main properties
                    ProfileHeaderContainer(
                      size: size,
                      currentUser: _currentUser,
                      blur: 0,
                      overlay: Container(),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Card(
                        child: ListTile(
                          leading: SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.edit_note_outlined,
                              size: 30,
                              color: primary1,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 2),
                            child: HeaderFourText(
                                text: "Edit Profile Details",
                                color: primaryBlack),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ChatText(
                                text:
                                    "Basic / Religion / Additional / Personal Preferences",
                                color: secondBlack),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        EditProfileTabs(
                                  userId: widget.userId,
                                  selectedPage: 0,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
                                  Tab(text: "About ${_currentUser.nickname}"),
                                  Tab(
                                      text:
                                          "${_currentUser.nickname}'s Religion Details"),
                                  // const Tab(text: "YOUR Religion Details"),
                                  Tab(
                                      text:
                                          "${_currentUser.nickname}'s Personal Details"),
                                  // const Tab(text: "YOUR Personal Details"),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              height: size.height * 1.27,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Tab 1
                                  Column(
                                    children: [
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
                                        similarity: 1,
                                        quote:
                                            "“The best love is the kind that awakens the soul; that makes us reach for more, that plants the fire in our hearts and brings peace to our minds.”",
                                        author: "Noah from The Notebook",
                                        image: "upgrayedd",
                                      ),
                                    ],
                                  ),
                                  // Tab 3
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
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
