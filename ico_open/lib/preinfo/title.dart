import 'package:flutter/material.dart';

const List<String> thTitles = <String>['นาย', 'นาง', 'นางสาว'];
String thDropdownValue = thTitles.first;

class THdropdownButton extends StatefulWidget {
  const THdropdownButton({super.key, endropdown});

  @override
  State<THdropdownButton> createState() => _THdropdownButtonState();
}

class _THdropdownButtonState extends State<THdropdownButton> {
  // String thDropdownValue = titlesth.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: thDropdownValue,
      decoration: const InputDecoration(
        label: Text(
          'คำนำหน้าชื่อ (ภาษาไทย)',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      icon: const Icon(
        Icons.arrow_downward,
        size: 5,
      ),
      alignment: Alignment.centerLeft,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(
          () {
            thDropdownValue = value!;
          },
        );
      },
      items: thTitles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

const List<String> enTitles = <String>['MR.', 'MRS.', 'MS.'];
String enDropdownValue = enTitles.first;

class ENdropdownButton extends StatefulWidget {
  const ENdropdownButton({super.key});
// String enDropdownValue = enTitles.first;

  @override
  State<ENdropdownButton> createState() => _ENdropdownButtonState();
}

class _ENdropdownButtonState extends State<ENdropdownButton> {
  // String enDropdownValue = entitle.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: enDropdownValue,
      decoration: const InputDecoration(
        label: Text(
          'คำนำหน้าชื่อ (ภาษาอังกฤษ)',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      icon: const Icon(
        Icons.arrow_downward,
        size: 5,
      ),
      alignment: Alignment.centerLeft,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          enDropdownValue = value!;
        });
      },
      items: enTitles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: () {
            setState(
              () {
                if (enDropdownValue == enTitles[0]) {
                  thDropdownValue == thTitles[0];
                }
                if (enDropdownValue == enTitles[1]) {
                  thDropdownValue == thTitles[1];
                }
                if (enDropdownValue == enTitles[2]) {
                  thDropdownValue == thTitles[2];
                }
              },
            );
          },
        );
      }).toList(),
    );
  }
}
