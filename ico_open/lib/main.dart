// import 'dart:io';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:ico_open/customer_evaluate/page.dart';
import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/model/preinfo.dart';
import 'package:ico_open/personal_info/page.dart';
import 'package:ico_open/preinfo/page.dart';
// import 'package:flutter/services.dart';

Widget? bodypage;
String? pages;
main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? id;
    return MaterialApp(
      title: 'Finansia Digital Assets',
      initialRoute: '/',
      routes: {
        '/':(context) => const MyHomePage(),
        '/idcard':(context) => const IDCardPage(),
        '/evaluate':(context) => CustomerEvaluate(id: id!),
        '/information':(context) => PersonalInformation(id: id!),
      },
      // home:  MyHomePage()
      // home: CustomerEvaluate(id: 'd555f123-231f-44e7-80bc-96422727e7e6')
      // home: PersonalInformation(id: 'd555f123-231f-44e7-80bc-96422727e7e6')
      // home: IDCardPage()
    );
  }
}

//  class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }