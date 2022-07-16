// import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
// import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max/custom_widgets/divider.dart';
// import 'package:finpro_max/custom_widgets/modal_popup.dart';
// import 'package:finpro_max/custom_widgets/text_styles.dart';
// import 'package:finpro_max/models/colors.dart';
// import 'package:finpro_max/models/user.dart';
// import 'package:finpro_max/repositories/taaruf_repository.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_5_page.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_calendar.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ChecklistFour extends StatefulWidget {
//   final String currentUserId, selectedUserId;
//   const ChecklistFour({this.currentUserId, this.selectedUserId});

//   @override
//   State<ChecklistFour> createState() => _ChecklistFourState();
// }

// class _ChecklistFourState extends State<ChecklistFour>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   final TaarufRepository _taarufRepository = TaarufRepository();
//   TaarufBloc _taarufBloc;
//   User _selectedUser, _currentUser;
//   final YoutubePlayerController _ytController = YoutubePlayerController(
//     initialVideoId: 'cBi34VSCgIg',
//     flags: const YoutubePlayerFlags(
//         forceHD: false,
//         autoPlay: false,
//         mute: false,
//         captionLanguage: "en",
//         enableCaption: true),
//   );

//   @override
//   void initState() {
//     _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
//     super.initState();
//     _animationController = BottomSheet.createAnimationController(this);
//     _animationController.duration = const Duration(seconds: 0);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     final List headersD = [
//       "1. Asking guidance from Allah, and reciting sholawat and prayers",
//       "2. Expressing the purpose and intentions",
//       "3. Handing over gifts and closing",
//     ];

//     final List descriptionsD = [
//       "The male bride should recite the blessings to Allah and the Prophet, then he and his family can visit the female bride's household to express their intentions.",
//       "This is the core of the event, when the male bride and his family wants to marry the female bride. After that, the female bride and her family accept their counterpart's intentions.",
//       "This gift acts to show the seriousness of the male bride to marry the female bride. After that, the event will be closed by prayers for their future marriage.",
//     ];

//     return Scaffold(
//       backgroundColor: primary5,
//       appBar: AppBarSideButton(
//         appBarTitle: const Text("Taaruf Checklist - 4"),
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
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TaarufHeader(
//                         size: size,
//                         header: "Good day, ${_currentUser.nickname}!",
//                         description:
//                             "You did it well with ${_selectedUser.nickname}! Now it's time for the marriage proposal or known as Khitbah.",
//                         photoLink:
//                             "https://media.giphy.com/media/7TwWM1k5dxWgOd0oMH/giphy-downsized.gif",
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: size.width * 0.05,
//                         ),
//                         child: DescText(
//                           text:
//                               "Khitbah is the process of the marriage proposal, when the family of the groom (male bride) visits the house of the family of the female bride and voice his intention to propose, accompanied with a 3rd party. Here are the steps:",
//                           color: white,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: size.width * 0.05,
//                           vertical: 5,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               shrinkWrap: true,
//                               itemCount: headersD.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     HeaderFourText(
//                                         text: headersD[index], color: white),
//                                     const SizedBox(height: 5),
//                                     ChatText(
//                                       text: descriptionsD[index],
//                                       color: white,
//                                     ),
//                                     const SizedBox(height: 15),
//                                   ],
//                                 );
//                               },
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 10, bottom: 20),
//                               child: YoutubePlayer(
//                                 controller: _ytController,
//                                 showVideoProgressIndicator: true,
//                                 progressIndicatorColor: gold,
//                                 progressColors: const ProgressBarColors(
//                                   playedColor: Colors.amber,
//                                   handleColor: Colors.amberAccent,
//                                 ),
//                                 onReady: () {},
//                               ),
//                             ),
//                             HeaderFourText(
//                               text:
//                                   "Don't just throw it out without serious consideration. A Proposal is a blessing from Allah.",
//                               color: white,
//                             ),
//                             ChatText(
//                                 text: "Mufti Menk - YouTube", color: white),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                       PaddingDivider(color: white),
//                       TaarufCalendar(
//                         size: size,
//                         header: "Please set the time to conduct the event:",
//                         dateText: _currentUser.marriageC != null
//                             ? "Event Date: ${_currentUser.marriageC.toDate().day}/${_currentUser.marriageC.toDate().month}/${_currentUser.marriageC.toDate().year}"
//                             : "Event Date: ",
//                         onCalendarTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) => AlertDialog(
//                               title: const Text("Reminder"),
//                               content: Text(
//                                   "Please set the date as early as possible to avoid the possibility of fitnah.\n\nWhile doing the marriage proposal, please give some kindness and respect to the families as you and ${_selectedUser.nickname} will perform the marriage soon."),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text("No"),
//                                 ),
//                                 TextButton(
//                                   child: const Text("Yes"),
//                                   onPressed: () {
//                                     DatePicker.showDatePicker(context,
//                                         locale: LocaleType.id,
//                                         showTitleActions: true,
//                                         minTime: DateTime.now(),
//                                         // must be atleast 18 yo
//                                         maxTime: DateTime(2024, 12, 31),
//                                         onConfirm: (date) {
//                                       setState(() {
//                                         _taarufBloc.add(AddCalendarCEvent(
//                                           currentUserId: widget.currentUserId,
//                                           selectedUserId: widget.selectedUserId,
//                                           taarufCheck: 4,
//                                           marriageC: date,
//                                         ));
//                                         Fluttertoast.showToast(
//                                             msg: "Date has been updated");
//                                         Navigator.pushReplacement(
//                                             context, reloadAfterSave());
//                                       });
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       PaddingDivider(color: white),
//                       MarriageButtons(
//                         size: size,
//                         onPressedBottom: () {
//                           showModalBottomSheet(
//                             transitionAnimationController: _animationController,
//                             context: context,
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                               ),
//                             ),
//                             builder: (context) {
//                               return SingleChildScrollView(
//                                 child: ModalPopupOneButton(
//                                   size: size,
//                                   title: "Are you really sure?",
//                                   image: "assets/images/divorce.png",
//                                   description:
//                                       "Look what you and ${_selectedUser.nickname} have been through after all of these steps.\n\nPlease discuss this first with ${_selectedUser.nickname}, and if you still wanna cancel, you may delete your taaruf data from the profile page.",
//                                   onPressed: () => Navigator.pop(context),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         onPressedTop: () {
//                           if (_currentUser.marriageC != null) {
//                             if (DateTime.now()
//                                 .isAfter(_currentUser.marriageC.toDate())) {
//                               return showModalBottomSheet(
//                                 transitionAnimationController:
//                                     _animationController,
//                                 context: context,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                   ),
//                                 ),
//                                 isScrollControlled: true,
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: ModalPopupTwoButton(
//                                       size: size,
//                                       title: "Confirmation",
//                                       image: "assets/images/proposal.png",
//                                       description:
//                                           "Are you ready to marry ${_selectedUser.nickname} and become one partner for life? This will be your best day.",
//                                       labelTop: "No",
//                                       labelBottom: "Continue",
//                                       textColorTop: secondBlack,
//                                       btnTop: lightGrey3,
//                                       textColorBottom: secondBlack,
//                                       btnBottom: gold,
//                                       onPressedTop: () =>
//                                           Navigator.pop(context),
//                                       onPressedBottom: () {
//                                         Navigator.pushReplacement(
//                                           context,
//                                           PageRouteBuilder(
//                                             pageBuilder: (context, animation1,
//                                                     animation2) =>
//                                                 ChecklistFive(
//                                               currentUserId:
//                                                   widget.currentUserId,
//                                               selectedUserId:
//                                                   widget.selectedUserId,
//                                             ),
//                                             transitionDuration: Duration.zero,
//                                             reverseTransitionDuration:
//                                                 Duration.zero,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else if (DateTime.now()
//                                 .isBefore(_currentUser.marriageC.toDate())) {
//                               return Fluttertoast.showToast(
//                                   msg:
//                                       "Please wait until the specified date to go to the next step.");
//                             }
//                           } else {
//                             return Fluttertoast.showToast(
//                                 msg: "Please specify the date.");
//                           }
//                         },
//                       ),
//                     ],
//                   ),
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
