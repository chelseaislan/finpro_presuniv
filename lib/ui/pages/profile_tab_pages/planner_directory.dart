import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlannerPage extends StatelessWidget {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primary1,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Wedding Planner Directory",
          color: lightGrey1,
        ),
        appBarColor: primary1,
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: lightGrey1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          LoadPlanners(db: db, size: size, province: "Jabodetabek"),
        ],
      ),
    );
  }
}

class LoadPlanners extends StatelessWidget {
  const LoadPlanners({
    Key key,
    @required this.db,
    @required this.size,
    @required this.province,
  }) : super(key: key);

  final Firestore db;
  final Size size;
  final String province;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('directories')
          .where('province', isEqualTo: province)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(color: primary1));
        }
        if (snapshot.data.documents.isNotEmpty) {
          final planners = snapshot.data.documents;
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: ListView.builder(
              itemCount: planners.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 35,
                          child: Text(
                              planners[index].data['title']
                                  [0], // ambil karakter pertama text
                              style: const TextStyle(fontSize: 24)),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: HeaderThreeText(
                            text: planners[index].data['title'],
                            color: primaryBlack,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChatText(
                                text: planners[index].data['desc'],
                                color: thirdBlack,
                              ),
                              const SizedBox(height: 5),
                              SmallText(
                                text:
                                    "${planners[index].data['location']}, ${planners[index].data['province']}",
                                color: thirdBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                HeaderThreeText(
                                  text: planners[index].data['title'],
                                  color: primaryBlack,
                                ),
                                const SizedBox(height: 10),
                                SmallText(
                                  text: "Planner Description",
                                  color: thirdBlack,
                                ),
                                DescText(
                                  text: planners[index].data['desc'],
                                  color: primaryBlack,
                                ),
                                const SizedBox(height: 10),
                                SmallText(
                                  text: "Location",
                                  color: thirdBlack,
                                ),
                                DescText(
                                  text:
                                      "${planners[index].data['location']}, ${planners[index].data['province']}",
                                  color: primaryBlack,
                                ),
                                const SizedBox(height: 20),
                                BigWideButton(
                                  labelText: "Visit Website",
                                  onPressedTo: () async {
                                    var url =
                                        "https://${planners[index].data['website']}";
                                    if (await canLaunch(url) != null) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch website!';
                                    }
                                  },
                                  textColor: pureWhite,
                                  btnColor: primary1,
                                ),
                                const SizedBox(height: 10),
                                BigWideButton(
                                  labelText: "Chat via WhatsApp",
                                  onPressedTo: () async {
                                    var url =
                                        "https://wa.me/${planners[index].data['phone']}";
                                    if (await canLaunch(url) != null) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch website!';
                                    }
                                  },
                                  textColor: pureWhite,
                                  btnColor: primary1,
                                ),
                                const SizedBox(height: 10),
                                BigWideButton(
                                  labelText: "View Directions",
                                  onPressedTo: () async {
                                    var url =
                                        "https://www.google.com/maps/search/${planners[index].data['title']}/";
                                    if (await canLaunch(url) != null) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch website!';
                                    }
                                  },
                                  textColor: pureWhite,
                                  btnColor: primary1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        } else {
          return EmptyContent(
            size: size,
            asset: "assets/images/discover-tab.png",
            header: "Is it empty?",
            description:
                "Don't worry, we'll keep adding more wedding planner directories to you. Stay tuned!",
            buttonText: "Refresh",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      PlannerPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          );
        }
      },
    );
  }
}
