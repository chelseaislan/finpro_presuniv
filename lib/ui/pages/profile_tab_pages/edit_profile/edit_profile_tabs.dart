// @dart=2.9
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_additional_details.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_personal_prefs.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_profile_page.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_religion_details.dart';
import 'package:flutter/material.dart';

class EditProfileTabs extends StatelessWidget {
  final userId;
  int selectedPage;
  EditProfileTabs({this.userId, @required this.selectedPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      EditProfile(userId: userId),
      EditReligionDetails(userId: userId),
      EditAdditionals(userId: userId),
      EditPersonalPrefs(userId: userId),
    ];
    return DefaultTabController(
      initialIndex: selectedPage,
      animationDuration: Duration.zero,
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: pages,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: menu(),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: primary1,
      child: TabBar(
        isScrollable: true,
        indicatorColor: gold,
        labelColor: gold,
        unselectedLabelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(5.0),
        tabs: const [
          Tab(text: "Basic Details"),
          Tab(text: "Religion Details"),
          Tab(text: "Additional Details"),
          Tab(text: "Personal Preferences"),
        ],
      ),
    );
  }
}
