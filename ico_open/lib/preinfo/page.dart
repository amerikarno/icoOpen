import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/preinfo/personal_agreement.dart';
import 'package:ico_open/preinfo/title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String enDropdownValue = enTitles.first;

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _thname = TextEditingController();
  final TextEditingController _thsurname = TextEditingController();
  final TextEditingController _enname = TextEditingController();
  final TextEditingController _ensurname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileno = TextEditingController();

  // FocusNode _focusEmail = FocusNode();

  bool _validateTHName = false;
  bool _validateTHSurName = false;
  bool _validateEnName = false;
  bool _validateEnSurName = false;
  bool _validateEmail = false;
  bool _validateMobileNo = false;
  bool _validatePersonalAgreement = false;
  bool _passedVeridateEmail = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _focusEmail.addListener(_onFocusEmailChanged);
  // }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    // _focusEmail.removeListener(_onFocusEmailChanged);
    // _focusEmail.dispose();
  }

  // void _onFocusEmailChanged() => debugPrint("Focus: ${_focusEmail.hasFocus.toString()}");
  void _verifyEmail(String email) async {
    final url = Uri(scheme: 'http', host: 'localhost', port:1234, queryParameters: {'email': email});
    var response = await http.get(url).timeout(const Duration(seconds: 1), onTimeout: ()=> http.Response('error', 408),);
    log('respons:', name: response.statusCode.toString());
    log('respons:', name: response.body.toString());

    if (response.body == "success" || response.body == "error") {
      _passedVeridateEmail = true;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const SizedBox(
                  child: Text(
                    'กรุณากรอกข้อมูลเพื่อเปิดบัญชี',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 230,
                  child: THdropdownButton(),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: _thname,
                        decoration: InputDecoration(
                          errorText:
                              _validateTHName ? 'กรุณาใส่ชื่อ (ภาษาไทย)' : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'ชื่อ (ภาษาไทย)',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[ก-๛]'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _thsurname,
                        decoration: InputDecoration(
                          errorText: _validateTHSurName
                              ? 'กรุณาใส่นามสกุล (ภาษาไทย)'
                              : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'นามสกุล (ภาษาไทย)',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[ก-๛]'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 230,
                  child: ENdropdownButton(),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: _enname,
                        decoration: InputDecoration(
                          errorText: _validateEnName
                              ? 'กรุณาใส่ชื่อ (ภาษาอังกฤษ)'
                              : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'ชื่อ (ภาษาอังกฤษ)',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _ensurname,
                        decoration: InputDecoration(
                          // labelText: 'นามสกุล (ภาษาอังกฤษ)'
                          errorText: _validateEnSurName
                              ? 'กรุณาใส่นามสกุล (ภาษาอังกฤษ)'
                              : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'นามสกุล (ภาษาอังกฤษ)',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  child: Text(
                    'ข้อมูลสำหรับรับ Username, Password และเอกสารจากทางบริษัทฯ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.lightBlue,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        // focusNode: _focusEmail,
                        controller: _email,
                        decoration: InputDecoration(
                          errorText: _validateEmail ? 'กรุณาใส่อีเมล' : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'อีเมล',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@.]'),
                          ),
                        ],
                        onSubmitted: (value) {
                          setState(() {
                            _verifyEmail(value);
                          });
                        },
                        // onChanged: (value) {
                        //   Uri url = Uri(
                        //     scheme: 'https',
                        //     host: '127.0.0.1',
                        //     port: 8080,
                        //     path: 'verified/email',
                        //     queryParameters: {'email': value},
                        //   );
                        //  var response =  http.get(url);
                        //  log(
                        //   'status:', name: response.toString(),
                        //    );
                        // },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_iphone,
                      color: Colors.lightBlue,
                    ),
                    Expanded(
                      // width: 300,
                      flex: 5,
                      child: TextField(
                        onTap: () => print('mobile subject: ${_email.toString()}'),
                        controller: _mobileno,
                        decoration: InputDecoration(
                          // labelText: 'หมายเลขโทรศัพท์มือถือ',
                          errorText: _validateMobileNo
                              ? 'กรุณาใส่หมายเลขโทรศัพท์มือถือ'
                              : null,
                          label: RichText(
                            text: const TextSpan(
                              text: 'หมายเลขโทรศัพท์มือถือ',
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    CheckboxPersonalAggreement(),
                    Text('agreement information...'),
                    PersonalAgreement(),
                  ],
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    // children: [Icon(Icons.arrow_right)],
                    children: [
                      const SizedBox(
                        width: 550,
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: FittedBox(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              setState(() {
                                _validateTHName = _thname.text.trim().isEmpty;
                                _validateTHSurName =
                                    _thsurname.text.trim().isEmpty;
                                _validateEnName = _enname.text.trim().isEmpty;
                                _validateEnSurName =
                                    _ensurname.text.trim().isEmpty;
                                _validateEmail = _email.text.trim().isEmpty;
                                _validateMobileNo =
                                    _mobileno.text.trim().isEmpty;
                                    _validatePersonalAgreement = isPersonalAgreementChecked;
                                  _verifyEmail(_email.text);
                              });
                              if (!_validateTHName &&
                                  !_validateTHSurName &&
                                  !_validateEnName &&
                                  !_validateEnSurName &&
                                  !_validateEmail &&
                                  !_validateMobileNo &&
                                  _passedVeridateEmail) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const IDCardPage();
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.arrow_right_alt,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
