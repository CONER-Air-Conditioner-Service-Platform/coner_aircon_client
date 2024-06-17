import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LandingContent extends StatefulWidget {
  const LandingContent({
    super.key,
    this.title,
    this.text,
    this.image,
  });
  final String? title, text, image;

  @override
  State<LandingContent> createState() => _LandingContentState();
}

class _LandingContentState extends State<LandingContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          "${widget.title}",
          textAlign: TextAlign.center,
          style: AppTextStyles.h1BoldMain,
        ),
        Text(
          "${widget.text}",
          textAlign: TextAlign.center,
          style: AppTextStyles.b2,
        ),
        const Spacer(flex: 2),
        Image.asset(widget.image!),
      ],
    );
  }
}
