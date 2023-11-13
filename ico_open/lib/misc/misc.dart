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
