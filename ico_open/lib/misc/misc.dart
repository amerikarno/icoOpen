import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget  importantTextField({
  required TextEditingController textController,
  required bool errorTextCondition,
  required String errorTextMessage,
  required String subject,
  required Pattern filterPattern,
  Function(String)? onsubmittedFunction,
  Function(String)? onchangedFunction,
  Function()? onTabFunction,
  bool? isimportant,
}) {
  isimportant = isimportant ?? true;
  return TextField(
      controller: textController,
      decoration: InputDecoration(
          errorText: errorTextCondition ? errorTextMessage : null,
          label: isimportant
              ? RichText(
                  text: TextSpan(
                    text: subject,
                    children: const [
                      TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                )
              : Text(subject)),
      inputFormatters: [
        FilteringTextInputFormatter.allow(filterPattern),
      ],
      onSubmitted: onsubmittedFunction,
      onTap: onTabFunction,
      onChanged: onchangedFunction);
}

Widget subjectText({
  required String subject,
  Color? color,
  double? fontsize,
}) {
  color = color ?? Colors.orange;
  fontsize = fontsize ?? 20;

  return Text(
    subject,
    style: TextStyle(
      fontSize: fontsize,
      color: color,
    ),
  );
}

Widget subjectRichText({
  required String subject,
  Color? color,
  double? fontsize,
}) {
  color = color ?? Colors.black;
  fontsize = fontsize ?? 20;

  return RichText(
    text: TextSpan(
      text: subject,
      style: TextStyle(fontSize: fontsize, color: color),
      children: const [
        TextSpan(
          text: '*',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}

String thErrorMessage(String message) {
  return 'กรุณากรอก$message';
}
