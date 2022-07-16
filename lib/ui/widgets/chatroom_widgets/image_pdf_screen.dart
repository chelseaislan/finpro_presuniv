import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key, this.photoLink}) : super(key: key);
  final String photoLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBarSideButton(
        appBarTitle: Text("Image Detail"),
        appBarColor: Colors.black,
      ),
      body: PinchZoom(
        maxScale: 3.5,
        resetDuration: const Duration(milliseconds: 200),
        child: Center(
          child: CardPhotoWidget(photoLink: photoLink),
        ),
      ),
    );
  }
}

class PDFDetailScreen extends StatelessWidget {
  const PDFDetailScreen({Key key, this.docUrl}) : super(key: key);
  final String docUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: const AppBarSideButton(
          appBarTitle: Text("PDF Detail"),
          appBarColor: Colors.black,
        ),
        body: SfPdfViewer.network(docUrl));
  }
}
