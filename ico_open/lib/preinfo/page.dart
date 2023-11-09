import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/preinfo/personal_agreement.dart';
// import 'package:ico_open/model/model.dart';

// import 'package:ico_open/preinfo/title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// String enDropdownValue = enTitles.first;

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _thname = TextEditingController();
  final TextEditingController _thsurname = TextEditingController();
  final TextEditingController _enname = TextEditingController();
  final TextEditingController _ensurname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileno = TextEditingController();

  var _emailError = 'กรุณาใส่อีเมล';
  var _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือ';
  // FocusNode _focusEmail = FocusNode();

  bool _validateTHName = false;
  bool _validateTHSurName = false;
  bool _validateEnName = false;
  bool _validateEnSurName = false;
  bool _validateEmail = false;
  bool _validateMobileNo = false;
  bool _validatePersonalAgreement = false;
  bool _passedVeridateEmail = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  void _verifyEmail(String email) async {
    if (email.isEmpty) {
      log('email is empty', name: _passedVeridateEmail.toString());
      setState(() {
        _validateEmail = true;
      });
    } else {
      final url = Uri(
        scheme: 'http',
        host: 'localhost',
        port: 1323,
        path: 'verify/email/$email',
      );
      var response = await http.get(url).timeout(
            const Duration(seconds: 1),
            onTimeout: () => http.Response('error', 408),
          );
      log(
        'url:',
        name: url.toString(),
      );
      log('respons code:', name: response.statusCode.toString());
      log('respons body:', name: response.body.toString());

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('start to verify');
        log('data', name: data.toString());
        if (data['isRegisteredEmail'] == 'true') {
          log('registered email', name: data['registeredEmail'].toString());
        } else {
          log('registered email', name: data['registeredEmail'].toString());
          _passedVeridateEmail = true;
          log('verified email', name: _passedVeridateEmail.toString());
        }
        setState(() {
          _validateEmail = false;
        });
      }

      if (data['isInvalidEmailFormat']) {
        log('invalid email format', name: _passedVeridateEmail.toString());
        setState(() {
          _emailError = 'กรุณาใส่อีเมลให้ถูกต้อง';
          _validateEmail = true;
        });
      }
    }
  }

  void _verifyMobileNo(String mobileno) async {
    if (mobileno.isEmpty) {
      log('email is empty', name: _passedVeridateEmail.toString());
      setState(() {
        _validateMobileNo = true;
      });
    } else {
      final url = Uri(
        scheme: 'http',
        host: 'localhost',
        port: 1323,
        path: 'verify/mobile/$mobileno',
      );
      var response = await http.get(url).timeout(
            const Duration(seconds: 1),
            onTimeout: () => http.Response('error', 408),
          );
      log(
        'url:',
        name: url.toString(),
      );
      log('respons code:', name: response.statusCode.toString());
      log('respons body:', name: response.body.toString());

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('start to verify');
        log('data', name: data.toString());
        if (data['isRegisteredMobileNo']) {
          log('registered mobile no', name: data['registeredMobileNo'].toString());
        } else {
          log('registered mobile no', name: data['registeredMobileNo'].toString());
          _passedVeridateEmail = true;
          log('verified mobile no', name: _passedVeridateEmail.toString());
        }
        setState(() {
          _validateMobileNo = false;
        });
      }

      if (data['isInvalidMobileNoFormat']) {
        log('invalid mobile format', name: _passedVeridateEmail.toString());
        setState(() {
          _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือให้ถูกต้อง';
          _validateMobileNo = true;
        });
      }
    }
  }

  final thList = [
    'นาย',
    'นาง',
    'นางสาว',
  ];
  final engList = [
    'Mr.',
    'Mrs.',
    'Ms.',
  ];

  String? engToTh(String? eng) {
    if (eng == null) return null;
    final index = engList.indexOf(eng);
    if (index >= 0) {
      log('eng: ${thList[index]}');
      return thList[index];
    }
    return null;
  }

  String? thToEng(String? th) {
    if (th == null) return null;
    final index = thList.indexOf(th);
    if (index >= 0) {
      log('th: ${engList[index]}');
      return engList[index];
    }
    return null;
  }


  String? thValue;
  String? engValue;

  Widget dropdownButtonBuilder(
      {required String? value,
      required String label,
      required List<String> items,
      required Function(String?) onChanged}) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          onChanged(value);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  final thLabel = 'คำนำหน้าชื่อ (ภาษาไทย)';
  final engLabel = 'คำนำหน้าชื่อ (ภาษาอังกฤษ)';

  @override
  Widget build(BuildContext context) {
    final thField = dropdownButtonBuilder(
      value: thValue,
      label: thLabel,
      items: thList,
      onChanged: (value) {
        thValue = value!;
        engValue = thToEng(value);
      },
    );
    final engField = dropdownButtonBuilder(
      value: engValue,
      label: engLabel,
      items: engList,
      onChanged: (value) {
        thValue = value!;
        engValue = engToTh(value);
      },
    );

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
                SizedBox(
                  width: 230,
                  child: thField,
                  // child: THdropdownButton(),
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
                SizedBox(
                  width: 230,
                  child: engField,
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
                          errorText: _validateEmail ? _emailError : null,
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
                        onTap: () =>
                            log('mobile subject: ${_email.toString()}'),
                        controller: _mobileno,
                        decoration: InputDecoration(
                          errorText: _validateMobileNo
                              ? _mobilenoError
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
                        onSubmitted: (value) {
                          setState(() {
                            _verifyMobileNo(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(children: [
                  Expanded(flex: 1, child: CheckboxPersonalAggreement()),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Text(
                              """ข้าพเจ้าได้อ่านและตกลงตามข้อมกำหนดและเงื่อนไขและรับทราบนโยบายความเป็นส่วนตัว ซึ่งระบุวิธีการที่บริษัท ฟินันเซีย ดิจิตทัล แอสแซท จำกัด("บริษัท")""",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            PersonalAgreement(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 500,
                        child: RichText(
                          text: const TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: 'ข้อมูลสำคัญกรุณากรอกให้ครบถ้วย',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                _validatePersonalAgreement =
                                    isPersonalAgreementChecked;
                                _verifyEmail(_email.text);
                              });
                              if (!_validateTHName &&
                                  !_validateTHSurName &&
                                  !_validateEnName &&
                                  !_validateEnSurName &&
                                  !_validateEmail &&
                                  !_validateMobileNo &&
                                  _validatePersonalAgreement &&
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
