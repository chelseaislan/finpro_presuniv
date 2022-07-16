// @dart=2.9
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileDetailListView extends StatelessWidget {
  const ProfileDetailListView({
    Key key,
    @required this.headers,
    @required this.contents,
    @required this.color,
  }) : super(key: key);

  final List headers;
  final List contents;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: headers.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  HeaderFourText(text: headers[index], color: color),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  DescText(text: contents[index], color: color),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
