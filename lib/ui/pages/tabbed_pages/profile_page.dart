// @dart=2.9

import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finpro_max/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max/bloc/authentication/authentication_event.dart';
import 'package:finpro_max/bloc/profile/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/profile_overview.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/home.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/account_status_upgrade.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/profile_details_page.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TextEditingController _ySuggestionController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  double expRating, appRating;
  int yExpRating, yAppRating;
  // int counter = 0;
  // File story;
  // check internet connection
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _profileBloc = ProfileBloc(userRepository: _userRepository);
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
    // check internet in initial state
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // initialize connectivity async method
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() => _connectionStatus = result);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List titles = [
      // "Upload a Story",
      "Profile Details",
      "My Legal Documents",
      "Reset Taaruf Properties",
      "Rate and Feedback",
      "About Application",
      "Log Out",
    ];

    final List subtitles = [
      // "Your stories will be displayed on your profile details.",
      "View and edit your profile details here.",
      "View your submitted KTP and the additional document.",
      "This will reset all your taaruf properties, such as marriage dates and who you did it with.",
      "Give us your stars and precious feedback!",
      "View the author and licenses of this Flutter application.",
      "You will need to log back in.",
    ];

    final List icons = [
      // Icons.self_improvement_outlined,
      Icons.account_circle_outlined,
      Icons.domain_verification_outlined,
      Icons.clear_all_outlined,
      Icons.rate_review_outlined,
      Icons.info_outlined,
      Icons.logout_outlined,
    ];

    final List onTap = [
      // () {
      //   showModalBottomSheet(
      //     context: context,
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(10),
      //         topRight: Radius.circular(10),
      //       ),
      //     ),
      //     isScrollControlled: true,
      //     builder: (context) {
      //       return SingleChildScrollView(
      //         child: ModalPopupTwoButton(
      //           size: size,
      //           title: "How do you want to upload?",
      //           image: "assets/images/story.png",
      //           description:
      //               "You can share anything you like, but remember not to be inappropriate.",
      //           labelTop: "Open Camera",
      //           labelBottom: "Upload via Gallery",
      //           textColorTop: white,
      //           btnTop: primary1,
      //           textColorBottom: white,
      //           btnBottom: primary1,
      //           onPressedTop: () async {
      //             PickedFile captureStory = await ImagePicker().getImage(
      //               source: ImageSource.camera,
      //               maxWidth: 1800,
      //               maxHeight: 1800,
      //             );
      //             if (captureStory != null) {
      //               Fluttertoast.showToast(
      //                 msg: "Uploading story...",
      //                 toastLength: Toast.LENGTH_LONG,
      //               );
      //               setState(() {
      //                 story = File(captureStory.path);
      //                 counter++;
      //               });
      //               _profileBloc.add(
      //                 UploadStoryEvent(
      //                   userId: widget.userId,
      //                   counter: counter,
      //                   story: story,
      //                 ),
      //               );
      //             }
      //             Navigator.pushAndRemoveUntil(
      //               context,
      //               PageRouteBuilder(
      //                 pageBuilder: (context, animation1, animation2) =>
      //                     HomeTabs(userId: widget.userId, selectedPage: 4),
      //                 transitionDuration: Duration.zero,
      //                 reverseTransitionDuration: Duration.zero,
      //               ),
      //               ((route) => false),
      //             );
      //           },
      //           onPressedBottom: () async {
      //             try {
      //               File uploadStory =
      //                   await FilePicker.getFile(type: FileType.image);
      //               if (uploadStory != null) {
      //                 setState(() {
      //                   story = uploadStory;
      //                   counter++;
      //                   Fluttertoast.showToast(
      //                       msg: "Uploading story...",
      //                       toastLength: Toast.LENGTH_LONG);
      //                   _profileBloc.add(
      //                     UploadStoryEvent(
      //                       userId: widget.userId,
      //                       counter: counter,
      //                       story: story,
      //                     ),
      //                   );
      //                 });
      //               }
      //               Navigator.pushAndRemoveUntil(
      //                 context,
      //                 PageRouteBuilder(
      //                   pageBuilder: (context, animation1, animation2) =>
      //                       HomeTabs(userId: widget.userId, selectedPage: 4),
      //                   transitionDuration: Duration.zero,
      //                   reverseTransitionDuration: Duration.zero,
      //                 ),
      //                 ((route) => false),
      //               );
      //             } catch (e) {
      //               showModalBottomSheet(
      //                 context: context,
      //                 shape: const RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(10),
      //                     topRight: Radius.circular(10),
      //                   ),
      //                 ),
      //                 builder: (context) {
      //                   return ModalPopupOneButton(
      //                     size: size,
      //                     title: "Storage Permission Denied",
      //                     image: "assets/images/404.png",
      //                     description:
      //                         "To upload pictures and documents, please enable permission to read external storage.",
      //                     onPressed: () => Navigator.pop(context),
      //                   );
      //                 },
      //               );
      //             }
      //           },
      //         ),
      //       );
      //     },
      //   );
      // },
      () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProfileDetails(userId: widget.userId),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                AccountStatusUpgrade(userId: widget.userId),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      () {
        showModalBottomSheet(
          transitionAnimationController: _animationController,
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
                title: "Confirmation",
                image: "assets/images/reset.png",
                description:
                    "Reset any taaruf properties that you currently have? (Marriage dates etc.)",
                labelTop: "No",
                labelBottom: "Clear Data",
                textColorTop: white,
                btnTop: primary1,
                textColorBottom: white,
                btnBottom: primary2,
                onPressedTop: () => Navigator.pop(context),
                onPressedBottom: () {
                  _profileBloc.add(ResetTaarufEvent(userId: widget.userId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    mySnackbar(
                      text: "Taaruf properties has been reset.",
                      duration: 3,
                      background: primaryBlack,
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomeTabs(userId: widget.userId, selectedPage: 4),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    ((route) => false),
                  );
                },
              ),
            );
          },
        );
      },
      () {
        showModalBottomSheet(
          transitionAnimationController: _animationController,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderFourText(
                      text:
                          "How was your experience of finding a partner using this app?",
                      color: secondBlack,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied_rounded,
                              color: Colors.red,
                            );
                            break;
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied_rounded,
                              color: Colors.redAccent,
                            );
                            break;
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral_rounded,
                              color: Colors.amber,
                            );
                            break;
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied_rounded,
                              color: Colors.lightGreen,
                            );
                            break;
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied_rounded,
                              color: Colors.blue,
                            );
                            break;
                          default:
                            break;
                        }
                        return Container();
                      },
                      onRatingUpdate: (rating) {
                        debugPrint("Your expRating: $rating");
                        setState(() {
                          expRating = rating;
                          yExpRating = rating.toInt();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    PaddingDivider(color: lightGrey3),
                    HeaderFourText(
                      text:
                          "How was your overall experience of using this app?",
                      color: secondBlack,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 0,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: gold,
                          ),
                          onRatingUpdate: (rating) {
                            debugPrint("Your appRating: $rating");
                            setState(() {
                              appRating = rating;
                              yAppRating = appRating.toInt();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    PaddingDivider(color: lightGrey3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeaderFourText(
                          text:
                              "Any comments or suggestions for us?\nLeave them on the text field below.",
                          color: secondBlack,
                          align: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          // autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _ySuggestionController, // 2
                          decoration: InputDecoration(
                            hintText: "Comments and Suggestions",
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 3, color: lightGrey2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 3, color: lightGrey3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    BigWideButton(
                      labelText: "Submit",
                      onPressedTo: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          mySnackbar(
                            text: "Thanks for the feedback! 👍",
                            duration: 3,
                            background: primaryBlack,
                          ),
                        );
                        _profileBloc.add(SubmitRatingEvent(
                          userId: widget.userId,
                          yAppRating: yAppRating,
                          yExpRating: yExpRating,
                          ySuggestionRating: _ySuggestionController.text,
                        ));
                        Navigator.pop(context);
                      },
                      textColor: white,
                      btnColor: primary1,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        );
      },
      () {
        showAboutDialog(
          applicationLegalese:
              "“Under his eye,” she says. The right farewell. “Under his eye,” I reply, and she gives a little nod.\n\n(The Handmaid's Tale by Margaret Atwood - 1985)\n\n",
          applicationIcon: CircleAvatar(
            child: Image.asset("assets/images/1024.png"),
          ),
          applicationName: "MusliMatch",
          applicationVersion: "0.0.1-NTBC",
          children: [
            HeaderThreeText(
                text: "Rifqi Rachmanda Eryawan", color: secondBlack),
            SmallText(text: "001201700004", color: thirdBlack),
          ],
          context: context,
        );
      },
      () {
        showModalBottomSheet(
          transitionAnimationController: _animationController,
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
                title: "Confirmation",
                image: "assets/images/logout.png",
                description:
                    "Are you sure you want to log out, ${_currentUser.nickname}? You can log back in anytime.",
                labelTop: "No",
                labelBottom: "Log Out",
                textColorTop: white,
                btnTop: primary1,
                textColorBottom: white,
                btnBottom: primary2,
                onPressedTop: () => Navigator.pop(context),
                onPressedBottom: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Home(userRepository: _userRepository),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    (route) => false,
                  );
                },
              ),
            );
          },
        );
      },
    ];

    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: const Text("My Profile"),
        appBarColor: appBarColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(userId: widget.userId, selectedPage: 4),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
            ((route) => false),
          );
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            // check internet after builder
            if (_connectionStatus == ConnectivityResult.mobile ||
                _connectionStatus == ConnectivityResult.wifi) {
              // check app states
              if (state is ProfileInitialState) {
                _profileBloc.add(ProfileLoadedEvent(userId: widget.userId));
              }
              if (state is ProfileLoadingState) {
                return Center(
                    child: CircularProgressIndicator(color: primary1));
              }
              if (state is ProfileLoadedState) {
                _currentUser = state.currentUser;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileOverviewWidget(
                        photo: _currentUser.photo,
                        name: _currentUser.name,
                        location:
                            "${_currentUser.location}, ${_currentUser.province}",
                        accountType: _currentUser.accountType,
                        currentJob:
                            "${_currentUser.jobPosition} at ${_currentUser.currentJob}",
                        taarufWith: _currentUser.taarufWith != null
                            ? "Taaruf: Active"
                            : "Taaruf: Inactive",
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: titles.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: SizedBox(
                                  height: double.infinity,
                                  child: Icon(icons[index],
                                      color: primary1, size: 30),
                                ),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 2),
                                  child: HeaderFourText(
                                      text: titles[index], color: primaryBlack),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ChatText(
                                      text: subtitles[index],
                                      color: secondBlack),
                                ),
                                onTap: onTap[index],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 15),
                        child: Center(
                          child: SmallText(
                            text: "User ID: ${_currentUser.uid}",
                            color: thirdBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return EmptyContent(
                size: size,
                asset: "assets/images/empty-container.png",
                header: "Oops...",
                description:
                    "Looks like the Internet is down or something else happened. Please try again later.",
                buttonText: "Refresh",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomeTabs(userId: widget.userId, selectedPage: 4),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    ((route) => false),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
