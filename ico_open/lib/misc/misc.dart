import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ico_open/misc/misc.dart' as misc;

Widget importantTextField({
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
  return 'กรุณากรอก $message';
}

Widget dropdownButtonBuilderFunction(
    {required String? value,
    required String label1,
    required String label2,
    required List<String> items,
    required bool condition,
    required String errorText,
    Function(String?)? onChanged,
    Function()? onTabFunction}) {
  return DropdownButtonFormField(
    value: value,
    decoration: InputDecoration(
      errorText: condition ? errorText : null,
      label: RichText(
          text: TextSpan(text: label1, children: [
        TextSpan(text: label2, style: const TextStyle(color: Colors.red))
      ])),
    ),
    onChanged: onChanged,
    onTap: onTabFunction,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget getTitleRow(String titleWidget) {
  return Row(children: [
    const Icon(Icons.home),
    misc.subjectRichText(subject: titleWidget, fontsize: 25)
  ]);
}

Widget addressFunction(
    {required Widget homeWidget,
    required Widget villegeNumberWidget,
    required Widget villegeNameWidget,
    required Widget subStreetNameWidget,
    required Widget streetNameWidget,
    required Widget subDistrictNameWidget,
    required Widget districtNameWidget,
    required Widget provinceNameWidget,
    required Widget zipCodeWidget,
    required Widget countryWidget,
    String? titleWidget}) {
  return Column(children: [
    Row(children: [
      if (titleWidget != null) const Icon(Icons.home),
      misc.subjectRichText(subject: titleWidget!, fontsize: 25)
    ]),
    Row(children: [
      Expanded(flex: 3, child: homeWidget),
      const SizedBox(width: 10),
      Expanded(flex: 1, child: villegeNumberWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: villegeNameWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: subDistrictNameWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: streetNameWidget),
    ]),
    const SizedBox(height: 20),
    Row(children: [
      Expanded(flex: 3, child: subDistrictNameWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: districtNameWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: provinceNameWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: zipCodeWidget),
      const SizedBox(width: 10),
      Expanded(flex: 3, child: countryWidget),
    ])
  ]);
}
