import 'package:flutter/material.dart';

import '../constants/decoration_constants.dart';
import '../constants/text_styles.dart';

class DialogFieldWidget extends StatelessWidget {
  final String hintText;

  const DialogFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFieldHeight,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
        ),
        controller: controller,
      ),
    );
  }
}
