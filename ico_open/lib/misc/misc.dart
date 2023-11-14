import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget importantTextField({
  required TextEditingController textController,
  required bool errorTextCondition,
  required String errorTextMessage,
  required String subject,
  required Pattern filterPattern,
  Function(String)? onsubmittedFunction,
}) {
  return TextField(
      controller: textController,
      decoration: InputDecoration(
        errorText: errorTextCondition ? errorTextMessage : null,
        label: RichText(
          text: TextSpan(
            text: subject,
            children: const [
              TextSpan(text: '*', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(filterPattern),
      ],
      onSubmitted: onsubmittedFunction);
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
