import 'dart:convert';

import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/portalblog.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/chatroom_widgets/image_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogPage extends StatefulWidget {
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<PortalBlog>> portalBlogFuture = getBlog();
  static Future<List<PortalBlog>> getBlog() async {
    const url =
        'https://raw.githubusercontent.com/chelseaislan/chelseaislan.github.io/main/portalblog.json';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<PortalBlog>(PortalBlog.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: financialTimes,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Portal Blog",
          color: white,
        ),
        appBarColor: primary5,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => BlogPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: FutureBuilder<List<PortalBlog>>(
          future: portalBlogFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: secondBlack));
            } else if (snapshot.hasData) {
              final portalBlogLists = snapshot.data;
              return buildBlog(portalBlogLists);
            } else {
              return EmptyContent(
                size: MediaQuery.of(context).size,
                asset: "assets/images/discover-tab.png",
                header: "Uh-oh...",
                description:
                    "Looks like there is no one around. Please come back later.",
                buttonText: "Refresh",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          BlogPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              );
            }
          },
        ),
      ));

  buildBlog(List<PortalBlog> portalBlog) {
    return LimitedBox(
      maxHeight: 1375,
      child: ListView.builder(
        itemCount: portalBlog.length,
        shrinkWrap: true,
        // itemExtent: 1375,
        itemBuilder: (context, index) {
          final blog = portalBlog[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderTwoText(text: blog.blogTitle, color: secondBlack),
                const SizedBox(height: 5),
                SmallText(
                    text: "Written by ${blog.author} on ${blog.postDate}",
                    color: thirdBlack),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CardPhotoWidget(photoLink: blog.imageHeader)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DetailScreen(photoLink: blog.imageHeader),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ),
                DescText(text: blog.blogP1, color: primaryBlack),
                const SizedBox(height: 15),
                DescText(text: blog.blogP2, color: primaryBlack),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CardPhotoWidget(photoLink: blog.imageContent)),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DetailScreen(photoLink: blog.imageContent),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ),
                DescText(text: blog.blogP3, color: primaryBlack),
                const SizedBox(height: 20),
                HeaderFourText(text: "© MusliMatch, 2022", color: thirdBlack),
                const SizedBox(height: 10),
                PaddingDivider(color: thirdBlack),
              ],
            ),
          );
        },
      ),
    );
  }
}
