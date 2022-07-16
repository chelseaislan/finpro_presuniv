// import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
// import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max/custom_widgets/custom_radio.dart';
// import 'package:finpro_max/custom_widgets/divider.dart';
// import 'package:finpro_max/custom_widgets/modal_popup.dart';
// import 'package:finpro_max/custom_widgets/text_styles.dart';
// import 'package:finpro_max/models/colors.dart';
// import 'package:finpro_max/models/user.dart';
// import 'package:finpro_max/repositories/taaruf_repository.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_4_page.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ChecklistThree extends StatefulWidget {
//   final String currentUserId, selectedUserId;
//   const ChecklistThree({this.currentUserId, this.selectedUserId});

//   @override
//   State<ChecklistThree> createState() => _ChecklistThreeState();
// }

// class _ChecklistThreeState extends State<ChecklistThree>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   final TaarufRepository _taarufRepository = TaarufRepository();
//   TaarufBloc _taarufBloc;
//   User _selectedUser, _currentUser;
//   String isPrayed;
//   final YoutubePlayerController _ytController = YoutubePlayerController(
//     initialVideoId: 'ay9GCWEfhmQ',
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

//     final List headersC = [
//       "1. Do more tahajud prayers.",
//       "2. Don't forget to do the istikharah prayer.",
//     ];

//     final List descriptionsC = [
//       "Praying in the last one-third of the night will increase the chance of your prayers being heard and accepted by Allah.",
//       "It is the prayer of seeking guidance from God. Hopefully it is what's best for you and both of your future.",
//     ];

//     return Scaffold(
//       backgroundColor: primary5,
//       appBar: AppBarSideButton(
//         appBarTitle: const Text("Taaruf Checklist - 3"),
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
//       body: BlocBuilder<TaarufBloc, TaarufState>(
//         bloc: _taarufBloc,
//         builder: (context, state) {
//           if (state is TaarufLoadingState) {
//             _taarufBloc.add(TaarufLoadUserEvent(
//               currentUserId: widget.currentUserId,
//               selectedUserId: widget.selectedUserId,
//             ));
//           }
//           if (state is TaarufLoadUserState) {
//             _selectedUser = state.selectedUser;
//             _currentUser = state.currentUser;
//             if (_selectedUser.nickname != null) {
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TaarufHeader(
//                       size: size,
//                       header: "How's it going, ${_currentUser.nickname}?",
//                       description:
//                           "How are your feeling after visiting the second parents with ${_selectedUser.nickname}? Did it went well?",
//                       photoLink: "https://i.ibb.co/YZt45q6/taaruf3.jpg",
//                     ),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: size.width * 0.05,
//                       ),
//                       child: DescText(
//                         text:
//                             "After you and your partner met both of your parents, now let's give everything up to Allah.",
//                         color: white,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: size.width * 0.05,
//                         vertical: 5,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           ListView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: headersC.length,
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   HeaderFourText(
//                                       text: headersC[index], color: white),
//                                   const SizedBox(height: 5),
//                                   ChatText(
//                                     text: descriptionsC[index],
//                                     color: white,
//                                   ),
//                                   const SizedBox(height: 15),
//                                 ],
//                               );
//                             },
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 20),
//                             child: YoutubePlayer(
//                               controller: _ytController,
//                               showVideoProgressIndicator: true,
//                               progressIndicatorColor: gold,
//                               progressColors: const ProgressBarColors(
//                                 playedColor: Colors.amber,
//                                 handleColor: Colors.amberAccent,
//                               ),
//                               onReady: () {},
//                             ),
//                           ),
//                           HeaderFourText(
//                             text: "How to Pray Istikhara?",
//                             color: white,
//                           ),
//                           ChatText(
//                               text: "The Sincere Seeker - YouTube",
//                               color: white),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                     PaddingDivider(color: white),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                       child: Column(
//                         children: [
//                           HeaderFourText(
//                             text:
//                                 "Have you prayed to God to seek for His guidance regarding to your marriage?",
//                             color: white,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Flexible(
//                                 flex: 12,
//                                 child: CustomRadio(
//                                   text: "Yes",
//                                   color: secondBlack,
//                                   radioColor: isPrayed == "yes" ? gold : white,
//                                   onRadioTap: () {
//                                     setState(() => isPrayed = "yes");
//                                   },
//                                 ),
//                               ),
//                               Flexible(
//                                   flex: 1,
//                                   child: SizedBox(width: size.width * 0.01)),
//                               Flexible(
//                                 flex: 12,
//                                 child: CustomRadio(
//                                   text: "No",
//                                   color: secondBlack,
//                                   radioColor: isPrayed == "no" ? gold : white,
//                                   onRadioTap: () {
//                                     setState(() => isPrayed = "no");
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     PaddingDivider(color: white),
//                     TaarufButtons(
//                       size: size,
//                       onPressedTop: () {
//                         isPrayed == "yes"
//                             ? showModalBottomSheet(
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
//                                       image: "assets/images/mobility.png",
//                                       description:
//                                           "If you choose to proceed, you and your family will perform the Khitbah (marriage proposal) with ${_selectedUser.nickname} and family.\n\nAnd since you have reached this far then both of your parents should have agreed the marriage.\n\nContinue?",
//                                       labelTop: "No",
//                                       labelBottom: "Continue",
//                                       textColorTop: secondBlack,
//                                       btnTop: lightGrey3,
//                                       textColorBottom: secondBlack,
//                                       btnBottom: gold,
//                                       onPressedTop: () =>
//                                           Navigator.pop(context),
//                                       onPressedBottom: () {
//                                         setState(() {
//                                           _taarufBloc
//                                               .add(AddChecklistThreeEvent(
//                                             currentUserId: widget.currentUserId,
//                                             selectedUserId:
//                                                 widget.selectedUserId,
//                                           ));
//                                         });
//                                         Navigator.pushReplacement(
//                                           context,
//                                           PageRouteBuilder(
//                                             pageBuilder: (context, animation1,
//                                                     animation2) =>
//                                                 ChecklistFour(
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
//                               )
//                             : Fluttertoast.showToast(
//                                 msg:
//                                     "Make sure you pray first before making decisions regarding to the marriage.");
//                       },
//                       onPressedBottom: () {
//                         showModalBottomSheet(
//                           transitionAnimationController: _animationController,
//                           context: context,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                             ),
//                           ),
//                           isScrollControlled: true,
//                           builder: (context) {
//                             return SingleChildScrollView(
//                               child: ModalPopupTwoButton(
//                                 size: size,
//                                 title:
//                                     "Cancel taaruf with ${_currentUser.nickname}?",
//                                 image: "assets/images/think.png",
//                                 description:
//                                     "If you feel unfit with this user, you may cancel this taaruf and find a new one to begin with.",
//                                 labelTop: "No",
//                                 labelBottom: "Yes",
//                                 textColorTop: white,
//                                 btnTop: primary1,
//                                 textColorBottom: white,
//                                 btnBottom: primary2,
//                                 onPressedTop: () => Navigator.pop(context),
//                                 onPressedBottom: () {
//                                   _taarufBloc.add(CancelTaarufEvent(
//                                     currentUserId: widget.currentUserId,
//                                     selectedUserId: widget.selectedUserId,
//                                   ));
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     PageRouteBuilder(
//                                       pageBuilder:
//                                           (context, animation1, animation2) =>
//                                               HomeTabs(
//                                                   userId: widget.currentUserId,
//                                                   selectedPage: 2),
//                                       transitionDuration: Duration.zero,
//                                       reverseTransitionDuration: Duration.zero,
//                                     ),
//                                     (route) => false,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
