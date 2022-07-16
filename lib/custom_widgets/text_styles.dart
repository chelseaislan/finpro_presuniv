import 'package:flutter/material.dart';

class HeaderOneText extends StatelessWidget {
  const HeaderOneText({@required this.text, @required this.color, this.align});

  final String text;
  final Color color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

class HeaderTwoText extends StatelessWidget {
  const HeaderTwoText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
        overflow: overflow,
      ),
    );
  }
}

class HeaderThreeText extends StatelessWidget {
  const HeaderThreeText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
        overflow: overflow,
      ),
    );
  }
}

class DescText extends StatelessWidget {
  const DescText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(fontSize: 18, color: color, overflow: overflow),
    );
  }
}

class ChatText extends StatelessWidget {
  const ChatText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(fontSize: 16, color: color, overflow: overflow),
    );
  }
}

class ProfDetailText extends StatelessWidget {
  const ProfDetailText({@required this.text, @required this.color, this.align});

  final String text;
  final Color color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 20,
        color: color,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 14,
        color: color,
        overflow: overflow,
      ),
    );
  }
}

class HeaderFourText extends StatelessWidget {
  const HeaderFourText({@required this.text, @required this.color, this.align});

  final String text;
  final Color color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class MiniText extends StatelessWidget {
  const MiniText({
    @required this.text,
    @required this.color,
    this.align,
    this.overflow,
  });

  final String text;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 12,
        color: color,
        overflow: overflow,
      ),
    );
  }
}
