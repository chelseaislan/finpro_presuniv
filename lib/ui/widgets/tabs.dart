// @dart=2.9
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/discover_swipe.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/matches_page.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/messages_page.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/profile_page.dart';
import 'package:finpro_max/ui/pages/tabbed_pages/search_profile.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatelessWidget {
  final userId;
  int selectedPage;
  HomeTabs({this.userId, this.selectedPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DiscoverSwipe(userId: userId),
      SearchProfile(userId: userId),
      MatchesPage(userId: userId),
      MessagesPage(userId: userId),
      ProfilePage(userId: userId),
    ];
    return DefaultTabController(
      initialIndex: selectedPage,
      animationDuration: Duration.zero,
      length: pages.length,
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
      decoration: BoxDecoration(
        color: primary1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: secondBlack,
            blurRadius: 3.0,
            spreadRadius: 0.01,
          ),
        ],
      ),
      child: TabBar(
        isScrollable: false,
        indicatorColor: Colors.amber,
        labelColor: Colors.amber,
        unselectedLabelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(5.0),
        tabs: [
          Tab(
              icon: const Icon(Icons.charging_station_outlined),
              child: MiniText(text: "For You", color: white)),
          Tab(
            icon: const Icon(Icons.manage_search_outlined),
            child: MiniText(text: "Search", color: white),
          ),
          Tab(
            icon: const Icon(Icons.stars_outlined),
            child: MiniText(text: "Matches", color: white),
          ),
          Tab(
            icon: const Icon(Icons.chat_outlined),
            child: MiniText(text: "Chats", color: white),
          ),
          Tab(
            icon: const Icon(Icons.person_outline_outlined),
            child: MiniText(text: "Profile", color: white),
          ),
        ],
      ),
    );
  }
}
