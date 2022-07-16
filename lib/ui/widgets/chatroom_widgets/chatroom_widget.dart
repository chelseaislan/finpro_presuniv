// @dart=2.9
// 39/41 01

import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/chatroom_widgets/image_pdf_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:finpro_max/repositories/chatroom_repository.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatroomWidget extends StatefulWidget {
  final String messageId, currentUserId;

  const ChatroomWidget({this.messageId, this.currentUserId});

  @override
  State<ChatroomWidget> createState() => _ChatroomWidgetState();
}

class _ChatroomWidgetState extends State<ChatroomWidget> {
  ChatroomRepository _chatroomRepository = ChatroomRepository();
  MessageDetail _messageDetail;

  // get the message details
  Future getDetails() async {
    _messageDetail =
        await _chatroomRepository.getMessageDetail(messageId: widget.messageId);
    return _messageDetail;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getDetails(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          _messageDetail = snapshot.data;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            color: Colors.transparent,
            child: Column(
              // if its the sender, messages will docked to the right side
              // if its the receiver, docked to the left side
              crossAxisAlignment:
                  _messageDetail.senderId == widget.currentUserId
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                _messageDetail.text != null
                    // if the message is text
                    ? Wrap(
                        crossAxisAlignment:
                            // dock to left for receiver, right for sender
                            _messageDetail.senderId == widget.currentUserId
                                ? WrapCrossAlignment.end
                                : WrapCrossAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.height * 0.01),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.7),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _messageDetail.senderId ==
                                          widget.currentUserId
                                      ? primary3
                                      : white,
                                  borderRadius: BorderRadius.circular(
                                    size.width * 0.03,
                                  ),
                                ),
                                // padding for chat bubbles
                                padding: EdgeInsets.fromLTRB(
                                  size.height * 0.016,
                                  size.height * 0.016,
                                  size.height * 0.016,
                                  size.height * 0.011,
                                ),
                                child: ChatText(
                                  text: _messageDetail.text,
                                  color: secondBlack,
                                ),
                              ),
                            ),
                          ),
                          // timestamps for the sender
                          _messageDetail.senderId == widget.currentUserId
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width * 0.02),
                                  child: TimeAgoWidget(
                                    size: size,
                                    messageDetail: _messageDetail,
                                  ),
                                )
                              : Container(),
                          // timestamps for the receiver
                          _messageDetail.senderId == widget.currentUserId
                              ? Container()
                              : Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: TimeAgoWidget(
                                    size: size,
                                    messageDetail: _messageDetail,
                                  ),
                                ),
                        ],
                      )
                    // if the message is a PDF (CV)
                    : _messageDetail.marriageDocUrl != null
                        ? Wrap(
                            crossAxisAlignment:
                                // dock to left for receiver, right for sender
                                _messageDetail.senderId == widget.currentUserId
                                    ? WrapCrossAlignment.end
                                    : WrapCrossAlignment.start,
                            direction: Axis.vertical,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    myLoadingSnackbar(
                                      text: "Opening document...",
                                      duration: 5,
                                      background: primaryBlack,
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              PDFDetailScreen(
                                        docUrl: _messageDetail.marriageDocUrl,
                                      ),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(size.height * 0.01),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: size.width * 0.7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _messageDetail.senderId ==
                                                widget.currentUserId
                                            ? primary3
                                            : white,
                                        borderRadius: BorderRadius.circular(
                                          size.width * 0.03,
                                        ),
                                      ),
                                      // padding for chat bubbles
                                      padding: EdgeInsets.fromLTRB(
                                        size.height * 0.016,
                                        size.height * 0.016,
                                        size.height * 0.016,
                                        size.height * 0.011,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.library_books_outlined,
                                            color: thirdBlack,
                                            size: size.height * 0.05,
                                          ),
                                          const SizedBox(height: 5),
                                          HeaderFourText(
                                            text: "View Document",
                                            color: secondBlack,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _messageDetail.senderId == widget.currentUserId
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.02),
                                      child: TimeAgoWidget(
                                        size: size,
                                        messageDetail: _messageDetail,
                                      ),
                                    )
                                  : Container(),
                              _messageDetail.senderId == widget.currentUserId
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.02),
                                      child: TimeAgoWidget(
                                        size: size,
                                        messageDetail: _messageDetail,
                                      ),
                                    ),
                            ],
                          )
                        // if the message is a photo
                        : Wrap(
                            crossAxisAlignment:
                                // dock to left for receiver, right for sender
                                _messageDetail.senderId == widget.currentUserId
                                    ? WrapCrossAlignment.end
                                    : WrapCrossAlignment.start,
                            direction: Axis.vertical,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(size.height * 0.01),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: size.width * 0.7,
                                      maxHeight: size.width * 0.8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              DetailScreen(
                                            photoLink: _messageDetail.photoUrl,
                                          ),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _messageDetail.senderId ==
                                                  widget.currentUserId
                                              ? primary3
                                              : white,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            size.height * 0.02),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            size.height * 0.02),
                                        child: CardPhotoWidget(
                                          photoLink: _messageDetail.photoUrl,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _messageDetail.senderId == widget.currentUserId
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.02),
                                      child: TimeAgoWidget(
                                        size: size,
                                        messageDetail: _messageDetail,
                                      ),
                                    )
                                  : Container(),
                              _messageDetail.senderId == widget.currentUserId
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.02),
                                      child: TimeAgoWidget(
                                        size: size,
                                        messageDetail: _messageDetail,
                                      ),
                                    ),
                            ],
                          ),
              ],
            ),
          );
        }
      },
    );
  }
}

class TimeAgoWidget extends StatelessWidget {
  const TimeAgoWidget({
    Key key,
    @required this.size,
    @required MessageDetail messageDetail,
  })  : _messageDetail = messageDetail,
        super(key: key);

  final Size size;
  final MessageDetail _messageDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: thirdBlack,
        borderRadius: BorderRadius.circular(
          size.width * 0.03,
        ),
      ),
      child: MiniText(
        text:
            "${_messageDetail.senderNickname} - ${timeago.format(_messageDetail.timestamp.toDate())}",
        color: white,
        align: TextAlign.center,
      ),
    );
  }
}
