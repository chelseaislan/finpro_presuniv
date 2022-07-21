import 'package:meta/meta.dart';

class PortalBlog {
  final String blogTitle;
  final String imageHeader;
  final String author;
  final String postDate;
  final String blogP1;
  final String blogP2;
  final String imageContent;
  final String blogP3;

  PortalBlog({
    @required this.blogTitle,
    @required this.imageHeader,
    @required this.author,
    @required this.postDate,
    @required this.blogP1,
    @required this.blogP2,
    @required this.imageContent,
    @required this.blogP3,
  });

  static PortalBlog fromJson(json) => PortalBlog(
        blogTitle: json['blogTitle'],
        imageHeader: json['imageHeader'],
        author: json['author'],
        postDate: json['postDate'],
        blogP1: json['blogP1'],
        blogP2: json['blogP2'],
        imageContent: json['imageContent'],
        blogP3: json['blogP3'],
      );
}
