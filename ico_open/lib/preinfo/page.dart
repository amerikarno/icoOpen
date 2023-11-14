import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ico_open/idcard/page.dart';
import 'package:ico_open/model/preinfo.dart';
import 'package:ico_open/preinfo/personal_agreement.dart';
import 'package:ico_open/misc/misc.dart' as misc;

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

  bool _validateTHTitle = false;
  bool _validateEnTitle = false;
  bool _validateTHName = false;
  bool _validateTHSurName = false;
  bool _validateEnName = false;
  bool _validateEnSurName = false;
  bool _validateEmail = false;
  bool _validateMobileNo = false;
  bool _passedVeridateEmail = false;
  bool _passedVeridateMobile = false;
  bool _passedVeridateEmailMobile = false;
  // bool _isPassedVeridateEmail = false;
  // bool _isPassedVeridateMobile = false;

  bool isPassedMobileChecked = false;
  bool isPassedEmailChecked = false;
  bool isPassedEmailMobileChecked = false;

  // bool _loadingEmail = true;
  // bool _loadingMobile = true;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  Future<bool> _verifyEmail(String email) async {
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

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('start to verify');
        if (data['isRegisteredEmail'] == 'true') {
          log('[true]registered email: ${data['registeredEmail'].toString()}');
        } else {
          log('[else]registered email: ${data['registeredEmail'].toString()}');
          setState(() {
            _passedVeridateEmail = true;
          });
        }
        setState(() {
          // isPassedEmailChecked = true;
          _validateEmail = false;
          // _loadingEmail = false;
        });
      }

      if (data['isInvalidEmailFormat']) {
        setState(() {
          _emailError = 'กรุณาใส่อีเมลให้ถูกต้อง';
          _validateEmail = true;
          // _loadingEmail = false;
          // isPassedEmailChecked = false;
        });
      }
    }
    log('is passed email validate: $_passedVeridateEmail');
    return _passedVeridateEmail;
  }

  Future<bool> _verifyMobileNo(String mobileno) async {
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
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
        } else {
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
          _passedVeridateMobile = true;
        }
        setState(() {
          _validateMobileNo = false;
          // _loadingMobile = false;
          // isPassedMobileChecked = true;
        });
      }

      if (data['isInvalidMobileNoFormat']) {
        setState(() {
          _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือให้ถูกต้อง';
          _validateMobileNo = true;
          // _loadingMobile = false;
          // isPassedMobileChecked = false;
        });
      }
    }
    log('invalid mobile format', name: _passedVeridateMobile.toString());
    return _passedVeridateMobile;
  }

  Future<bool> _verifyEmailMobileNo(String email, String mobileno) async {
    if (mobileno.isEmpty || email.isEmpty) {
      log('email or mobile is empty', name: _passedVeridateEmail.toString());
      setState(() {
        _validateMobileNo = true;
        _validateEmail = true;
      });
    } else {
      final url = Uri(
        scheme: 'http',
        host: 'localhost',
        port: 1323,
        path: 'verify/email/$email/mobile/$mobileno',
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
        if (data['isRegisteredMobileNo'] || data['isRegisteredEmail']) {
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
        } else {
          log('registered mobile no',
              name: data['registeredMobileNo'].toString());
          _passedVeridateEmailMobile = true;
          log('verified mobile no: ${_passedVeridateEmailMobile.toString()}');
        }
        setState(() {
          _passedVeridateEmailMobile = true;
          _validateMobileNo = false;
          // _loadingMobile = false;
          _validateEmail = false;
          // _loadingEmail = false;
          // isPassedMobileChecked = true;
        });
      }

      if (data['isInvalidMobileNoFormat']) {
        log('invalid mobile format',
            name: _passedVeridateEmailMobile.toString());
        setState(() {
          _emailError = 'กรุณาใส่อีเมลให้ถูกต้อง';
          _validateEmail = true;
          // _loadingEmail = false;
          _mobilenoError = 'กรุณาใส่หมายเลขโทรศัพท์มือถือให้ถูกต้อง';
          _validateMobileNo = true;
          // _loadingMobile = false;
          // isPassedMobileChecked = false;
        });
      }
    }
    log('verify mobile $_passedVeridateEmailMobile');
    return _passedVeridateEmailMobile;
  }

  void gotoNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // return  IDCardPage();
          log('goto idcard page');
          return IDCardPage(
            preinfo: Preinfo(
                thtitle: thValue!,
                thname: _thname.text,
                thsurname: _thsurname.text,
                engtitle: engValue!,
                engname: _enname.text,
                engsurname: _ensurname.text,
                email: _email.text,
                mobile: _mobileno.text,
                agreement: isPersonalAgreementChecked),
          );
        },
      ),
    );
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

  Widget dropdownButtonBuilder({
    required String? value,
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
    bool? errorCondition,
    String? errorMessage,
  }) {
    errorCondition = errorCondition ?? false;
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        errorText: errorCondition ? errorMessage : null,
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

  Widget nextButtonWidget({
    required Function() onpressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: onpressed,
      child: const Icon(
        Icons.arrow_right_alt,
        size: 30,
        color: Colors.white,
      ),
    );
  }

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
      errorCondition: _validateTHTitle,
      errorMessage: 'กรุณาใส่คำนำหน้าชื่อ (ภาษาไทย)',
    );
    final engField = dropdownButtonBuilder(
      value: engValue,
      label: engLabel,
      items: engList,
      onChanged: (value) {
        thValue = value!;
        engValue = engToTh(value);
      },
      errorCondition: _validateEnTitle,
      errorMessage: 'กรุณาใส่คำนำหน้าชื่อ (ภาษาอังกฤษ)',
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
                const Spacer(
                  flex: 5,
                ),
                SizedBox(
                  child: misc.subjectText(
                      subject: 'กรุณากรอกข้อมูลเพื่อเปิดบัญชี'),
                ),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: thField,
                      // child: THdropdownButton(),
                    ),
                    const Spacer(
                      flex: 13,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: misc.importantTextField(
                          textController: _thname,
                          errorTextCondition: _validateTHName,
                          errorTextMessage: 'กรุณาใส่ชื่อ (ภาษาไทย)',
                          subject: 'ชื่อ (ภาษาไทย)',
                          filterPattern: RegExp(r'[ก-๛]')),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 12,
                      child: misc.importantTextField(
                          textController: _thsurname,
                          errorTextCondition: _validateTHSurName,
                          errorTextMessage: 'กรุณาใส่นามสกุล (ภาษาไทย)',
                          subject: 'นามสกุล (ภาษาไทย)',
                          filterPattern: RegExp(r'[ก-๛]')),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: engField,
                    ),
                    const Spacer(
                      flex: 13,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: misc.importantTextField(
                          textController: _enname,
                          errorTextCondition: _validateEnName,
                          errorTextMessage: 'กรุณาใส่ชื่อ (ภาษาอังกฤษ)',
                          subject: 'ชื่อ (ภาษาอังกฤษ)',
                          filterPattern: RegExp(r'[a-zA-Z]')),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 12,
                      child: misc.importantTextField(
                          textController: _ensurname,
                          errorTextCondition: _validateEnSurName,
                          errorTextMessage: 'กรุณาใส่นามสกุล (ภาษาอังกฤษ)',
                          subject: 'นามสกุล (ภาษาอังกฤษ)',
                          filterPattern: RegExp(r'[a-zA-Z]')),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
                SizedBox(
                  child: misc.subjectText(
                    subject:
                        'ข้อมูลสำหรับรับ Username, Password และเอกสารจากทางบริษัทฯ',
                    color: Colors.blue,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.lightBlue,
                    ),
                    Expanded(
                      flex: 3,
                      child: misc.importantTextField(
                        textController: _email,
                        errorTextCondition: _validateEmail,
                        errorTextMessage: _emailError,
                        subject: 'อีเมล',
                        filterPattern: RegExp(r'[a-zA-Z0-9@.]'),
                        onsubmittedFunction: (value) async {
                          final isPassed = await _verifyEmail(value);
                          setState(() {
                            isPassedEmailChecked = isPassed;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_iphone,
                      color: Colors.lightBlue,
                    ),
                    Expanded(
                      flex: 5,
                      child: misc.importantTextField(
                          textController: _mobileno,
                          errorTextCondition: _validateMobileNo,
                          errorTextMessage: _mobilenoError,
                          subject: 'หมายเลขโทรศัพท์มือถือ',
                          onsubmittedFunction: (value) async {
                            final isPassed = await _verifyMobileNo(value);
                            setState(() {
                              isPassedMobileChecked = isPassed;
                              // _isPassedVeridateMobile = true;
                            });
                          },
                          filterPattern: RegExp(r'[0-9]')),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                const Row(children: [
                  Expanded(flex: 1, child: CheckboxPersonalAggreement()),
                  Expanded(
                    flex: 18,
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
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 14,
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
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.orange,
                            onPressed: () async {
                              isPassedEmailMobileChecked =
                                  await _verifyEmailMobileNo(
                                      _email.text, _mobileno.text);
                              if (_thname.text.trim().isEmpty) {
                                _validateTHName = true;
                              }
                              if (_thsurname.text.trim().isEmpty) {
                                _validateTHSurName = true;
                              }
                              if (_enname.text.trim().isEmpty) {
                                _validateEnName = true;
                              }
                              if (_ensurname.text.trim().isEmpty) {
                                _validateEnSurName = true;
                              }
                              // if (thValue!.isEmpty) {_validateTHTitle = true;}
                              // if (engValue!.isEmpty) {_validateEnTitle = true;}

                              if (_thname.text.trim().isNotEmpty &&
                                  _thsurname.text.trim().isNotEmpty &&
                                  _enname.text.trim().isNotEmpty &&
                                  _ensurname.text.trim().isNotEmpty &&
                                  _email.text.trim().isNotEmpty &&
                                  _mobileno.text.trim().isNotEmpty &&
                                  isPersonalAgreementChecked &&
                                  isPassedEmailMobileChecked) {
                                log('''title: $thValue name: ${_thname.text} surname: ${_thsurname.text}
                                title: $engValue name: ${_enname.text} surname: ${_ensurname.text}
                                email: ${_email.text}, mobile: ${_mobileno.text}, agreement: $isPersonalAgreementChecked''');

                                gotoNextPage();
                              }
                            },
                            child: const Icon(
                              Icons.arrow_right_alt,
                              size: 50,
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
