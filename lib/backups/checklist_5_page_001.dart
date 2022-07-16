// import 'dart:math';

// import 'package:confetti/confetti.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
// import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max/custom_widgets/divider.dart';
// import 'package:finpro_max/custom_widgets/modal_popup.dart';
// import 'package:finpro_max/custom_widgets/quran_verses.dart';
// import 'package:finpro_max/custom_widgets/text_styles.dart';
// import 'package:finpro_max/models/colors.dart';
// import 'package:finpro_max/models/user.dart';
// import 'package:finpro_max/repositories/taaruf_repository.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_done.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_calendar.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:quran/quran.dart' as quran;
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ChecklistFive extends StatefulWidget {
//   final String currentUserId, selectedUserId;
//   const ChecklistFive({this.currentUserId, this.selectedUserId});

//   @override
//   State<ChecklistFive> createState() => _ChecklistFiveState();
// }

// class _ChecklistFiveState extends State<ChecklistFive>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   final TaarufRepository _taarufRepository = TaarufRepository();
//   TaarufBloc _taarufBloc;
//   User _selectedUser, _currentUser;
//   final YoutubePlayerController _ytController = YoutubePlayerController(
//     initialVideoId: 'WK3sFtyOaNM',
//     flags: const YoutubePlayerFlags(
//         forceHD: false,
//         autoPlay: false,
//         mute: false,
//         captionLanguage: "en",
//         enableCaption: true),
//   );
//   ConfettiController _controllerBottomCenter;

//   @override
//   void initState() {
//     _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
//     _controllerBottomCenter =
//         ConfettiController(duration: const Duration(seconds: 3));
//     super.initState();
//     _animationController = BottomSheet.createAnimationController(this);
//     _animationController.duration = const Duration(seconds: 0);
//   }

//   @override
//   void dispose() {
//     _controllerBottomCenter.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: primary5,
//       appBar: AppBarSideButton(
//         appBarTitle: const Text("Taaruf Checklist - 5"),
//         appBarColor: primary1,
//         appBarIcon: Icons.home_outlined,
//         onPressed: () {
//           Navigator.pushAndRemoveUntil(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation1, animation2) =>
//                   HomeTabs(userId: widget.currentUserId, selectedPage: 3),
//               transitionDuration: Duration.zero,
//               reverseTransitionDuration: Duration.zero,
//             ),
//             (route) => false,
//           );
//         },
//         tooltip: "Home",
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => Navigator.pushReplacement(context, reloadAfterSave()),
//         child: BlocBuilder<TaarufBloc, TaarufState>(
//           bloc: _taarufBloc,
//           builder: (context, state) {
//             if (state is TaarufLoadingState) {
//               _taarufBloc.add(TaarufLoadUserEvent(
//                 currentUserId: widget.currentUserId,
//                 selectedUserId: widget.selectedUserId,
//               ));
//             }
//             if (state is TaarufLoadUserState) {
//               _selectedUser = state.selectedUser;
//               _currentUser = state.currentUser;
//               if (_selectedUser.nickname != null) {
//                 _controllerBottomCenter.play();
//                 return Stack(
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TaarufHeader(
//                             size: size,
//                             header: "Blessed day, ${_currentUser.nickname}!",
//                             description:
//                                 "Finally, you and ${_selectedUser.nickname} reached the most important part of it all!",
//                             photoLink:
//                                 "https://i.giphy.com/urgh3QkW9wgG8goYCQ.gif",
//                           ),
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: size.width * 0.05,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 HeaderTwoText(
//                                   text: quran.getVerse(30, 21,
//                                       verseEndSymbol: true),
//                                   color: white,
//                                   align: TextAlign.right,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const QuranFive(),
//                                 const SizedBox(height: 10),
//                                 PaddingDivider(color: white),
//                                 DescText(
//                                   text:
//                                       "Blessed be the fruit! After all the hard work both of you have done, you have reached the final stage of taaruf - the marriage itself (nikah).\n\nHere are few things to be looked for when doing the marriage preparation:",
//                                   color: white,
//                                 ),
//                                 const SizedBox(height: 20),
//                                 YoutubePlayer(
//                                   controller: _ytController,
//                                   showVideoProgressIndicator: true,
//                                   progressIndicatorColor: gold,
//                                   progressColors: const ProgressBarColors(
//                                     playedColor: Colors.amber,
//                                     handleColor: Colors.amberAccent,
//                                   ),
//                                   onReady: () {},
//                                 ),
//                                 const SizedBox(height: 20),
//                                 HeaderFourText(
//                                   text: "Hacks Every Bride Needs to Know",
//                                   color: white,
//                                 ),
//                                 ChatText(
//                                     text:
//                                         "Sharrah Stevens - The Kinwoven Home - YouTube",
//                                     color: white),
//                                 const SizedBox(height: 5),
//                               ],
//                             ),
//                           ),
//                           PaddingDivider(color: white),
//                           TaarufCalendar(
//                             size: size,
//                             header:
//                                 "When will both of you perform the marriage?",
//                             dateText: _currentUser.marriageD != null
//                                 ? "Marriage Date: ${_currentUser.marriageD.toDate().day}/${_currentUser.marriageD.toDate().month}/${_currentUser.marriageD.toDate().year}"
//                                 : "Marriage Date: ",
//                             onCalendarTap: () {
//                               showModalBottomSheet(
//                                 transitionAnimationController:
//                                     _animationController,
//                                 context: context,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                   ),
//                                 ),
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: ModalPopupOneButton(
//                                       size: size,
//                                       title: "Godspeed!",
//                                       image: "assets/images/wedding.png",
//                                       description:
//                                           "This will be the greatest day of your life.\nWe hope that both of you can maintain the commitment and live happily ever after.",
//                                       onPressed: () {
//                                         DatePicker.showDatePicker(context,
//                                             locale: LocaleType.id,
//                                             showTitleActions: true,
//                                             minTime: DateTime.now(),
//                                             // must be atleast 18 yo
//                                             maxTime: DateTime(2024, 12, 31),
//                                             onConfirm: (date) {
//                                           setState(() {
//                                             _taarufBloc.add(AddCalendarDEvent(
//                                               currentUserId:
//                                                   widget.currentUserId,
//                                               selectedUserId:
//                                                   widget.selectedUserId,
//                                               taarufCheck: 5,
//                                               marriageD: date,
//                                             ));
//                                             Fluttertoast.showToast(
//                                                 msg: "Date has been updated");
//                                             Navigator.pushReplacement(
//                                                 context, reloadAfterSave());
//                                           });
//                                         });
//                                       },
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                           PaddingDivider(color: white),
//                           MarriageButtons(
//                             size: size,
//                             onPressedBottom: () {
//                               showModalBottomSheet(
//                                 transitionAnimationController:
//                                     _animationController,
//                                 context: context,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                   ),
//                                 ),
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: ModalPopupOneButton(
//                                       size: size,
//                                       title: "Are you really sure?",
//                                       image: "assets/images/divorce.png",
//                                       description:
//                                           "Look what you and ${_selectedUser.nickname} have been through after all of these steps.\n\nPlease discuss this first with ${_selectedUser.nickname}, and if you still wanna cancel, you may delete your taaruf data from the profile page.",
//                                       onPressed: () => Navigator.pop(context),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             onPressedTop: () {
//                               if (_currentUser.marriageD != null) {
//                                 if (DateTime.now()
//                                     .isAfter(_currentUser.marriageD.toDate())) {
//                                   return Navigator.push(
//                                     context,
//                                     PageRouteBuilder(
//                                       pageBuilder:
//                                           (context, animation1, animation2) =>
//                                               ChecklistDone(
//                                         currentUserId: widget.currentUserId,
//                                         selectedUserId: widget.selectedUserId,
//                                       ),
//                                       transitionDuration: Duration.zero,
//                                       reverseTransitionDuration: Duration.zero,
//                                     ),
//                                   );
//                                 } else if (DateTime.now().isBefore(
//                                     _currentUser.marriageD.toDate())) {
//                                   return Fluttertoast.showToast(
//                                       msg:
//                                           "Please wait until the specified date to go to the next step.");
//                                 }
//                               } else {
//                                 return Fluttertoast.showToast(
//                                     msg: "Please specify the date.");
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: ConfettiWidget(
//                         confettiController: _controllerBottomCenter,
//                         blastDirection: -pi / 2,
//                         emissionFrequency: 0.05,
//                         numberOfParticles: 20,
//                         maxBlastForce: 100,
//                         minBlastForce: 80,
//                         gravity: 0.2,
//                         particleDrag: 0.05, // apply drag to the confetti
//                         shouldLoop: false,
//                         colors: [
//                           gold,
//                           appBarColor,
//                           primary3,
//                         ], // manually specify the colors to be used
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   PageRouteBuilder<dynamic> reloadAfterSave() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation1, animation2) => super.widget,
//       transitionDuration: Duration.zero,
//       reverseTransitionDuration: Duration.zero,
//     );
//   }
// }
