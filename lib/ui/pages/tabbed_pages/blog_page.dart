import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/portalblog.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class BlogPage extends StatefulWidget {
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<PortalBlog> portalBlog = getBlog();

  static List<Map<String, dynamic>> data;
  static List<PortalBlog> getBlog() {
    data = [
      {
        "blogTitle": "Success Story of Fred Waterford and Serena Joy",
        "imageHeader":
            "https://www.cheatsheet.com/wp-content/uploads/2021/04/Waterfords-Handmaids-Tale-1024x683.jpg",
        "author": "Fabrizio Romano",
        "postDate": "30 June 2022",
        "blogP1": lorem(paragraphs: 1, words: 50),
        "blogP2": lorem(paragraphs: 1, words: 40),
        "imageContent":
            "https://4.bp.blogspot.com/-y2R5PJHTRxE/WTg1hknfWKI/AAAAAAAAqos/DEPszVpMi9UMem128ExBN6uNTbe__YrpgCEw/s1600/4n.jpg",
        "blogP3": lorem(paragraphs: 1, words: 30),
      },
      {
        "blogTitle": "Marriage in the 22nd Century",
        "imageHeader":
            "https://imgix.bustle.com/uploads/image/2018/5/1/6d1fda71-dbf9-48b1-9ce1-397489358f17-tht_202_gk_0191rt.jpg?w=970&h=582&fit=crop&crop=faces&auto=format&q=70",
        "author": "Elisabeth Moss",
        "postDate": "28 June 2022",
        "blogP1": lorem(paragraphs: 1, words: 50),
        "blogP2": lorem(paragraphs: 1, words: 40),
        "imageContent":
            "https://imgix.bustle.com/uploads/image/2018/4/17/b8d3007b-4d0d-487c-8cd0-4c13ddd5acf9-handmaidstaleta.jpg?w=1020&h=574&fit=crop&crop=faces&auto=format&q=70",
        "blogP3": lorem(paragraphs: 1, words: 30),
      },
    ];

    return data.map<PortalBlog>(PortalBlog.fromJson).toList();
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
        body: buildBlog(portalBlog),
      );

  buildBlog(List<PortalBlog> portalBlog) => ListView.builder(
        itemCount: portalBlog.length,
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CardPhotoWidget(photoLink: blog.imageHeader)),
                ),
                DescText(text: blog.blogP1, color: primaryBlack),
                const SizedBox(height: 15),
                DescText(text: blog.blogP2, color: primaryBlack),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CardPhotoWidget(photoLink: blog.imageContent)),
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
      );
}
