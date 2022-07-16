// @dart=2.9
// 34/41 01

import 'package:finpro_max/custom_widgets/buttons/text_button.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/ui/pages/chatroom_pages/chatroom_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:finpro_max/models/message_model.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/message_repository.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/matches_widgets/page_turn.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  final String userId, selectedUserId;
  final Timestamp creationTime;

  const MessageWidget({this.userId, this.selectedUserId, this.creationTime});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  MessageRepository messageRepository = MessageRepository();
  MessageModel messageModel;
  User user;

  @override
  initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 34/41 03 get user info
  getUserDetail() async {
    user = await messageRepository.getUserDetail(userId: widget.selectedUserId);
    MessageDetail messageDetail = await messageRepository
        .getLastMessage(
            currentUserId: widget.userId, selectedUserId: widget.selectedUserId)
        .catchError((error) {
      // Fluttertoast.showToast(msg: error.toString());
      // ignore: avoid_print
      print(error);
    });

    if (messageDetail == null) {
      return MessageModel(
        nickname: user.nickname,
        photoUrl: user.photo,
        lastMessage: null,
        lastMessagePhoto: null,
        timestamp: null,
        lastMessageCV: null,
      );
    } else {
      return MessageModel(
        nickname: user.nickname,
        photoUrl: user.photo,
        lastMessage: messageDetail.text,
        lastMessagePhoto: messageDetail.photoUrl,
        timestamp: messageDetail.timestamp,
        lastMessageCV: messageDetail.marriageDocUrl,
      );
    }
  }

  // to open a message window
  openChat() async {
    ScaffoldMessenger.of(context).showSnackBar(
      mySnackbar(
        text: "Please wait...",
        duration: 2,
        background: primaryBlack,
      ),
    );
    User currentUser =
        await messageRepository.getUserDetail(userId: widget.userId);
    User selectedUser =
        await messageRepository.getUserDetail(userId: widget.selectedUserId);

    try {
      pageTurn(
          ChatroomPage(currentUser: currentUser, selectedUser: selectedUser),
          context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // to delete a chat
  deleteChat() async {
    await messageRepository.deleteChat(
      currentUserId: widget.userId,
      selectedUserId: widget.selectedUserId,
    );
  }

  // The actual widget, to open new page or delete & unmatch
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getUserDetail(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          MessageModel messageModel = snapshot.data;
          return GestureDetector(
            onTap: () async => await openChat(),
            onLongPress: () {
              showModalBottomSheet(
                transitionAnimationController: _animationController,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 23, 20, 20),
                    child: BigTextButton(
                      labelColor: primary2,
                      labelText: "Delete Chat with ${user.nickname}",
                      onPressedTo: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Confirmation"),
                            content: Text(
                                "Delete all the messages with ${user.nickname}? This cannot be undone!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await deleteChat();
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete Chat"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            // The message widget
            child: Container(
              color: white,
              padding: EdgeInsets.fromLTRB(
                size.height * 0.02,
                size.height * 0.02,
                size.height * 0.02,
                0,
              ),
              width: size.width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ClipOval(
                          child: SizedBox(
                            height: size.height * 0.06,
                            width: size.height * 0.06,
                            child: CardPhotoWidget(photoLink: user.photo),
                          ),
                        ),
                      ),
                      const Flexible(flex: 1, child: SizedBox(width: 15)),
                      Flexible(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderThreeText(
                              text: user.nickname,
                              color: secondBlack,
                              align: TextAlign.left,
                            ),
                            messageModel.lastMessage != null
                                ? Text(
                                    messageModel.lastMessage,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: secondBlack,
                                      fontSize: 16,
                                    ),
                                  )
                                : messageModel.lastMessagePhoto != null
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.photo_outlined,
                                            color: secondBlack,
                                            size: size.height * 0.02,
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          ChatText(
                                            text: "Uploaded photo",
                                            color: secondBlack,
                                            align: TextAlign.left,
                                          ),
                                        ],
                                      )
                                    : messageModel.lastMessageCV != null
                                        ? Row(
                                            children: [
                                              Icon(
                                                Icons.library_books_outlined,
                                                color: secondBlack,
                                                size: size.height * 0.02,
                                              ),
                                              SizedBox(
                                                  width: size.width * 0.01),
                                              ChatText(
                                                text: "Uploaded document",
                                                color: secondBlack,
                                                align: TextAlign.left,
                                              ),
                                            ],
                                          )
                                        : ChatText(
                                            text: "Start chatting now!",
                                            color: secondBlack,
                                            align: TextAlign.left,
                                          ),
                            const SizedBox(height: 3),
                            messageModel.timestamp != null
                                ? MiniText(
                                    text: timeago.format(
                                        messageModel.timestamp.toDate()),
                                    color: secondBlack,
                                    align: TextAlign.right,
                                  )
                                : MiniText(
                                    text: timeago
                                        .format(widget.creationTime.toDate()),
                                    color: thirdBlack,
                                    align: TextAlign.right,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Divider(
                    height: 5,
                    color: secondBlack,
                    thickness: 0.1,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
  // 34/41 03 END