import 'package:flutter/material.dart';
import 'package:ico_open/customer_evaluate/page.dart';
import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/personal_info/page.dart';
// import 'package:flutter/services.dart';

import 'package:ico_open/preinfo/page.dart';
import 'package:ico_open/verify/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      // home: Verify()
    );
  }
}
