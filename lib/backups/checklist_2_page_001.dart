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
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_3_page.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_calendar.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:group_button/group_button.dart';
// import 'package:quran/quran.dart' as quran;
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ChecklistTwo extends StatefulWidget {
//   final String currentUserId, selectedUserId;
//   const ChecklistTwo({this.currentUserId, this.selectedUserId});

//   @override
//   State<ChecklistTwo> createState() => _ChecklistTwoState();
// }

// class _ChecklistTwoState extends State<ChecklistTwo>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   final TaarufRepository _taarufRepository = TaarufRepository();
//   TaarufBloc _taarufBloc;
//   User _selectedUser, _currentUser;
//   final YoutubePlayerController _ytController = YoutubePlayerController(
//     initialVideoId: 'BexolxafteM',
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

//     return Scaffold(
//       backgroundColor: primary5,
//       appBar: AppBarSideButton(
//         appBarTitle: const Text("Taaruf Checklist - 2"),
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
//                         header: "Blessed day, ${_currentUser.nickname}!",
//                         description:
//                             "How's your visit to the first parents? Did it went well?",
//                         photoLink:
//                             "https://media.giphy.com/media/bFuP8jviH6SUYRaBsa/giphy.gif",
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: size.width * 0.05,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             HeaderTwoText(
//                               text:
//                                   quran.getVerse(24, 32, verseEndSymbol: true),
//                               color: white,
//                               align: TextAlign.right,
//                             ),
//                             const SizedBox(height: 10),
//                             const QuranTwo(),
//                             const SizedBox(height: 10),
//                             PaddingDivider(color: white),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   HeaderFourText(
//                                     text: "How was your first visit yesterday?",
//                                     color: white,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   GroupButton.radio(
//                                     borderRadius: BorderRadius.circular(10),
//                                     selectedTextStyle:
//                                         TextStyle(color: primaryBlack),
//                                     selectedColor: gold,
//                                     unselectedColor: primary1,
//                                     unselectedTextStyle:
//                                         TextStyle(color: white),
//                                     textPadding: const EdgeInsets.only(top: 3),
//                                     buttons: const [
//                                       "It was great!",
//                                       "Mediocre",
//                                       "Unexpected",
//                                       "I don't know what to say",
//                                       "Dissatisfied",
//                                     ],
//                                     onSelected: (i) =>
//                                         debugPrint("Button #$i is selected."),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             DescText(
//                               text:
//                                   "If the previous visit with ${_selectedUser.nickname} was going well, you're doing great! However, some things may not run so smoothly.\n\nBefore selecting the date, these advices might help you before visiting the second parents:",
//                               color: white,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 20),
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
//                               text: "What To Do When Meeting His Family",
//                               color: white,
//                             ),
//                             ChatText(
//                                 text: "Matthew Hussey - YouTube", color: white),
//                           ],
//                         ),
//                       ),
//                       PaddingDivider(color: white),
//                       TaarufCalendar(
//                         size: size,
//                         header:
//                             "Please set the time to visit the second parents:",
//                         dateText: _currentUser.marriageB != null
//                             ? "Visit Date: ${_currentUser.marriageB.toDate().day}/${_currentUser.marriageB.toDate().month}/${_currentUser.marriageB.toDate().year}"
//                             : "Visit Date: ",
//                         onCalendarTap: () {
//                           DatePicker.showDatePicker(context,
//                               locale: LocaleType.id,
//                               showTitleActions: true,
//                               minTime: DateTime.now(),
//                               // must be atleast 18 yo
//                               maxTime: DateTime(2024, 12, 31),
//                               onConfirm: (date) {
//                             setState(() {
//                               _taarufBloc.add(AddCalendarBEvent(
//                                 currentUserId: widget.currentUserId,
//                                 selectedUserId: widget.selectedUserId,
//                                 taarufCheck: 2,
//                                 marriageB: date,
//                               ));
//                               Fluttertoast.showToast(
//                                   msg: "Date has been updated");
//                               Navigator.pushReplacement(
//                                   context, reloadAfterSave());
//                             });
//                           });
//                         },
//                       ),
//                       PaddingDivider(color: white),
//                       TaarufButtons(
//                         size: size,
//                         onPressedTop: () {
//                           if (_currentUser.marriageB != null) {
//                             if (DateTime.now()
//                                 .isAfter(_currentUser.marriageB.toDate())) {
//                               return Navigator.pushReplacement(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder:
//                                       (context, animation1, animation2) =>
//                                           ChecklistThree(
//                                     currentUserId: widget.currentUserId,
//                                     selectedUserId: widget.selectedUserId,
//                                   ),
//                                   transitionDuration: Duration.zero,
//                                   reverseTransitionDuration: Duration.zero,
//                                 ),
//                               );
//                             } else if (DateTime.now()
//                                 .isBefore(_currentUser.marriageB.toDate())) {
//                               return Fluttertoast.showToast(
//                                   msg:
//                                       "Please wait until the specified date to go to the next step.");
//                             }
//                           } else {
//                             return Fluttertoast.showToast(
//                                 msg: "Please specify the date.");
//                           }
//                         },
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
//                             isScrollControlled: true,
//                             builder: (context) {
//                               return SingleChildScrollView(
//                                 child: ModalPopupTwoButton(
//                                   size: size,
//                                   title:
//                                       "Cancel taaruf with ${_currentUser.nickname}?",
//                                   image: "assets/images/think.png",
//                                   description:
//                                       "If you feel unfit with this user, you may cancel this taaruf and find a new one to begin with.",
//                                   labelTop: "No",
//                                   labelBottom: "Yes",
//                                   textColorTop: white,
//                                   btnTop: primary1,
//                                   textColorBottom: white,
//                                   btnBottom: primary2,
//                                   onPressedTop: () => Navigator.pop(context),
//                                   onPressedBottom: () {
//                                     _taarufBloc.add(CancelTaarufEvent(
//                                       currentUserId: widget.currentUserId,
//                                       selectedUserId: widget.selectedUserId,
//                                     ));
//                                     Navigator.pushAndRemoveUntil(
//                                       context,
//                                       PageRouteBuilder(
//                                         pageBuilder: (context, animation1,
//                                                 animation2) =>
//                                             HomeTabs(
//                                                 userId: widget.currentUserId,
//                                                 selectedPage: 2),
//                                         transitionDuration: Duration.zero,
//                                         reverseTransitionDuration:
//                                             Duration.zero,
//                                       ),
//                                       (route) => false,
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           );
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
