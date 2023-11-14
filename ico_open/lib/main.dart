import 'package:flutter/material.dart';
import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/model/preinfo.dart';
import 'package:ico_open/preinfo/page.dart';
// import 'package:flutter/services.dart';

Widget? bodypage;
String? pages;
main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MyHomePage()
    );
  }
}
